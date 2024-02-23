library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;   


entity tangyRiscVSOCTop is

generic(
   instBlitter3DAcceleration:    boolean := true;
   instFastFloatingMath:         boolean := false;
   instHidUSBHost:               boolean := true;
   instI2SAudio:                 boolean := true
);

port(
	
	--onboard peripherals
	
	--Ext pll clock 25MHz
	extPllClock25:      in      std_logic;   -- pin 10, aux pll output 0
	
    --exp pll clock 12MHz
    extPllClock12:      in      std_logic;   -- pin 11, aux pll output 1

    --onboard osc 27
    oscClock27:         in      std_logic;   -- pin 4

	--reset
    buttonReset:        in      std_logic;   -- high active

    --buttonUser
    buttonUser:         in      std_logic;   -- high active
	
    --leds
    leds:               out     std_logic_vector( 5 downto 0 );
   
    --rgb led
    rgbLedDout:         out     std_logic;

    --hdmi
    O_tmds_clk_p:       out     std_logic;
    O_tmds_clk_n:       out     std_logic;
    O_tmds_data_p:      out     std_logic_vector( 2 downto 0 );
    O_tmds_data_n:      out     std_logic_vector( 2 downto 0 );

    dviCEC:             inout   std_logic;
    dviEdidClk:         inout   std_logic;
    dviEdidDat:         inout   std_logic;
	
    --i2s
    i2sSDMode:          out     std_logic;
    i2sBClk:            out     std_logic;
    i2sLRCk:            out     std_logic;
    i2sDOut:            out     std_logic;
       
	--ext uart
	extUartTx:	        out     std_logic;
	extUartRx:	        in      std_logic;

    --tang uart
    tangUartTx:         out     std_logic;
    tangUartRx:         in      std_logic;

    --sd card 
	sdMciDat:	        inout   std_logic_vector( 3 downto 0 );	
	sdMciCmd:	        out     std_logic;	
	sdMciClk:	        out 	std_logic;	

    --usb host
    usbhDP:             inout   std_logic;  -- D+ pin 27
    usbhDM:             inout   std_logic;  -- D- pin 28

    --internal sdram
    O_sdram_clk:        out     std_logic;
	O_sdram_cke:        out     std_logic;
	O_sdram_cs_n:       out     std_logic;
	O_sdram_cas_n:      out     std_logic;
	O_sdram_ras_n:      out     std_logic;
	O_sdram_wen_n:      out     std_logic;
	O_sdram_dqm:        out     std_logic_vector(3 downto 0);
	O_sdram_addr:       out     std_logic_vector(10 downto 0);
	O_sdram_ba:         out     std_logic_vector(1 downto 0);
	IO_sdram_dq:        inout   std_logic_vector(31 downto 0)
	
);
end tangyRiscVSOCTop;

architecture behavior of tangyRiscVSOCTop is    


--components

component pllHDMI
    port (
        clkout: out std_logic;
        lock: out std_logic;
        clkoutp: out std_logic;
        clkoutd3: out std_logic;
        reset: in std_logic;
        clkin: in std_logic
    );
end component;

component pllSystem
    port (
        clkout: out std_logic;
        lock: out std_logic;
        clkoutp: out std_logic;
        clkoutd: out std_logic;
        reset: in std_logic;
        clkin: in std_logic
    );
end component;

component clkdiv5
    port (
        clkout: out std_logic;
        hclkin: in std_logic;
        resetn: in std_logic
    );
end component;

component DVI_TX_Top
	port (
		I_rst_n: in std_logic;
		I_serial_clk: in std_logic;
		I_rgb_clk: in std_logic;
		I_rgb_vs: in std_logic;
		I_rgb_hs: in std_logic;
		I_rgb_de: in std_logic;
		I_rgb_r: in std_logic_vector(7 downto 0);
		I_rgb_g: in std_logic_vector(7 downto 0);
		I_rgb_b: in std_logic_vector(7 downto 0);
		O_tmds_clk_p: out std_logic;
		O_tmds_clk_n: out std_logic;
		O_tmds_data_p: out std_logic_vector(2 downto 0);
		O_tmds_data_n: out std_logic_vector(2 downto 0)
	);
end component; 

-- font rom
component fontProm
    port (
        dout: out std_logic_vector(7 downto 0);
        clk: in std_logic;
        oce: in std_logic;
        ce: in std_logic;
        reset: in std_logic;
        ad: in std_logic_vector(10 downto 0)
    );
end component;

-- text mode pixel and sync gen
component pixelGenTxt
    port(
        --reset
        reset:          in  std_logic;
        pgClock:        in  std_logic;
        pgVSync:        out std_logic;
        pgHSync:        out std_logic;
        pgDe:           out std_logic;
        pgR:            out std_logic_vector( 7 downto 0 );
        pgG:            out std_logic_vector( 7 downto 0 );
        pgB:            out std_logic_vector( 7 downto 0 );

        fontRomA:       out std_logic_vector( 10 downto 0 );
        fontRomDout:    in  std_logic_vector( 7 downto 0 );

        videoRamBA:     out std_logic_vector( 13 downto 0 );
        videoRamBDout:  in  std_logic_vector( 15 downto 0 );
        
        pgXCount:       out std_logic_vector( 11 downto 0 );
        pgYCount:       out std_logic_vector( 11 downto 0 );
        pgDeX:          out std_logic;
        pgDeY:          out std_logic;
        pgPreFetchLine: out std_logic;
        pgFetchEnable:  out std_logic;
    
        pgVideoMode:      in  std_logic_vector( 1 downto 0 )
    );
end component;

-- gfx pixel gen
component pixelGenGfx is
port(
   reset:            in  std_logic;
   pggClock:         in  std_logic;
   pggR:             out std_logic_vector( 7 downto 0 );
   pggG:             out std_logic_vector( 7 downto 0 );
   pggB:             out std_logic_vector( 7 downto 0 );

    --gfx buffer ram
   gfxBufRamDOut:    in  std_logic_vector( 31 downto 0 );
   gfxBufRamRdA:     out std_logic_vector( 8 downto 0 );

   --2 dma requests
   pggDMARequest:    out std_logic_vector( 1 downto 0 );
   
   --sync gen outputs
   pgVSync:          in  std_logic;
   pgHSync:          in  std_logic;
   pgDe:             in  std_logic;
   pgXCount:         in  std_logic_vector( 11 downto 0 );
   pgYCount:         in  std_logic_vector( 11 downto 0 );
   pgDeX:            in  std_logic;
   pgDeY:            in  std_logic;
   pgPreFetchLine:   in  std_logic;
   pgFetchEnable:    in  std_logic;

   pgVideoMode:      in  std_logic_vector( 1 downto 0 );
   pgEnabled:        in  std_logic

   );
end component;


component inputSync is
generic(

    inputWidth              : integer := 1

);

port(

    clock:                          in  std_logic;

    signalInput:                    in  std_logic_vector( inputWidth - 1 downto 0 );
    signalOutput:                   out std_logic_vector( inputWidth - 1 downto 0 )

);
end component;

component systemRam
    port (
        douta:          out std_logic_vector(31 downto 0);
        doutb:          out std_logic_vector(31 downto 0);
        clka:           in std_logic;
        ocea:           in std_logic;
        cea:            in std_logic;
        reseta:         in std_logic;
        wrea:           in std_logic;
        clkb:           in std_logic;
        oceb:           in std_logic;
        ceb:            in std_logic;
        resetb:         in std_logic;
        wreb:           in std_logic;
        ada:            in std_logic_vector(12 downto 0);
        dina:           in std_logic_vector(31 downto 0);
        adb:            in std_logic_vector(12 downto 0);
        dinb:           in std_logic_vector(31 downto 0)
    );
end component;

-- riscv cpu
component picorv32 is   
   port
   (
      clk:           in  std_logic;
      resetn:        in  std_logic;
      trap:          out std_logic;
      mem_valid:     out std_logic;
      mem_instr:     out std_logic;
      mem_ready:     in  std_logic;

      mem_addr:      out std_logic_vector( 31 downto 0 );
      mem_wdata:     out std_logic_vector( 31 downto 0 );
      mem_wstrb:     out std_logic_vector( 3 downto 0 );
      mem_rdata:     in  std_logic_vector( 31 downto 0 );

      --Look-Ahead Interface
      mem_la_read:   out std_logic;
      mem_la_write:  out std_logic;
      mem_la_addr:   out std_logic_vector( 31 downto 0 );
      mem_la_wdata:  out std_logic_vector( 31 downto 0 );
      mem_la_wstrb:  out std_logic_vector( 3 downto 0 );

      --Pico Co-Processor Interface (PCPI)
      pcpi_valid:    out std_logic;
      pcpi_insn:     out std_logic_vector( 31 downto 0 );
      pcpi_rs1:      out std_logic_vector( 31 downto 0 );
      pcpi_rs2:      out std_logic_vector( 31 downto 0 );
      pcpi_wr:       in  std_logic;
      pcpi_rd:       in  std_logic_vector( 31 downto 0 );
      pcpi_wait:     in  std_logic;
      pcpi_ready:    in  std_logic;

      --IRQ Interface
      irq:           in  std_logic_vector( 31 downto 0 );
      eoi:           out std_logic_vector( 31 downto 0 );

      --Trace Interface
      trace_valid:   out std_logic;
      trace_data:    out std_logic_vector( 35 downto 0 )

);
end component;


-- UART
component UART
    port(
      --cpu interface
      reset:            in    std_logic;
      clock:            in    std_logic;
      a:                in    std_logic_vector( 15 downto 0 );
      din:              in    std_logic_vector( 31 downto 0 );
      dout:             out   std_logic_vector( 31 downto 0 );
      
      ce:               in    std_logic;
      wr:               in    std_logic;
      dataMask:         in    std_logic_vector( 3 downto 0 );
      
      ready:            out   std_logic;
      
      --uart interface
      uartTXD:          out std_logic;
      uartRXD:          in  std_logic
    );
end component;

-- SPI
component SPI is
port(

   --cpu interface
   reset:      in  std_logic;
   clock:      in  std_logic;

   a:          in    std_logic_vector( 15 downto 0 );
   din:        in    std_logic_vector( 31 downto 0 );
   dout:       out   std_logic_vector( 31 downto 0 );
   
   ce:         in    std_logic;
   wr:         in    std_logic;
   dataMask:   in    std_logic_vector( 3 downto 0 );
   
   ready:      out   std_logic;
   
   --spi interface
   sclk:       out std_logic;
   mosi:       out std_logic;
   miso:       in  std_logic
   
);
end component;

-- usb host
component usbHost is
port(

   --cpu interface
   reset:            in    std_logic;
   clock:            in    std_logic;
   a:                in    std_logic_vector( 15 downto 0 );
   din:              in    std_logic_vector( 31 downto 0 );
   dout:             out   std_logic_vector( 31 downto 0 );
   
   ce:               in    std_logic;
   wr:               in    std_logic;
   dataMask:         in    std_logic_vector( 3 downto 0 );
   
   ready:            out   std_logic;
   
   --usb phy clock (12MHz)
   usbHClk:          in    std_logic;
   
   --usb host interfaces
   usbH0Dp:          inout std_logic;     
   usbH0Dm:          inout std_logic      

);
end component;

-- sdram controller with dma
component sdramController is
port(

    reset:      in  std_logic;
    clock:      in  std_logic;
    clockSdram: in  std_logic;

    --gfx display mode interface ( ch0 )
    ch0DmaRequest:       in  std_logic_vector( 1 downto 0 );
    ch0DmaPointerStart:  in  std_logic_vector( 20 downto 0 );
    ch0DmaPointerReset:  in  std_logic;
   
    ch0BufClk:           in  std_logic;
    ch0BufDout:          out std_logic_vector( 31 downto 0 );
    ch0BufA:             in  std_logic_vector( 8 downto 0 );
   
      
    --audio interface ( ch1 ) - read only
    ch1DmaRequest:  in  std_logic;
    ch1A:           in  std_logic_vector( 20 downto 0 );
    ch1Dout:        out std_logic_vector( 31 downto 0 );
    ch1Ready:       out std_logic;
   
   
    --blitter interface ( ch2 )
    ch2DmaRequest: in  std_logic;
    ch2A:          in  std_logic_vector( 21 downto 0 );
    ch2Din:        in  std_logic_vector( 31 downto 0 );
    ch2Dout:       out std_logic_vector( 31 downto 0 );
    ch2RWn:        in  std_logic;
    ch2WordSize:   in  std_logic;
    ch2DataMask:   in  std_logic_vector( 1 downto 0 );
    ch2Ready:      out std_logic;
   
   
    --cpu interface ( ch3 )
    a:          in  std_logic_vector( 20 downto 0 );
    din:        in  std_logic_vector( 31 downto 0 );
    dout:       out std_logic_vector( 31 downto 0 );
   
    ce:         in  std_logic;
    wr:         in  std_logic;
    dataMask:   in  std_logic_vector( 3 downto 0 );
   
    ready:      out std_logic; 
   
   
    --sdram interface
    O_sdram_clk:        out std_logic;
	O_sdram_cke:        out std_logic;
	O_sdram_cs_n:       out std_logic;
	O_sdram_cas_n:      out std_logic;
	O_sdram_ras_n:      out std_logic;
	O_sdram_wen_n:      out std_logic;
	O_sdram_dqm:        out std_logic_vector(3 downto 0);
	O_sdram_addr:       out std_logic_vector(10 downto 0);
	O_sdram_ba:         out std_logic_vector(1 downto 0);
	IO_sdram_dq:        inout std_logic_vector(31 downto 0)
);
end component;


-- blitter
component blitter is

generic(
   inst3DAcceleration:     boolean := false
);

port(

   --cpu interface

   reset:            in    std_logic;
   clock:            in    std_logic;
   a:                in    std_logic_vector( 15 downto 0 );
   din:              in    std_logic_vector( 31 downto 0 );
   dout:             out   std_logic_vector( 31 downto 0 );
   
   ce:               in    std_logic;
   wr:               in    std_logic;
   dataMask:         in    std_logic_vector( 3 downto 0 );
   
   ready:            out   std_logic;
   
   --dma interface
   
   dmaDin:           in    std_logic_vector( 31 downto 0 );
   dmaDout:          out   std_logic_vector( 31 downto 0 );
   
   dmaA:             out   std_logic_vector( 21 downto 0 );
   dmaRWn:           out   std_logic;
   dmaRequest:       out   std_logic;
   dmaTransferSize:  out   std_logic;
   dmaTransferMask:  out   std_logic_vector( 1 downto 0 );
   dmaReady:         in    std_logic

);

end component;

-- fp alu
component fpAlu is
port(
   reset:      in    std_logic;
   clock:      in    std_logic;
   a:          in    std_logic_vector( 15 downto 0 );
   din:        in    std_logic_vector( 31 downto 0 );
   dout:       out   std_logic_vector( 31 downto 0 );
   
   ce:         in    std_logic;
   wr:         in    std_logic;
   dataMask:   in    std_logic_vector( 3 downto 0 );
   
   ready:      out   std_logic
);

end component;


-- i2s ( audio ) controller
component i2sController is
port(

    --cpu interface
    reset:      in  std_logic;
    clock:      in  std_logic;
    a:          in  std_logic_vector( 15 downto 0 );
    din:        in  std_logic_vector( 31 downto 0 );
    dout:       out std_logic_vector( 31 downto 0 );
	
    ce:         in  std_logic;
    wr:         in  std_logic;
    dataMask:   in  std_logic_vector( 3 downto 0 );
	
    ready:      out	std_logic;
	
    --dma interface
    dmaRequest: out std_logic;
    dmaA:       out std_logic_vector( 20 downto 0 );
    dmaDin:     in  std_logic_vector( 31 downto 0 );
    dmaReady:   in  std_logic;

    --i2s interface	
    i2sBClk:    out std_logic;
    i2sLRCk:    out std_logic;
    i2sDOut:    out std_logic
);
end component;

-- signals

-- clocks

-- domain 1 - pllHDMI
signal clk25:           std_logic;
signal clk125:          std_logic;
signal clk125ps:        std_logic;
signal clk41_66:        std_logic;

-- domain 2 - pllSystem
signal clkd2_80:       std_logic;
signal clkd2_80ps:     std_logic;
signal clkd2_40:       std_logic;
signal clkd2_20:       std_logic;

-- reset
signal reset:           std_logic;
signal resetn:          std_logic; 


-- hdmi pll
signal pllHDMILocked:   std_logic;

-- hdmi encoder
signal dviClock:        std_logic;
signal dviVs:           std_logic;
signal dviHs:           std_logic;
signal dviDe:           std_logic;
signal dviR:            std_logic_vector(7 downto 0);
signal dviG:            std_logic_vector(7 downto 0);
signal dviB:            std_logic_vector(7 downto 0); 

--gowin sdram controller signals
signal sdramClock:      std_logic;

-- video mux signals
signal   vmMode:        std_logic_vector( 15 downto 0 );

-- font rom signals
signal   fontRomA:        std_logic_vector( 10 downto 0 );
signal   fontRomDout:     std_logic_vector( 7 downto 0 );


-- txt pixel gen signals
signal   pgClock:          std_logic;
signal   pgVSync:          std_logic;
signal   pgHSync:          std_logic;
signal   pgDe:             std_logic;
signal   pgR:              std_logic_vector( 7 downto 0 );
signal   pgG:              std_logic_vector( 7 downto 0 );
signal   pgB:              std_logic_vector( 7 downto 0 ); 
signal   pgXCount:         std_logic_vector( 11 downto 0 );
signal   pgYCount:         std_logic_vector( 11 downto 0 );
signal   pgDeX:            std_logic;
signal   pgDeY:            std_logic;
signal   pgPreFetchLine:   std_logic;
signal   pgFetchEnable:    std_logic;
signal   videoRamBDout:    std_logic_vector( 15 downto 0 );
signal   videoRamBA:       std_logic_vector( 13 downto 0 );

-- vsync signal synchronised to cpu clock domain
signal   pgVSyncClkD2:     std_logic;

-- gfx pixel gen signals
signal   pgEnabled:        std_logic;
signal   pggR:             std_logic_vector( 7 downto 0 );
signal   pggG:             std_logic_vector( 7 downto 0 );
signal   pggB:             std_logic_vector( 7 downto 0 ); 
signal   pggDMARequest:    std_logic_vector( 1 downto 0 );

-- system ram signals
signal  fpgaCpuMemoryClock:         std_logic;

signal  systemRAMCE:                std_logic;
signal  systemRamReady:             std_logic;
signal  systemRamDoutForCPU:        std_logic_vector( 31 downto 0 );
signal  systemRamDoutForPixelGen:   std_logic_vector( 31 downto 0 );
signal  systemRamDataIn:            std_logic_vector( 31 downto 0 );
signal  systemRamWr:                std_logic;

type    systemRamAccessState_T is ( srasIdle, srasRead0, srasReadModifyWrite0, srasReadModifyWrite1, srasReadModifyWrite2 );
signal  systemRamAccessState:       systemRamAccessState_T;

--cpu signals
signal cpuClock:        std_logic;
signal cpuResetn:       std_logic;
signal cpuAOut:         std_logic_vector( 29 downto 0 );
signal cpuDOut:         std_logic_vector( 31 downto 0 );

signal cpuMemValid:		std_logic;
signal cpuMemInstr:		std_logic; 
signal cpuMemReady:		std_logic;
signal cpuAOutFull:		std_logic_vector( 31 downto 0 );
signal cpuWrStrobe:		std_logic_vector( 3 downto 0 );
signal cpuDin:			std_logic_vector( 31 downto 0 );

signal cpuWr:			std_logic;
signal cpuDataMask:		std_logic_vector( 3 downto 0 );

--cpu resetgen
signal cpuResetGenCounter:  std_logic_vector( 15 downto 0 ); 

-- gpo signals
signal   gpoRegister:      std_logic_vector( 7 downto 0 );

-- registers signals
signal   registersClock:      std_logic;

type     regState_T is ( rsWaitForRegAccess, rsWaitForBusCycleEnd );
signal   registerState:       regState_T;

signal   registersCE:         std_logic;
signal   registersDoutForCPU: std_logic_vector( 31 downto 0 );

-- tick timer signals
signal   tickTimerClock:            std_logic;
signal   tickTimerReset:            std_logic;
signal   tickTimerPrescalerCounter: std_logic_vector( 31 downto 0 );
signal   tickTimerCounter:          std_logic_vector( 31 downto 0 );

constant tickTimerPrescalerValue:   integer:=   40000 - 1;  --1ms tick timer @40MHz

-- frameTimer signals
signal   frameTimerClock:        std_logic;
signal   frameTimerReset:        std_logic;
signal   frameTimerPgPrvVSync:   std_logic;
signal   frameTimerValue:        std_logic_vector( 31 downto 0 );

-- dma signals
signal   sdramDmaClock:          std_logic;
                     
-- dma ch0 buf ram signals ( for gfx pixel gen )
signal   gfxBufRamDOut:          std_logic_vector( 31 downto 0 );
signal   gfxBufRamRdA:           std_logic_vector( 8 downto 0 );
signal   dmaDisplayPointerStart: std_logic_vector( 20 downto 0 );

-- dma ch1 signals ( audio )
signal  dmaCh1Request:          std_logic;
signal  dmaCh1A:                std_logic_vector( 20 downto 0 );
signal  dmaCh1Dout:             std_logic_vector( 31 downto 0 );
signal  dmaCh1Ready:            std_logic;

-- dma ch2 signals (blitter)
signal   dmaCh2Request:          std_logic;
signal   dmaCh2Ready:            std_logic;
signal   dmaCh2RWn:              std_logic;
signal   dmaCh2Din:              std_logic_vector( 31 downto 0 );
signal   dmaCh2Dout:             std_logic_vector( 31 downto 0 );
signal   dmaCh2A:                std_logic_vector( 21 downto 0 );
signal   dmaCh2TransferSize:     std_logic;
signal   dmaCh2TransferMask:     std_logic_vector( 1 downto 0 );

-- dma ch3 signals ( cpu )
signal   dmaMemoryCE:            std_logic;
signal   cpuDmaReady:            std_logic;
signal   dmaDoutForCPU:          std_logic_vector( 31 downto 0 );


-- uart signals
signal   uartClock:           std_logic;

signal   uartCE:              std_logic;
signal   uartDoutForCPU:      std_logic_vector( 31 downto 0 );
signal   uartReady:           std_logic;

signal   uartTxd:             std_logic;
signal   uartRxd:             std_logic;

-- SPI signals
signal   spiClock:         std_logic;
signal   spiCE:            std_logic;
signal   spiDoutForCPU:    std_logic_vector( 31 downto 0 );
signal   spiReady:         std_logic;

signal   spiSClk:          std_logic;
signal   spiMOSI:          std_logic;
signal   spiMISO:          std_logic;

-- usb host signals
signal   usbHostClock:           std_logic;
signal   usbHostCE:              std_logic;
signal   usbHostReady:           std_logic;
signal   usbHostDoutForCPU:      std_logic_vector( 31 downto 0 );

-- usb phy clock ( 12 MHz )
signal   usbHClk:                std_logic;

-- blitter signals
signal   blitterClock:           std_logic;
signal   blitterCE:              std_logic;
signal   blitterReady:           std_logic;
signal   blitterDoutForCPU:      std_logic_vector( 31 downto 0 );

-- fpalu signals
signal   fpAluClock:       std_logic;
signal   fpAluCE:          std_logic;
signal   fpAluDoutForCPU:  std_logic_vector( 31 downto 0 );
signal   fpAluReady:       std_logic;

-- i2s controller signals
signal  i2sControllerClock: std_logic;
signal  i2sCE:              std_logic;
signal  i2sDoutForCPU:      std_logic_vector( 31 downto 0 );
signal  i2sReady:           std_logic;


begin


-- reset logic based on pll lock

    reset   <= not pllHDMILocked;
    resetn  <= not reset;


-- clock configuration

-- txt / gfx pixel gen clock
    pgClock             <= clk25;
   
-- hdmi encoder clock
    dviClock            <= clk125;

-- cpu clock
    cpuClock            <= clkd2_40;

-- fpga cpu memory clock ( system RAM )
    fpgaCpuMemoryClock  <= clkd2_80;

-- registers process clock
    registersClock      <= clkd2_80;

-- tick timer clock
    tickTimerClock      <= clkd2_40;

-- frame timer process clock (not timer clock)
    frameTimerClock     <= clkd2_80;

-- uart clock
    uartClock           <= clkd2_80;

-- spi clock
    spiClock            <= clkd2_40;

-- sdram direct memory access clock
    sdramDmaClock       <= clkd2_80;
    
-- sdram chip clock

    sdramClock          <= clkd2_80ps;

-- usb host clock
    usbHostClock         <= clkd2_80;

--usb phy clock ( 12MHz )
    usbHClk              <= extPllClock12;

--blitter clock
    blitterClock        <= clkd2_80;

--floating point memory mapped alu clock
    fpaluClock          <= clkd2_80;

--i2s controller clock
    i2sControllerClock  <= clkd2_80;


-- leds
    leds    <= gpoRegister( 7 downto 2 ); 

-- place hdmi pll
pllHDMIInst:pllHDMI
    port map(
        clkout      => clk125,
        lock        => pllHDMILocked,
        clkoutp     => clk125ps,
        clkoutd3    => clk41_66,
        reset       => buttonReset,
        clkin       => extPllClock25
    );


-- place clkdiv5
clkdiv5Inst:clkdiv5
    port map(
        clkout  => clk25,
        hclkin  => clk125,
        resetn  => resetn
    );

-- place system pll
pllSystemInst: pllSystem
    port map(
        clkout      => clkd2_80,
--      lock        => 
        clkoutp     => clkd2_80ps,
        clkoutd     => clkd2_40,
        reset       => buttonReset,
        clkin       => extPllClock25
    ); 



-- place hdmi encoder
    dviCEC      <= 'Z';
    dviEdidClk  <= 'Z';
    dviEdidDat  <= 'Z';


DVI_TX_TopInst: DVI_TX_Top
	port map(
		I_rst_n         => resetn,
		I_serial_clk    => dviClock,
		I_rgb_clk       => pgClock,
		I_rgb_vs        => dviVs,
		I_rgb_hs        => dviHs,
		I_rgb_de        => dviDe,
		I_rgb_r         => dviR,
		I_rgb_g         => dviG,
		I_rgb_b         => dviB,
		O_tmds_clk_p    => O_tmds_clk_p,
		O_tmds_clk_n    => O_tmds_clk_n,
		O_tmds_data_p   => O_tmds_data_p,
		O_tmds_data_n   => O_tmds_data_n
	); 


--place font rom
fontPromInst:fontProm
port map(
    dout    => fontRomDout,
    clk     => pgClock,
    oce     => '1',
    ce      => '1',
    reset   => reset,
    ad      => fontRomA
);


--place txt pixel gen
pixelGenInst: pixelGenTxt
port map(
    reset           => reset,
    pgClock         => pgClock,

    pgVSync         => pgVSync,
    pgHSync         => pgHSync,
    pgDe            => pgDe,
    pgR             => pgR,
    pgG             => pgG,
    pgB             => pgB,

    fontRomA        => fontRomA,
    fontRomDout     => fontRomDout,

    videoRamBA      => videoRamBA,
    videoRamBDout   => videoRamBDout,
        
    pgXCount        => pgXCount,
    pgYCount        => pgYCount,
    pgDeX           => pgDeX,
    pgDeY           => pgDeY,
    pgPreFetchLine  => pgPreFetchLine,
    pgFetchEnable   => pgFetchEnable,
      
    pgVideoMode       => vmMode( 3 downto 2 )
        
);   

-- place vsync signal synchroniser

pgVsyncInputSyncInst:inputSync
generic map(
    inputWidth  => 1
)
port map(
    clock               => clkd2_80,
    signalInput( 0 )    => pgVSync,
    signalOutput( 0 )   => pgVSyncClkD2
);



-- place gfx pixel gen

pgEnabled   <= '1' when vmMode( 1 downto 0 ) /= "00" else '0';

pixelGenGfxInst: pixelGenGfx
port map(
    reset             => reset,
    pggClock          => pgClock,

    pggR              => pggR,
    pggG              => pggG,
    pggB              => pggB,

    --gfx buffer ram
    gfxBufRamDOut     => gfxBufRamDOut,
    gfxBufRamRdA      => gfxBufRamRdA,

    --2 dma requests
    pggDMARequest     => pggDMARequest,

    --sync gen outputs
    pgVSync           => pgVSync,
    pgHSync           => pgHSync,
    pgDe              => pgDe,
    pgXCount          => pgXCount,
    pgYCount          => pgYCount,
    pgDeX             => pgDeX,
    pgDeY             => pgDeY,
    pgPreFetchLine    => pgPreFetchLine,
    pgFetchEnable     => pgFetchEnable,

    pgVideoMode       => vmMode( 5 downto 4 ),
    pgEnabled         => pgEnabled
);

--place system ram

systemRamInst:systemRam
port map(
    clka        => fpgaCpuMemoryClock,
    reseta      => reset,
    ada         => cpuAOut( 12 downto 0 ),
    cea         => systemRAMCE,
    ocea        => '1',
    wrea        => systemRamWr,
    dina        => systemRamDataIn,
    douta       => systemRamDoutForCPU,

    clkb        => pgClock,
    resetb      => reset,
    adb         => videoRamBA( 13 downto 1 ),
    ceb         => '1',
    oceb        => '1',
    wreb        => '0',
    dinb        => ( others => '0' ),
    doutb       => systemRamDoutForPixelGen

);


videoRamBDout   <= systemRamDoutForPixelGen( 15 downto 0 ) when videoRamBA( 0 ) = '0' else systemRamDoutForPixelGen( 31 downto 16 );


systemRamAccess: process( all )

begin

    if rising_edge( fpgaCpuMemoryClock ) then

        if reset = '1' then

            systemRamAccessState    <= srasIdle;
            systemRamDataIn         <= ( others => '0' );
            systemRamWr             <= '0';
            systemRamReady          <= '0';

        else

            case systemRamAccessState is

                when srasIdle =>

                    systemRamReady  <= '0';
                    systemRamWr     <= '0';

                    if systemRAMCE = '1' then

                        if cpuWr = '0' then

                            --read ( always 32 bit )
                            systemRamReady          <= '1';

                            systemRamAccessState    <= srasRead0;

                        else

                            if cpuDataMask = "1111" then

                                --32bit write 
                                systemRamReady          <= '1';

                                systemRamDataIn         <= cpuDOut;
                                systemRamWr             <= '1';
                                systemRamAccessState    <= srasReadModifyWrite2;
            
                            else
                        
                                --read-modify-write ( 8 or 16 bit )

                                --systemRamAccessState    <= srasReadModifyWrite1;
                                systemRamAccessState    <= srasReadModifyWrite0;

                            end if;

                        end if; -- cpuWr ='0'

                    end if; -- systemRAMCE = '1'

                when srasRead0 =>

                    systemRamReady          <= '1';

                    if systemRAMCE = '0' then

                        systemRamReady          <= '0';
                        systemRamAccessState    <= srasIdle;

                    end if;



                when srasReadModifyWrite0   =>
                    
                    --read waitstate
                    systemRamAccessState    <= srasReadModifyWrite1;

                when srasReadModifyWrite1   =>

                    --modify and write
                    if cpuDataMask( 0 ) = '1' then
                        
                        systemRamDataIn( 7 downto 0 ) <= cpuDOut( 7 downto 0 );

                    else
                        
                        systemRamDataIn( 7 downto 0 ) <= systemRamDoutForCPU( 7 downto 0 );

                    end if;

                    if cpuDataMask( 1 ) = '1' then
                        
                        systemRamDataIn( 15 downto 8 ) <= cpuDOut( 15 downto 8 );

                    else
                        
                        systemRamDataIn( 15 downto 8 ) <= systemRamDoutForCPU( 15 downto 8 );

                    end if;

                    if cpuDataMask( 2 ) = '1' then
                        
                        systemRamDataIn( 23 downto 16 ) <= cpuDOut( 23 downto 16 );

                    else
                        
                        systemRamDataIn( 23 downto 16 ) <= systemRamDoutForCPU( 23 downto 16 );

                    end if;

                    if cpuDataMask( 3 ) = '1' then
                        
                        systemRamDataIn( 31 downto 24 ) <= cpuDOut( 31 downto 24 );

                    else
                        
                        systemRamDataIn( 31 downto 24 ) <= systemRamDoutForCPU( 31 downto 24 );

                    end if;
                    
                    systemRamWr <= '1';

                    systemRamAccessState    <= srasReadModifyWrite2;

                when srasReadModifyWrite2 =>

                    systemRamReady          <= '1';

                    if systemRAMCE = '0' then

                        systemRamWr             <= '0';
                        systemRamReady          <= '0';
                        systemRamAccessState    <= srasIdle;

                    end if;

                when others =>

                    systemRamAccessState    <= srasIdle;


            end case; -- systemRamAccessState is


        end if;

    end if; --rising_edge( fpgaCpuMemoryClock )


end process;


-- place picorv32
   
-- bus signals
    cpuAOut           <= cpuAOutFull( 31 downto 2 );

    cpuWr             <= cpuWrStrobe( 3 ) or cpuWrStrobe( 2 ) or cpuWrStrobe( 1 ) or cpuWrStrobe( 0 );

    cpuDataMask       <= cpuWrStrobe when cpuWr = '1' else "1111";


-- chip selects
    systemRAMCE       <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"000" else '0';

    dmaMemoryCE       <= '1' when ( cpuMemValid = '1'  ) and cpuAOutFull( 31 downto 24 ) = x"20" else '0';
         
    registersCE       <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f00" else '0';

    fpAluCE           <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f01" else '0';
   
    blitterCE         <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f02" else '0';
    
    usbHostCE         <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f03" else '0';

    uartCE            <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f04" else '0';

    spiCE             <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f05" else '0';

    i2sCE             <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f06" else '0';


-- bus slaves ready signals mux
   cpuMemReady       <= systemRamReady when systemRAMCE = '1'
                        else uartReady when uartCE = '1' 
                        else spiReady when spiCE = '1' 
                        else usbHostReady when usbHostCE = '1' 
                        else '1' when registersCE = '1' 
                        else cpuDmaReady when dmaMemoryCE = '1' 
                        else blitterReady when blitterCE = '1' 
                        else fpAluReady when fpAluCE = '1' 
                        else i2sReady when i2sCE = '1' 
                        else '1';





-- bus slaves data outputs mux
   cpuDin            <= systemRamDoutForCPU                       when cpuAOutFull( 31 downto 20 ) = x"000" else 
                        uartDoutForCPU                            when cpuAOutFull( 31 downto 20 ) = x"f04" else
                        spiDoutForCPU                             when cpuAOutFull( 31 downto 20 ) = x"f05" else
                        usbHostDoutForCPU                         when cpuAOutFull( 31 downto 20 ) = x"f03" else 
                        registersDoutForCPU                       when cpuAOutFull( 31 downto 20 ) = x"f00" else
                        dmaDoutForCPU                             when cpuAOutFull( 31 downto 24 ) = x"20"  else
                        blitterDoutForCPU                         when cpuAOutFull( 31 downto 20 ) = x"f02" else
                        fpAluDoutForCPU                           when cpuAOutFull( 31 downto 20 ) = x"f01" else
                        i2sDoutForCPU                             when cpuAOutFull( 31 downto 20 ) = x"f06" else 
                        x"00000000";

                     
-- the cpu
   picorv32Inst: picorv32 
   port map
   (
      clk               => cpuClock,
      resetn            => cpuResetn,

      mem_valid         => cpuMemValid,
      mem_instr         => cpuMemInstr,
      mem_ready         => cpuMemReady,

      mem_addr          => cpuAOutFull,
      mem_wdata         => cpuDOut,
      mem_wstrb         => cpuWrStrobe,
      mem_rdata         => cpuDin,

      pcpi_wr           => '0',
      pcpi_rd           => ( others => '0' ),
      pcpi_wait         => '0',
      pcpi_ready        => '0',

      --IRQ Interface
      irq               => ( others => '0' )
      --eoi:            out std_logic_vector( 31 downto 0 );
);
 


--cpu resetgen process
cpuResetGen: process( all )

begin
    
    if reset = '1' then

        cpuResetn           <= '0';
        cpuResetGenCounter  <= x"ffff";

    else

        if rising_edge( cpuClock ) then

            if cpuResetGenCounter /= x"0000" then

                cpuResetn           <= '0';
                cpuResetGenCounter  <= cpuResetGenCounter - 1;
                
            else
                if buttonUser = '1' then

                    cpuResetn           <= '0';

                else

                    cpuResetn           <= '1';

                end if; --buttonUser = '1'

            end if;
        end if;
    end if;

end process;
 

--registers process
registers: process( all )

begin
   
   if rising_edge( registersClock ) then
   
      if reset = '1' then
      
         registersDoutForCPU  <= ( others => '0' );
         
         --default register values
         vmMode                  <= x"0000";
         dmaDisplayPointerStart  <= ( others => '0' );
         gpoRegister             <= "01111111";             --turn on last LED by default
         
         tickTimerReset             <= '0';
                  
         registerState              <= rsWaitForRegAccess;

      else
      
         tickTimerReset             <= '0';
         frameTimerReset            <= '0';
         
         case registerState is
         
            when rsWaitForRegAccess =>
         
               if registersCE = '1' then
                  
                  case cpuAOut( 7 downto 0 ) is
               
               
                     --rw 0xf0000000 - videoMuxMode
                     when x"00" =>
               
                        registersDoutForCPU  <= x"0000" & vmMode;
                        
                        if cpuWr = '1' then
                        
                           vmMode   <= cpuDOut( 15 downto 0 );
                        
                        end if;
               
                     --rw 0xf0000004 - videoVSync
                     when x"01" =>
               
                        registersDoutForCPU  <= x"0000" & x"000" & "000" & pgVSync;

                     --rw 0xf0000008 - dmaDisplayPointerStart
                     when x"02" =>
               
                        registersDoutForCPU  <= "00000000000" & dmaDisplayPointerStart;
                        
                        if cpuWr = '1' then
                        
                           dmaDisplayPointerStart  <= cpuDOut( 20 downto 0 );
                        
                        end if;
                                       
                     --rw 0xf000000c - gpoPort
                     when x"03" =>
               
                        registersDoutForCPU  <= x"0000" & x"00" & gpoRegister;
                        
                        if cpuWr = '1' then
                        
                           gpoRegister <= cpuDOut( 7 downto 0 );
                        
                        end if;
                        
                     ---w 0xf0000010 - tickTimerConfig
                     when x"04" =>
                                 
                        if cpuWr = '1' then
                        
                           tickTimerReset <= cpuDOut( 0 );
                        
                        end if;  
                        
                     --r- 0xf0000014 - tickTimerValue
                     when x"05" =>
                              
                        registersDoutForCPU  <= tickTimerCounter;
                           
                              
                              
                     --rw 0xf0000018 - frameTimer (write resets timer)
                     when x"06" =>
                     
                        registersDoutForCPU  <= frameTimerValue;
                     
                        if cpuWr = '1' then
                           
                              frameTimerReset <= '1';
                              
                        end if;
                                             

                     when others =>

                        registersDoutForCPU  <= ( others => '0' );
                     
                  end case; --cpuAOut( 7 downto 0 ) is
               
                  registerState  <= rsWaitForBusCycleEnd;
               
               end if; --registersCE = '1'
         
            when rsWaitForBusCycleEnd =>
                     
               --wait for bus cycle to end
               if registersCE = '0' then
               
                  registerState <= rsWaitForRegAccess;
                  
               end if;
         
            when others =>

               registerState <= rsWaitForRegAccess;
            
         end case;   --registerState is
         
      end if; --! reset = '1'
         
   end if; --rising_edge( registersClock )
   

end process;



-- place uart
extUartTx   <= uartTxd;
uartRxd     <= extUartRx;

UARTInst: UART
port map(
  reset    => reset,
  clock    => uartClock,     
  
  a        => cpuAOut( 15 downto 0 ),
  din      => cpuDOut,
  dout     => uartDoutForCPU,
  ce       => uartCE,
  wr       => cpuWr,
  dataMask => cpuDataMask,
  ready    => uartReady,        
    
  uartTXD  => uartTxd,
  uartRXD  => uartRxd
  
);  

-- place SPI   

sdMciClk    <= spiSClk;
sdMciDat(3) <= gpoRegister( 0 ); --cs
sdMciCmd    <= spiMOSI;
spiMISO     <= sdMciDat( 0 );


sdMciDat(2 downto 0 )   <= "ZZZ";

   
SPIInst:SPI
port map(

   --cpu interface
   reset       => reset,
   clock       => spiClock,

   a           => cpuAOut( 15 downto 0 ),
   din         => cpuDOut,
   dout        => spiDoutForCPU,
   
   ce          => spiCE,
   wr          => cpuWr,
   dataMask    => cpuDataMask,
   
   ready       => spiReady,
   
   --spi interface
   sclk        => spiSClk,
   mosi        => spiMOSI,
   miso        => spiMISO
   
);

instHidUSBHostGen: if ( instHidUSBHost = true ) generate

    -- place usb host
    usbHostInst: usbHost
    port map(

      --cpu interface
      reset          => reset,
      clock          => usbHostClock,
      a              => cpuAOut( 15 downto 0 ),
      din            => cpuDOut,
      dout           => usbHostDoutForCpu,
      
      ce             => usbHostCE,
      wr             => cpuWr,
      dataMask       => cpuDataMask,
      
      ready          => usbHostReady,
      
      --usb phy clock (12MHz)
      usbHClk        => usbHClk,
      
      --usb interfaces
      usbH0Dp        => usbhDp,
      usbH0Dm        => usbhDm   

    );

end generate;

-- place sdram dma 
sdramControllerInst:sdramController
port map(

    reset                   => reset,
    clock                   => sdramDmaClock,
    clockSdram              => sdramClock,

    --gfx display mode interface ( ch0 )
    ch0DmaRequest           => pggDMARequest,
    ch0DmaPointerStart      => dmaDisplayPointerStart,
    ch0DmaPointerReset      => pgVSyncClkD2,
   
    ch0BufClk               => not pgClock,
    ch0BufDout              => gfxBufRamDOut,
    ch0BufA                 => gfxBufRamRdA,
   
   
    --audio interface ( ch1 )
    ch1DmaRequest           => dmaCh1Request,
    ch1A                    => dmaCh1A,
    ch1Dout                 => dmaCh1Dout,
    ch1Ready                => dmaCh1Ready,
      

    --blitter interface ( ch2 )
    ch2DmaRequest           => dmaCh2Request,
    ch2A                    => dmaCh2A,
    ch2Din                  => dmaCh2Din,
    ch2Dout                 => dmaCh2Dout,
    ch2RWn                  => dmaCh2RWn,
    ch2WordSize             => dmaCh2TransferSize,
    ch2DataMask             => dmaCh2TransferMask,
    ch2Ready                => dmaCh2Ready,
   
   
    --cpu interface ( ch3 )
    a                       => cpuAOut( 20 downto 0 ),
    din                     => cpuDOut,
    dout                    => dmaDoutForCPU,
    ce                      => dmaMemoryCE,
    wr                      => cpuWr,
    dataMask                => cpuDataMask,
   
    ready                   => cpuDmaReady,
   
    --sdram interface
    O_sdram_clk             => O_sdram_clk,
	O_sdram_cke             => O_sdram_cke,
	O_sdram_cs_n            => O_sdram_cs_n,
	O_sdram_cas_n           => O_sdram_cas_n,
	O_sdram_ras_n           => O_sdram_ras_n,
	O_sdram_wen_n           => O_sdram_wen_n,
	O_sdram_dqm             => O_sdram_dqm,
	O_sdram_addr            => O_sdram_addr,
	O_sdram_ba              => O_sdram_ba,
	IO_sdram_dq             => IO_sdram_dq

);


-- place blitter

blitterInst:blitter
generic map(
   inst3DAcceleration   => instBlitter3DAcceleration
)
port map(

   --cpu interface

   reset          => reset,
   clock          => blitterClock,
   a              => cpuAOut( 15 downto 0 ),
   din            => cpuDOut,
   dout           => blitterDoutForCpu,
   
   ce             => blitterCE,
   wr             => cpuWr,
   dataMask       => cpuDataMask,
   
   ready          => blitterReady,
   
   --dma interface

   dmaDin            => dmaCh2Dout,
   dmaDout           => dmaCh2Din,
   
   dmaA              => dmaCh2A,
   dmaRWn            => dmaCh2RWn,
   dmaRequest        => dmaCh2Request,
   dmaTransferSize   => dmaCh2TransferSize,
   dmaTransferMask   => dmaCh2TransferMask,
   dmaReady          => dmaCh2Ready

);

instFastFloatingMathGen: if( instFastFloatingMath = true ) generate

    -- place fpAlu
    fpAluInst:fpAlu
    port map(
       reset    => reset,
       clock    => fpAluClock,
       a        => cpuAOut( 15 downto 0 ),
       din      => cpuDOut,
       dout     => fpAluDoutForCPU,
       
       ce       => fpAluCE,
       wr       => cpuWr,
       dataMask => cpuDataMask,
       
       ready    => fpAluReady
    );

else generate

    fpAluDoutForCPU <= ( others => '0' );
    fpAluReady      <= '1';

end generate;


--instI2SAudio

instI2SAudioGen: if( instI2SAudio = true ) generate


-- place i2s controller ( audio )

-- i2s dac enabled 
i2sSDMode   <= '1';


i2sControllerInst:i2sController
port map(

    --cpu interface
    reset       => reset,
    clock       => i2sControllerClock,
    a           => cpuAOut( 15 downto 0 ),
    din         => cpuDOut,
    dout        => i2sDoutForCPU,
    ce          => i2sCE,
    wr          => cpuWr,
    dataMask    => cpuDataMask,
    ready       => i2sReady,

     --dma interface
    dmaRequest  => dmaCh1Request,
    dmaA        => dmaCh1A,
    dmaDin      => dmaCh1Dout,
    dmaReady    => dmaCh1Ready,

    --i2s interface
    i2sBClk     => i2sBClk,
    i2sLRCk     => i2sLRCk,
    i2sDOut     => i2sDOut
);


else generate

--i2s dac disabled 
i2sSDMode       <= '0';

--cpu interface
i2sDoutForCPU   <= ( others => '0' );
i2sReady        <= '1';

--disable audio dma request
dmaCh1Request   <= '0';
dmaCh1A         <= ( others => '0' );

--i2s interface
i2sBClk         <= '0';
i2sLRCk         <= '0';
i2sDOut         <= '0';

end generate;


--tick timer process
tickTimer: process( all )
begin

   if rising_edge( tickTimerClock ) then
   
      if reset = '1' then
         
         tickTimerPrescalerCounter  <= ( others => '0' );
         tickTimerCounter           <= ( others => '0' );
         
      
      else
      
         if tickTimerPrescalerCounter /= x"00000000" then
            
            tickTimerPrescalerCounter <= tickTimerPrescalerCounter - 1;
            
         else
         
            tickTimerPrescalerCounter <= conv_std_logic_vector( tickTimerPrescalerValue, tickTimerPrescalerCounter'length );
            
            tickTimerCounter <= tickTimerCounter + 1;
         
         end if;
      
         if tickTimerReset = '1' then

            tickTimerPrescalerCounter  <= ( others => '0' );
            tickTimerCounter           <= ( others => '0' );
         
         end if;
         
      
      end if;  --reset = '1'
   
   
   end if; --rising_edge( tickTimerClock )

end process;


-- frame timer process
frameTimerProcess: process( all )
begin
   
   if rising_edge( frameTimerClock ) then

      if frameTimerReset = '1' then
      
         frameTimerValue <= ( others => '0' );
         
      else
      
         frameTimerPgPrvVSync <= pgVSyncClkD2;
         
         
         if frameTimerPgPrvVSync = '0' and pgVSyncClkD2 = '1' then
      
            frameTimerValue <= frameTimerValue + '1';
            
         end if;
      
      end if;
   
   end if; -- rising_edge( frameTimerClock )
end process;



--video out mux (pixelGenTxt )

videoMux: process( all )

begin

if rising_edge( pgClock ) then

    if reset = '1' then

        dviHs       <= '0';
        dviVs       <= '0';
        dviDe       <= '0';
        
        dviR		<= ( others => '0' );
        dviG        <= ( others => '0' );
        dviB        <= ( others => '0' );

    else
    
        case vmMode( 1 downto 0 ) is
        
            --text mode
            when "00" =>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;
                
                dviR		<= pgR( 7 downto 3 ) & "000";
                dviG        <= pgG( 7 downto 2 ) & "00";
                dviB        <= pgB( 7 downto 3 ) & "000";
            
            --gfx mode
            when "01"	=>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;
                
                dviR		<= pggR( 7 downto 3 ) & "000";
                dviG        <= pggG( 7 downto 2 ) & "00";
                dviB        <= pggB( 7 downto 3 ) & "000";

            --text over gfx mode
            when "10" =>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;

                if	pgR = x"00" and pgG = x"00" and pgB = x"00" then
                    
                    dviR    <= pggR( 7 downto 3 ) & "000";
                    dviG    <= pggG( 7 downto 2 ) & "00";
                    dviB    <= pggB( 7 downto 3 ) & "000";
                    
                --gray color -> dim background
                elsif pgR = x"80" and pgG = x"80" and pgB = x"80" then
            
                    dviR    <= "0" & pggR( 7 downto 4 ) & "000";
                    dviG    <= "0" & pggG( 7 downto 2 ) & "0";
                    dviB    <= "0" & pggB( 7 downto 4 ) & "000";
                    
                else

                    dviR    <= pgR( 7 downto 3 ) & "000";
                    dviG    <= pgG( 7 downto 2 ) & "00";
                    dviB    <= pgB( 7 downto 3 ) & "000";
                
                end if;

            --gfx over text mode
            when "11" =>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;


                if	pggR = x"00" and pggG = x"00" and pggB = x"00" then
                    
                    dviR    <= pgR( 7 downto 3 ) & "000";
                    dviG    <= pgG( 7 downto 2 ) & "00";
                    dviB    <= pgB( 7 downto 3 ) & "000";
                    
                else

                    dviR    <= pggR( 7 downto 3 ) & "000";
                    dviG    <= pggG( 7 downto 2 ) & "00";
                    dviB    <= pggB( 7 downto 3 ) & "000";
                    
                end if;

            when others =>
            
        end case;
    
    end if;

end if;

end process; 


end behavior;
