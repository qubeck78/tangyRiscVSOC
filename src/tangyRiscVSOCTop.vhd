library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;   


entity tangyRiscVSOCTop is
port(
	
	--onboard peripherals
	
	--Ext pll clock 25MHz
	extPllClock25:      in std_logic;   -- pin 10, aux pll output 0
	
    --exp pll clock 12MHz
    extPllClock12:      in std_logic;   -- pin 11, aux pll output 1

    --onboard osc 27
    oscClock27:         in std_logic;   -- pin 4

    
	--reset
    buttonReset:        in std_logic;   -- high active

    --buttonUser
    buttonUser:         in std_logic;   -- high active
	
    --leds
    leds:               out std_logic_vector( 5 downto 0 );
   
    --rgb led
    rgbLedDout:         out std_logic;


    --hdmi
    O_tmds_clk_p:       out std_logic;
    O_tmds_clk_n:       out std_logic;
    O_tmds_data_p:      out std_logic_vector( 2 downto 0 );
    O_tmds_data_n:      out std_logic_vector( 2 downto 0 );

    dviCEC:             inout std_logic;
    dviEdidClk:         inout std_logic;
    dviEdidDat:         inout std_logic;

	
	--ext uart
	extUartTx:	        out std_logic;
	extUartRx:	        in std_logic;

    --sd card 
	sdMciDat:	inout	std_logic_vector( 3 downto 0 );	
	sdMciCmd:	out 	std_logic;	
	sdMciClk:	out 	std_logic;	

    --usb host
    usbhDP:     inout   std_logic;  -- D+ pin 27
    usbhDM:     inout   std_logic;  -- D- pin 28

    --internal sdram
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


component SDRAM_controller_top_SIP
	port (
		O_sdram_clk: out std_logic;
		O_sdram_cke: out std_logic;
		O_sdram_cs_n: out std_logic;
		O_sdram_cas_n: out std_logic;
		O_sdram_ras_n: out std_logic;
		O_sdram_wen_n: out std_logic;
		O_sdram_dqm: out std_logic_vector(3 downto 0);
		O_sdram_addr: out std_logic_vector(10 downto 0);
		O_sdram_ba: out std_logic_vector(1 downto 0);
		IO_sdram_dq: inout std_logic_vector(31 downto 0);
		I_sdrc_rst_n: in std_logic;
		I_sdrc_clk: in std_logic;
		I_sdram_clk: in std_logic;
		I_sdrc_selfrefresh: in std_logic;
		I_sdrc_power_down: in std_logic;
		I_sdrc_wr_n: in std_logic;
		I_sdrc_rd_n: in std_logic;
		I_sdrc_addr: in std_logic_vector(20 downto 0);
		I_sdrc_data_len: in std_logic_vector(7 downto 0);
		I_sdrc_dqm: in std_logic_vector(3 downto 0);
		I_sdrc_data: in std_logic_vector(31 downto 0);
		O_sdrc_data: out std_logic_vector(31 downto 0);
		O_sdrc_init_done: out std_logic;
		O_sdrc_busy_n: out std_logic;
		O_sdrc_rd_valid: out std_logic;
		O_sdrc_wrd_ack: out std_logic
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
signal dviClock:       std_logic;
signal dviVs:          std_logic;
signal dviHs:          std_logic;
signal dviDe:          std_logic;
signal dviR:           std_logic_vector(7 downto 0);
signal dviG:           std_logic_vector(7 downto 0);
signal dviB:           std_logic_vector(7 downto 0); 

--sd controller signals
signal sdrcClk:                     std_logic;
signal sdramClk:                    std_logic;
signal sdrcSelfRefresh:             std_logic;
signal sdrcWrn:                     std_logic;
signal sdrcRdn:                     std_logic;
signal sdrcAddr:                    std_logic_vector( 20 downto 0 );
signal sdrcDataLen:                 std_logic_vector( 7 downto 0 );
signal sdrcDqm:                     std_logic_vector( 3 downto 0 );
signal sdrcDataIn:                  std_logic_vector( 31 downto 0 );
signal sdrcDataOut:                 std_logic_vector( 31 downto 0 );
signal sdrcInitDone:                std_logic;
signal sdrcBusyn:                   std_logic;
signal sdrcRdValid:                 std_logic;
signal sdrcWrdAck:                  std_logic; 

-- video mux signals
signal   vmMode:  std_logic_vector( 15 downto 0 );


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

-- gfx pixel gen signals
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

-- uart signals
signal   uartClock:           std_logic;

signal   uartCE:              std_logic;
signal   uartDoutForCPU:      std_logic_vector( 31 downto 0 );
signal   uartReady:           std_logic;

signal   uartTxd:             std_logic;
signal   uartRxd:             std_logic;

begin


    vmMode  <= x"0000";


-- reset logic based on pll lock

    reset   <= not pllHDMILocked;
    resetn  <= not reset;


-- clock configuration

    pgClock             <= clk25;
    dviClock            <= clk125;

    cpuClock            <= clkd2_40;
    fpgaCpuMemoryClock  <= clkd2_80;

    uartClock           <= clkd2_80;


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

-- place sdram controller
SDRAM_controller_top_SIPInst: SDRAM_controller_top_SIP
	port map(
		O_sdram_clk         => O_sdram_clk,
		O_sdram_cke         => O_sdram_cke,
		O_sdram_cs_n        => O_sdram_cs_n,
		O_sdram_cas_n       => O_sdram_cas_n,
		O_sdram_ras_n       => O_sdram_ras_n,
		O_sdram_wen_n       => O_sdram_wen_n,
		O_sdram_dqm         => O_sdram_dqm,
		O_sdram_addr        => O_sdram_addr,
		O_sdram_ba          => O_sdram_ba,
		IO_sdram_dq         => IO_sdram_dq,

		I_sdrc_rst_n        => cpuResetn,
		I_sdrc_clk          => sdrcClk,
		I_sdram_clk         => sdramClk,
		I_sdrc_selfrefresh  => sdrcSelfRefresh,
		I_sdrc_power_down   => '0',
		I_sdrc_wr_n         => sdrcWrn,
		I_sdrc_rd_n         => sdrcRdn,
		I_sdrc_addr         => sdrcAddr,    
		I_sdrc_data_len     => sdrcDataLen, 
		I_sdrc_dqm          => sdrcDqm,     
		I_sdrc_data         => sdrcDataIn,  
		O_sdrc_data         => sdrcDataOut, 
		O_sdrc_init_done    => sdrcInitDone,
		O_sdrc_busy_n       => sdrcBusyn,
		O_sdrc_rd_valid     => sdrcRdValid,
		O_sdrc_wrd_ack      => sdrcWrdAck
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
   systemRAMCE       <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"000" else
                        '0';

--   fastRAMCE         <= '1' when ( cpuMemValid = '1'  ) and cpuAOutFull( 31 downto 24 ) = x"30" else '0';
--         
--   dmaMemoryCE       <= '1' when ( cpuMemValid = '1'  ) and cpuAOutFull( 31 downto 24 ) = x"20" else '0';
--         
--   registersCE       <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f00" else '0';

--   fpAluCE           <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f01" else '0';
--   
--   blitterCE         <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f02" else '0';

--   usbHostCE         <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f03" else '0';

     uartCE            <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f04" else '0';

--   spiCE             <= '1' when ( cpuMemValid = '1' ) and cpuAOutFull( 31 downto 20 ) = x"f05" else '0';
--   
--   sdramCtrlCE       <= '1' when ( cpuMemValid = '1'  ) and cpuAOutFull( 31 downto 28 ) = x"4" else '0';
--   
-- bus slaves ready signals mux
   cpuMemReady       <= systemRamReady when systemRAMCE = '1'
                        else uartReady when uartCE = '1' 
                        
                        else '1';


--                        else '1' when registersCE = '1' 
--                        else fpAluReady when fpAluCE = '1' 
--                        else blitterReady when blitterCE = '1' 
--                        else usbHostReady when usbHostCE = '1' 
--                        else spiReady when spiCE = '1' 
--                        else cpuDmaReady when dmaMemoryCE = '1' 
--                        else sdramCtrlSdramReady when sdramCtrlCE = '1' 
--                        else '1';


-- bus slaves data outputs mux
   cpuDin            <= systemRamDoutForCPU                       when cpuAOutFull( 31 downto 20 ) = x"000" else 
                        uartDoutForCPU                            when cpuAOutFull( 31 downto 20 ) = x"f04" else
--                        fastRamDoutForCPU                         when cpuAOutFull( 31 downto 24 ) = x"30"  else 
--                        registersDoutForCPU                       when cpuAOutFull( 31 downto 20 ) = x"f00" else
--                        fpAluDoutForCPU                           when cpuAOutFull( 31 downto 20 ) = x"f01" else
--                        blitterDoutForCPU                         when cpuAOutFull( 31 downto 20 ) = x"f02" else
--                        usbHostDoutForCPU                         when cpuAOutFull( 31 downto 20 ) = x"f03" else 
--                        spiDoutForCPU                             when cpuAOutFull( 31 downto 20 ) = x"f05" else
--                        dmaDoutForCPU                             when cpuAOutFull( 31 downto 24 ) = x"20"  else
--                        sdramCtrlDataOutForCPU                    when cpuAOutFull( 31 downto 28 ) = x"4"   else
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

                cpuResetn           <= '1';

            end if;
        end if;
    end if;

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
                dviG        <= pgG( 7 downto 3 ) & "000";
                dviB        <= pgB( 7 downto 3 ) & "000";
            
            --gfx mode
            when "01"	=>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;
                
                dviR		<= pggR( 7 downto 3 ) & "000";
                dviG        <= pggG( 7 downto 3 ) & "000";
                dviB        <= pggB( 7 downto 3 ) & "000";

            --text over gfx mode
            when "10" =>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;

                if	pgR = x"00" and pgG = x"00" and pgB = x"00" then
                    
                    dviR    <= pggR( 7 downto 3 ) & "000";
                    dviG    <= pggG( 7 downto 3 ) & "000";
                    dviB    <= pggB( 7 downto 3 ) & "000";
                    
                --gray color -> dim background
                elsif pgR = x"80" and pgG = x"80" and pgB = x"80" then
            
                    dviR    <= "0" & pggR( 7 downto 4 ) & "000";
                    dviG    <= "0" & pggG( 7 downto 4 ) & "000";
                    dviB    <= "0" & pggB( 7 downto 4 ) & "000";
                    
                else

                    dviR    <= pgR( 7 downto 3 ) & "000";
                    dviG    <= pgG( 7 downto 3 ) & "000";
                    dviB    <= pgB( 7 downto 3 ) & "000";
                
                end if;

            --gfx over text mode
            when "11" =>
            
                dviHs       <= pgHSync;
                dviVs       <= pgVSync;
                dviDe       <= pgDe;


                if	pggR = x"00" and pggG = x"00" and pggB = x"00" then
                    
                    dviR    <= pgR( 7 downto 3 ) & "000";
                    dviG    <= pgG( 7 downto 3 ) & "000";
                    dviB    <= pgB( 7 downto 3 ) & "000";
                    
                else

                    dviR    <= pggR( 7 downto 3 ) & "000";
                    dviG    <= pggG( 7 downto 3 ) & "000";
                    dviB    <= pggB( 7 downto 3 ) & "000";
                    
                end if;

            when others =>
            
        end case;
    
    end if;

end if;

end process; 


end behavior;
