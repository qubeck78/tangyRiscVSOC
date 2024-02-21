library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity sdramController is
port(

    reset:      in  std_logic;
    clock:      in  std_logic;
    clockSdram: in  std_logic;

    --gfx display mode interface ( ch0 ) - read only with buffer
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


type  dmaState_T is ( dmaIdle, dmaGfxFetch0, dmaGfxFetch1, dmaGfxFetch2, dmaGfxFetch3, 
                     dmaCpuWrite0, dmaCpuWrite1, 
                     dmaCpuRead0, dmaCpuRead1, 
                     dmaCh2Write0, dmaCh2Write1,   
                     dmaCh2Read0, dmaCh2Read1, 
                     dmaCh2Write32_0, dmaCh2Write32_1, 
                     dmaCh2Read32_0, dmaCh2Read32_1                
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

signal  ch0DmaPointerResetSync:  std_logic;


begin

-- place ch0DmaPointerReset sync as it is generated with another clock
inputSyncInst:inputSync
generic map(
    inputWidth  => 1
)
port map(
    clock               => clock,
    signalInput( 0 )    => ch0DmaPointerReset,
    signalOutput( 0 )   => ch0DmaPointerResetSync
);



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
        clkb    => clockSdram,
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

            --ch0 pixelGenGfx ( framebuffer )

            --ch0 buf ram
            ch0BufRamDIn   <= ( others => '0' );
            ch0BufRamWrA   <= ( others => '0' );
            ch0BufRamWe    <= '0';

            --ch0 pointers, counters
            ch0DmaPointer        <= ( others => '0' );
            ch0DmaBufPointer     <= ( others => '0' );

            ch0TransferCounter   <= ( others => '0' );

            ch0DmaRequestLatched <= "00";

            --ch2 - blitter
            ch2Dout     <= ( others => '0' );
            ch2Ready    <= '1';
             
            --ch3 - cpu
            dout        <= ( others => '0' );
            ready       <= '0';
             
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
            if ch0DmaPointerResetSync = '1' then
             
                ch0DmaPointer  <= ch0DmaPointerStart;
                
            end if;
     
            case dmaState is
     
            when dmaIdle =>

                --hold cpu
                ready   <= '0';

                --ch0 - pixelGenGfx
                --ch0 request 0 ( buffer, lower part )
                if ch0DmaRequestLatched( 0 ) = '1' then
               
                    ch0DmaBufPointer    <= "000000000";
                    ch0TransferCounter  <= x"a0";      --160 long words
                    sdrcDataLen         <= x"a0";
                  
                    dmaState <= dmaGfxFetch0;
                  
                --ch0 request 0 ( buffer, upper part )
                elsif ch0DmaRequestLatched( 1 ) = '1' then
               
                    ch0DmaBufPointer    <= "100000000";
                    ch0TransferCounter  <= x"a0";      --160 long words
                    sdrcDataLen         <= x"a0";
                  
                    dmaState <= dmaGfxFetch0;
                
                --ch2 - blitter
                --ch2 request 
                elsif ch2DmaRequest = '1' then

                    if sdrcBusyn = '1' then

                        ch2Ready <= '0';

                        sdrcDataLen     <= x"00";

                        if ch2WordSize = '0' then
                      
                            --16 bit transfer

                            --address
                            sdrcAddr <= ch2A( 21 downto 1 );

                            if ch2A( 0 ) = '0' then

                                sdrcDqm(0)  <= '0';     --d15 downto d0
                                sdrcDqm(1)  <= '0';
                                sdrcDqm(2)  <= '1';
                                sdrcDqm(3)  <= '1';
                            
                            else

                                sdrcDqm(0)  <= '1';
                                sdrcDqm(1)  <= '1';
                                sdrcDqm(2)  <= '0';     --d31 downto d16
                                sdrcDqm(3)  <= '0';

                            end if;  
                                
                            if ch2RWn = '1' then

                                --read
                                sdrcRdn     <= '0';
                                dmaState    <= dmaCh2Read0;
            
                            else

                                --write

                                if ch2A( 0 ) = '0' then

                                    sdrcDataIn( 15 downto 0 )   <= ch2Din( 15 downto 0 );

                                else

                                    sdrcDataIn( 31 downto 16)   <= ch2Din( 15 downto 0 );

                                end if;

                                sdrcWrn     <= '0';
                                dmaState    <= dmaCh2Write0;

                            end if; --ch2RWn = '1' or '0'
                

                        else
                        
                            --32 bit transfer

                            sdrcAddr    <= ch2A( 20 downto 0 );
                            sdrcDqm     <= "0000";  -- d31 downto d0

                            if ch2RWn = '1' then
                            
                                --read

                                sdrcRdn     <= '0';
                                dmaState    <= dmaCh2Read32_0;

                            else

                                --write

                                sdrcDataIn  <= ch2Din;
                                sdrcWrn     <= '0';

                                dmaState    <= dmaCh2Write32_0;

                            end if; --ch2RWn = '1' or '0'
            
                        end if; --ch2WordSize = '0' or '1'

                    end if; --sdrcBusyn = '1'

                --ch3 - cpu
                --ch3 request
                elsif ce = '1' then
                
                    if sdrcBusyn = '1' then

                        --common signals
                        sdrcAddr    <= a( 20 downto 0 );
                        sdrcDataLen <= x"00";

                        if wr = '1' then
                        
                            --write

                            sdrcDataIn  <= din;
                            
                            sdrcDqm( 0 ) <= not dataMask( 0 );
                            sdrcDqm( 1 ) <= not dataMask( 1 );
                            sdrcDqm( 2 ) <= not dataMask( 2 );
                            sdrcDqm( 3 ) <= not dataMask( 3 );

                            sdrcWrn     <= '0';

                            dmaState    <= dmaCpuWrite0;

                        else

                            --read

                            sdrcRdn     <= '0';

                            sdrcDqm     <= "0000";
                            dmaState    <= dmaCpuRead0;

                        end if; --wr = '1' or '0'

                    end if; --sdrcBusyn = '1'
                
                end if; --ce = '1'


            --ch0 pixelGenGfx buffer fetch ( 160 32-bit words )
            when dmaGfxFetch0 =>

                if sdrcBusyn = '1' then
                    
                    sdrcAddr                <= ch0DmaPointer( 20 downto 0 );
                    sdrcDqm                 <= "0000";

                    ch0BufRamWe				<= '0';

                    sdrcRdn                 <= '0';

                    dmaState                <= dmaGfxFetch1;

                end if;

            when dmaGfxFetch1 =>

                if sdrcWrdAck = '1' then

                    sdrcRdn <= '1';

                end if;

                if sdrcRdValid = '1' then

                    sdrcRdn <= '1';

                    ch0BufRamWrA    <= ch0DmaBufPointer;
                    ch0BufRamDIn    <= sdrcDataOut;
                    ch0BufRamWe     <= '1';

                    ch0TransferCounter		<= ch0TransferCounter - 1;
                    ch0DmaPointer		    <= ch0DmaPointer + 1;
                    ch0DmaBufPointer	    <= ch0DmaBufPointer + 1;

                    dmaState    <= dmaGfxFetch2;

                end if;

            when dmaGfxFetch2 =>

                sdrcRdn <= '1';

                ch0BufRamWrA    <= ch0DmaBufPointer;
                ch0BufRamDIn    <= sdrcDataOut;
                ch0BufRamWe     <= '1';

                if ch0TransferCounter = x"00" then
                    
                    ch0DmaRequestLatched( 0 )   <= '0';
                    ch0DmaRequestLatched( 1 )   <= '0';

                    dmaState                    <= dmaGfxFetch3;

                else
 
                    ch0TransferCounter		<= ch0TransferCounter - 1;
                    ch0DmaPointer		    <= ch0DmaPointer + 1;
                    ch0DmaBufPointer	    <= ch0DmaBufPointer + 1;
           
                    dmaState    <= dmaGfxFetch2;

                end if;

            when dmaGfxFetch3 =>

                ch0DmaPointer   <= ch0DmaPointer + 96;

                ch0BufRamWe <= '0';

                dmaState    <= dmaIdle;


            when dmaCh2Read0 =>

                if sdrcWrdAck = '1' then

                    sdrcRdn <= '1';

                end if;
 
                if sdrcRdValid = '1' then 

                    if ch2A( 0 ) = '0' then
                        
                        ch2Dout( 15 downto 0 )  <= sdrcDataOut( 15 downto 0 );
                    
                    else

                        ch2Dout( 15 downto 0 ) <= sdrcDataOut( 31 downto 16 );

                    end if;  

                    sdrcRdn     <= '1';
                    ch2Ready    <= '1';

                    dmaState    <= dmaCh2Read1;
                
                end if; --sdrcRdValid = '1'
            
            when dmaCh2Read1 =>


                if ch2DmaRequest = '0' then

                    dmaState    <= dmaIdle;

                end if;

            when dmaCh2Write0 =>

                if sdrcWrdAck = '1' then

                    sdrcWrn     <= '1';

                    ch2Ready    <= '1';

                    dmaState    <= dmaCh2Write1;

                end if;
                
            when dmaCh2Write1 =>

                
                if ch2DmaRequest = '0' then

                    dmaState    <= dmaIdle;

                end if;


            when dmaCh2Read32_0 =>

                if sdrcWrdAck = '1' then

                    sdrcRdn <= '1';

                end if;
 
                if sdrcRdValid = '1' then 
            
                    ch2Dout     <= sdrcDataOut;
                    
                    sdrcRdn     <= '1';
                    ch2Ready    <= '1';

                    dmaState    <= dmaCh2Read32_1;
                
                end if; --sdrcRdValid = '1'
            
            when dmaCh2Read32_1 =>

                if ch2DmaRequest = '0' then

                    dmaState    <= dmaIdle;

                end if;

            when dmaCh2Write32_0 =>

                if sdrcWrdAck = '1' then

                    sdrcWrn     <= '1';

                    ch2Ready    <= '1';

                    dmaState    <= dmaCh2Write32_1;

                end if;
                
            when dmaCh2Write32_1 =>

                
                if ch2DmaRequest = '0' then

                    dmaState    <= dmaIdle;

                end if;


            when dmaCpuRead0 =>

                if sdrcWrdAck = '1' then

                    sdrcRdn <= '1';

                end if;

                if sdrcRdValid = '1' then

                    dmaState    <= dmaCpuRead1;
                        
                    dout        <= sdrcDataOut;

                end if;

            when dmaCpuRead1 =>

                ready <= '1';

                sdrcRdn <= '1';

                if ce = '0' then

                    ready       <= '0';
                    dmaState    <= dmaIdle;

                end if;

                    
            when dmaCpuWrite0 =>

                if sdrcWrdAck = '1' then
                        
                    sdrcWrn <= '1';

                    dmaState    <= dmaCpuWrite1;

                end if;

            when dmaCpuWrite1 =>

                sdrcWrn <= '1';
                ready   <= '1';
                    
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
