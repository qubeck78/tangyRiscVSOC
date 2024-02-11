library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity sdramController is
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
   
   
    --audio interface ( ch1 )
   
    --tbd
   
   
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


end sdramController;

architecture behavior of sdramController is

--components

--gowin sdram controller
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

-- gfx pixel gen buffer ram ( ch0 buffer )
component gfxBufRam
    port (
        douta: out std_logic_vector(31 downto 0);
        doutb: out std_logic_vector(31 downto 0);
        clka: in std_logic;
        ocea: in std_logic;
        cea: in std_logic;
        reseta: in std_logic;
        wrea: in std_logic;
        clkb: in std_logic;
        oceb: in std_logic;
        ceb: in std_logic;
        resetb: in std_logic;
        wreb: in std_logic;
        ada: in std_logic_vector(8 downto 0);
        dina: in std_logic_vector(31 downto 0);
        adb: in std_logic_vector(8 downto 0);
        dinb: in std_logic_vector(31 downto 0)
    );
end component;

--signals

--gowin sdram controller signals
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


type  dmaState_T is ( dmaIdle, dmaGfxFetch0, dmaGfxFetch1, dmaGfxFetch2, dmaGfxFetch3, dmaGfxFetch4, dmaGfxFetch5,
                     dmaCpuWrite0, dmaCpuWrite1, dmaCpuWrite2, dmaCpuWrite3,
                     dmaCpuRead0, dmaCpuRead1, dmaCpuRead2, dmaCpuRead3, dmaCpuRead4,
                     dmaCh2Write0, dmaCh2Write1, dmaCh2Write2,  
                     dmaCh2Read0, dmaCh2Read1, dmaCh2Read2,
                     dmaCh2Write32_0, dmaCh2Write32_1, dmaCh2Write32_2, 
                     dmaCh2Read32_0, dmaCh2Read32_1, dmaCh2Read32_2, dmaCh2Read32_3, dmaCh2Read32_4               
               );
                     
signal   dmaState:   dmaState_T;

--ch0 buf ram
signal   ch0BufRamDIn:           std_logic_vector( 31 downto 0 );
signal   ch0BufRamWrA:           std_logic_vector( 8 downto 0 );
signal   ch0BufRamWe:            std_logic;
signal   ch0TransferCounter:     std_logic_vector( 7 downto 0 );
signal   ch0DmaPointer:          std_logic_vector( 20 downto 0 );
signal   ch0DmaBufPointer:       std_logic_vector( 8 downto 0 );

--ch0 doesn't have handshake, so requests have to be latched
signal   ch0DmaRequestLatched:   std_logic_vector( 1 downto 0 );

begin

--clock configuration

-- place ch0 buffer dual port ram
gfxBufRAMInst: gfxBufRam
port map(

        reseta  => reset,
        clka    => ch0BufClk,
        ada     => ch0BufA,
        dina    => ( others => '0' ),
        douta   => ch0BufDout,
        ocea    => '1',
        cea     => '1',
        wrea    => '0',
        
        resetb  => reset,
        clkb    => clock,
        adb     => ch0BufRamWrA,
        dinb    => ch0BufRamDIn,
        --doutb
        oceb    => '0',
        ceb     => '1',
        wreb    => ch0BufRamWe

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

    I_sdrc_rst_n        => not reset,
    I_sdrc_clk          => clock,
    I_sdram_clk         => clockSdram,
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



dmaMain: process( all )
begin

    if rising_edge( clock ) then

        if reset = '1' then
            
            --gowin sdram controller
            sdrcWrn         <= '1';
            sdrcRdn         <= '1';
            sdrcAddr        <= ( others => '0' );
            sdrcDataLen     <= x"00";
            sdrcDqm         <= "0000";
            sdrcDataIn      <= ( others => '0' );
            sdrcSelfRefresh <= '0';
  

            --dma channels
            ch2Dout     <= ( others => '0' );
            ch2Ready    <= '1';
             
            dout        <= ( others => '0' );
            ready       <= '0';
             
            --ch0 buf ram
            ch0BufRamDIn   <= ( others => '0' );
            ch0BufRamWrA   <= ( others => '0' );
            ch0BufRamWe    <= '0';

            --ch0 pointers, counters
            ch0DmaPointer        <= ( others => '0' );
            ch0DmaBufPointer     <= ( others => '0' );

            ch0TransferCounter   <= ( others => '0' );

            ch0DmaRequestLatched <= "00";
             
            dmaState <= dmaIdle;
     
        else

            --latch ch0 dma requests
            if ch0DmaRequest( 0 ) = '1' then
             
                ch0DmaRequestLatched( 0 ) <= '1';
        
            end if;
  
            if ch0DmaRequest( 1 ) = '1' then
             
                ch0DmaRequestLatched( 1 ) <= '1';
                
            end if;
     
             --reset ch0 dma pointer if requested
            if ch0DmaPointerReset = '1' then
             
                ch0DmaPointer  <= ch0DmaPointerStart;
                
            end if;
     
            case dmaState is
     
            when dmaIdle =>

                --hold cpu
                ready   <= '0';


                --ch3 - cpu
                if ce = '1' then
                
                    if sdrcBusyn = '1' then

                        --common signals
                        sdrcAddr    <= a( 20 downto 0 );

                        if wr = '1' then
                        
                            --write

                            sdrcDataIn  <= din;
                            
                            sdrcDqm( 0 ) <= not dataMask( 0 );
                            sdrcDqm( 1 ) <= not dataMask( 1 );
                            sdrcDqm( 2 ) <= not dataMask( 2 );
                            sdrcDqm( 3 ) <= not dataMask( 3 );

                            dmaState    <= dmaCpuWrite0;

                        else

                            --read

                            sdrcDqm     <= "0000";
                            dmaState    <= dmaCpuRead0;

                        end if; --wr = '1' or '0'

                    end if; --sdrcBusyn = '1'
                
                end if; --ce = '1'


            when dmaCpuRead0 =>

                sdrcRdn     <= '0';
                dmaState    <= dmaCpuRead1;

            when dmaCpuRead1 =>
                    
                if sdrcWrdAck = '1' then

                    sdrcRdn <= '1';

                end if;

                if sdrcRdValid = '1' then

                    dmaState    <= dmaCpuRead2;
                        
                    dout        <= sdrcDataOut;

                end if;

            when dmaCpuRead2 =>

                dmaState    <= dmaCpuRead3;

            when dmaCpuRead3 =>

                ready <= '1';

                if ce = '0' then

                    ready       <= '0';
                    dmaState    <= dmaIdle;

                end if;
            
            when dmaCpuWrite0 =>

                sdrcWrn     <= '0';
                dmaState    <= dmaCpuWrite1;
                

            when dmaCpuWrite1 =>

                if sdrcWrdAck = '1' then
                        
                    sdrcWrn <= '1';

                    dmaState    <= dmaCpuWrite2;

                end if;

            when dmaCpuWrite2 =>

                 dmaState    <= dmaCpuWrite3;

            when dmaCpuWrite3 =>


                ready <= '1';
                    
                if ce = '0' then
            
                    ready       <= '0';
                    dmaState    <= dmaIdle;

                end if;

            when others =>

                dmaState    <= dmaIdle;

            end case;   -- dmaState is
    
        end if; --reset = '1' or '0'

    end if; --rising_edge( clock )

end process;

end behavior;
