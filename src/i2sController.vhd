library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


--https://en.wikipedia.org/wiki/I%C2%B2S

entity i2sController is
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
end i2sController;

architecture behavior of i2sController is

--components

component i2sControllerFifo
	port (
		Data: in std_logic_vector(31 downto 0);
		WrClk: in std_logic;
		RdClk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Almost_Empty: out std_logic;
		Q: out std_logic_vector(31 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

-- signals

type    i2sRegState_T is ( rsWaitForRegAccess, rsWaitForBusCycleEnd );
signal  state:  i2sRegState_T;

type    i2sSenderState_T is (    i2s0,  i2s1,  i2s2,  i2s3,  i2s4,  i2s5,  i2s6,  i2s7, 
                                 i2s8,  i2s9, i2s10, i2s11, i2s12, i2s13, i2s14, i2s15,
                                i2s16, i2s17, i2s18, i2s19, i2s20, i2s21, i2s22, i2s23,
                                i2s24, i2s25, i2s26, i2s27, i2s28, i2s29, i2s30, i2s31
                            );

signal  senderState:  i2sSenderState_T;

-- i2s clock gen
signal  i2sClockGenCounter:     std_logic_vector( 15 downto 0 );
signal  i2sClockGenMax:         std_logic_vector( 15 downto 0 );
signal  i2sClockGenMid:         std_logic_vector( 15 downto 0 );
signal  i2sClock:               std_logic;

-- i2s tx
signal  i2sTxReg:               std_logic_vector( 31 downto 0 );

-- i2s fifo
signal  fifoWr:                 std_logic;
signal  fifoDIn:                std_logic_vector( 31 downto 0 );
signal  fifoAlmostEmpty:        std_logic;
signal  fifoEmpty:              std_logic;
signal  fifoFull:               std_logic;

signal  fifoRd:                 std_logic;
signal  fifoDOut:               std_logic_vector( 31 downto 0 );

signal  fifoReadCounter:        std_logic_vector( 7 downto 0 );
signal  fifoReadDiv:            std_logic_vector( 7 downto 0 );

-- i2s fifo <- cpu
signal fifoWrCpu:               std_logic;
signal fifoDinCpu:              std_logic_vector( 31 downto 0 );

-- i2s fifo <- dma
signal fifoWrDma:               std_logic;
signal fifoDinDma:              std_logic_vector( 31 downto 0 );

-- i2s dma control signals

type   dmaState_T is    ( dmaDisabled, dmaMode01s0, dmaMode01s1, dmaMode01s2, dmaMode01s3, dmaMode01s4, dmaMode01s5 );
signal dmaState:                dmaState_T;


-- 00 - disabled
-- 01 - mono (left channel only )
-- 10 - stereo
signal dmaMode:                 std_logic_vector( 1 downto 0 );
signal dmaLoop:                 std_logic;

signal dmaDataPointerReg:       std_logic_vector( 20 downto 0 );
signal dmaDataLengthReg:        std_logic_vector( 20 downto 0 );

signal dmaDataPointer:          std_logic_vector( 20 downto 0 );
signal dmaDataCounter:          std_logic_vector( 20 downto 0 );

signal dmaDataSecondHalf:       std_logic;
signal dmaFinished:             std_logic;
signal dmaFinishedClear:        std_logic;

begin


-- place audio fifo

--select fifo write source, according to dma mode "00" -> cpu, "01" or "10" -> dma
fifoDIn <= fifoDInCpu when dmaMode = "00" else fifoDinDma;
fifoWr  <= fifoWrCpu when dmaMode = "00" else fifoWrDma;

i2sControllerFifoInst: i2sControllerFifo
port map(
    Data            => fifoDIn,
	WrClk           => clock,
	RdClk           => i2sClock,
	WrEn            => fifoWr,
	RdEn            => fifoRd,
	Almost_Empty    => fifoAlmostEmpty,
	Q               => fifoDOut,
	Empty           => fifoEmpty,
	Full            => fifoFull
);


i2sRegisters: process( all )
begin

  if rising_edge( clock ) then
  
     if reset = '1' then
     
        ready           <= '0';  
        state           <= rsWaitForRegAccess;

        --fifo
        fifoDInCpu      <= ( others => '0' );
        fifoWrCpu       <= '0';
        
        --regs default values

        --48KHz, fifo read div = 1
        i2sClockGenMax      <= x"0034";     -- 80000000 / 52 ~ 1536000
        i2sClockGenMid      <= x"001a";     -- toggle clk val in middle     
        fifoReadDiv         <= x"00";       

        dmaMode             <= "00";        -- dma disabled by default
        dmaLoop             <= '0';         -- dma buffer looping disabled by default

        dmaFinishedClear    <= '0';
     else
     
        case state is
  
           when rsWaitForRegAccess =>
        
              if ce = '1' then
              
                 --cpu wants to access registers
              
                 ready <= '0';
                 
                 case a( 7 downto 0 ) is
                 
                    --0x00 -w   audioFiFoData                       
                    when x"00" =>
                    
                        dout  <= ( others => '0' );
                           
                        if wr = '1' then

                            fifoDInCpu  <= din;
                            fifoWrCpu   <= '1';

                        end if;

                        ready <= '1';

                    --0x04 r-   audioFiFoStatus                       
                    when x"01" =>

                        dout    <= x"0000000" & '0' & fifoFull & fifoAlmostEmpty & fifoEmpty;
                        ready   <= '1';

                    --0x08 rw   i2sClockConfig                       
                    when x"02" =>
                    
                        dout    <= i2sClockGenMax & i2sClockGenMid;

                        if wr = '1' then

                            i2sClockGenMax  <= din( 31 downto 16 );
                            i2sClockGenMid  <= din( 15 downto 0 );

                        end if;

                        ready   <= '1';

                    --0x0c rw   fifoReadConfig                    
                    when x"03" =>

                        dout    <= x"000000" & fifoReadDiv;

                        if wr = '1' then

                            fifoReadDiv <= din( 7 downto 0 );
                        
                        end if;

                        ready   <= '1';

                    --0x10 rw audioDmaConfig
                    when x"04" =>

                        dout    <= x"0000000" & '0' & dmaLoop & dmaMode;

                        if wr = '1' then

                            dmaLoop <= din( 2 );
                            dmaMode <= din( 1 downto 0 );

                        end if;

                        ready   <= '1';

                    --0x14 rw audioDmaStatus
                    when x"05" =>

                        dout    <= x"0000000" & "00" & dmaDataSecondHalf &  dmaFinished;

                        if dmaFinished = '1' then

                            dmaFinishedClear <= '1';

                        end if;

                        ready   <= '1';

                    --0x18 rw audioDmaPointer
                    when x"06" =>

                        dout    <= x"00" & "000" & dmaDataPointerReg;
    
                        if wr = '1' then

                            dmaDataPointerReg   <= din( 20 downto 0 );

                        end if;

                        ready   <= '1';

                    --0x1c rw audioDmaLength
                    when x"07" =>

                        dout    <= x"00" & "000" & dmaDataLengthReg;
    
                        if wr = '1' then

                            dmaDataLengthReg   <= din( 20 downto 0 );

                        end if;

                        ready   <= '1';

                    when others =>
                    
                       dout  <= ( others =>'0' );
                       ready <= '1';
                 
                 end case; --a
              
                 state <= rsWaitForBusCycleEnd;
              
              end if; --ce = '1'
                       
           
           when rsWaitForBusCycleEnd =>

              --deassert fifo write
              fifoWrCpu         <= '0';

              --deassert dma finished clear flag
              dmaFinishedClear  <= '0';

              --wait for bus cycle to end
              if ce = '0' then
              
                 state <= rsWaitForRegAccess;
                 ready <= '0';
                 
              end if;
              
           when others =>
           
              state <= rsWaitForRegAccess;
        
        end case; --state
  
     end if; --reset = '1'
  
  
  end if; --rising_edge( clock )


end process;


--i2s dma master

i2sDmaMaster: process( all )
begin

    if rising_edge( clock ) then
  
        if reset = '1' then

            --dma     
            dmaRequest          <= '0';
            dmaA                <= ( others => '0' );

            dmaDataPointer      <= ( others => '0' );
            dmaDataCounter      <= ( others => '0' );

            --fifo
            fifoWrDma           <= '0';
            fifoDinDma          <= ( others => '0' );

            dmaFinished         <= '0';
            dmaDataSecondHalf   <= '0';

            dmaState            <= dmaDisabled;

        else

            --check if dmaFinished flag has been read
            if dmaFinishedClear = '1' then

                dmaFinished <= '0';

            end if;

            --over half of the buffer
            if dmaDataCounter >= "0" & dmaDataLengthReg( 20 downto 1 ) then 

                dmaDataSecondHalf   <= '1';

            else

                dmaDataSecondHalf   <= '0';

            end if;

            case dmaState is

                when dmaDisabled =>

                    dmaRequest          <= '0';
                    fifoWrDma           <= '0';

                    dmaDataSecondHalf   <= '0';

                    if dmaMode = "01" then


                        dmaDataPointer  <= dmaDataPointerReg;
                        dmaDataCounter  <= ( others => '0' );

                        dmaState    <= dmaMode01s0;

                    end if;

                when dmaMode01s0 =>

                    if dmaMode /= "01" then

                        dmaState    <= dmaDisabled;

                    else

                        if fifoAlmostEmpty = '1' then

                            -- read data and write 2 samples to fifo

                            dmaA        <= dmaDataPointer;
                            dmaRequest  <= '1';

                            dmaState    <= dmaMode01s1;

                        end if; --fifoAlmostEmpty = '1'

                    end if; --dmaMode /=, = "01"

                when dmaMode01s1 =>

                    if dmaReady = '0' then

                        dmaRequest  <= '0';
                        dmaState    <= dmaMode01s2;
                    end if; 


                when dmaMode01s2 =>

                    if dmaReady = '1' then

                        fifoWrDma   <= '1';

                        fifoDinDma  <= dmaDin( 15 downto 0 ) & dmaDin( 15 downto 0 );

                        dmaState    <= dmaMode01s3;

                    end if;

                when dmaMode01s3 =>

                    fifoDinDma  <= dmaDin( 31 downto 16 ) & dmaDin( 31 downto 16 );
                    dmaState    <= dmaMode01s4;
    
                when dmaMode01s4 =>

                    fifoWrDma   <= '0';

                    --check data counter
                    if dmaDataCounter < dmaDataLengthReg then

                        --next 2 samples
                        dmaDataCounter  <= dmaDataCounter + 1;
                        dmaDataPointer  <= dmaDataPointer + 1;

                        dmaState <= dmaMode01s0;

                    else

                        --restart pointer / counter
                        dmaDataCounter  <= ( others => '0' );
                        dmaDataPointer  <= dmaDataPointerReg;

                        --set dmaFinished flag
                        dmaFinished     <= '1';

                        if dmaLoop = '1' then

                            --looping enabled

                            dmaState <= dmaMode01s0;

                        else

                            --looping disabled

                            dmaState <= dmaMode01s5;

                        end if; --dmaLoop = '1' or '0'

                    end if;

                when dmaMode01s5 =>

                    -- wait for dma mode change

                    if dmaMode /= "01" then

                        dmaState    <= dmaDisabled;

                    end if;

                when others =>

                    dmaState    <= dmaDisabled;

            end case; --dmaState is

        end if; --reset = '1' or '0'

    end if; --rising_edge( clock )

end process;


--i2s serial sender
i2sBClk <= i2sClock;

i2sClockGen: process( all )
begin

    if rising_edge( clock ) then
  
        if reset = '1' then
     
            i2sClockGenCounter  <= ( others => '0' );
            i2sClock            <= '0';

        else

            if i2sClockGenCounter /= i2sClockGenMax then

                i2sClockGenCounter  <= i2sClockGenCounter + 1;

            else

                i2sClockGenCounter  <= ( others => '0' );
                i2sClock            <= '0';
            
            end if;


            if i2sClockGenCounter = i2sClockGenMid then

                i2sClock    <= '1';

            end if;

        end if; --reset = '1'
    end if; --rising_edge( clock )

end process;



i2sSender:  process( all )
begin

    if falling_edge( i2sClock ) then
  
        if reset = '1' then

            i2sTxReg        <= ( others => '0' );
            senderState     <= i2s0;

            i2sLRCk         <= '0';
            i2sDOut         <= '0';
    
            fifoReadCounter <= ( others => '0' );

        else

            case senderState is

                when i2s0 =>

                    fifoRd      <= '0';

                    i2sDOut     <= i2sTxReg( 31 );

                    senderState <= i2s1;

                when i2s1 =>

                    i2sDOut     <= i2sTxReg( 30 );

                    senderState <= i2s2;

                when i2s2 =>

                    i2sDOut     <= i2sTxReg( 29 );

                    senderState <= i2s3;

                when i2s3 =>

                    i2sDOut     <= i2sTxReg( 28 );

                    senderState <= i2s4;

                when i2s4 =>

                    i2sDOut     <= i2sTxReg( 27 );

                    senderState <= i2s5;

                when i2s5 =>

                    i2sDOut     <= i2sTxReg( 26 );

                    senderState <= i2s6;

                when i2s6 =>

                    i2sDOut     <= i2sTxReg( 25 );

                    senderState <= i2s7;

                when i2s7 =>

                    i2sDOut     <= i2sTxReg( 24 );

                    senderState <= i2s8;

                when i2s8 =>

                    i2sDOut     <= i2sTxReg( 23 );

                    senderState <= i2s9;

                when i2s9 =>

                    i2sDOut     <= i2sTxReg( 22 );

                    senderState <= i2s10;

                when i2s10 =>

                    i2sDOut     <= i2sTxReg( 21 );

                    senderState <= i2s11;

                when i2s11 =>

                    i2sDOut     <= i2sTxReg( 20 );

                    senderState <= i2s12;

                when i2s12 =>

                    i2sDOut     <= i2sTxReg( 19 );

                    senderState <= i2s13;

                when i2s13 =>

                    i2sDOut     <= i2sTxReg( 18 );

                    senderState <= i2s14;

                when i2s14 =>

                    i2sDOut     <= i2sTxReg( 17 );

                    senderState <= i2s15;

                when i2s15 =>

                    i2sDOut     <= i2sTxReg( 16 );

                    i2sLRCk     <= '1';     

                    senderState <= i2s16;

                when i2s16 =>

                    i2sDOut     <= i2sTxReg( 15 );

                    senderState <= i2s17;

                when i2s17 =>

                    i2sDOut     <= i2sTxReg( 14 );

                    senderState <= i2s18;

                when i2s18 =>

                    i2sDOut     <= i2sTxReg( 13 );

                    senderState <= i2s19;

                when i2s19 =>

                    i2sDOut     <= i2sTxReg( 12 );

                    senderState <= i2s20;

                when i2s20 =>

                    i2sDOut     <= i2sTxReg( 11 );

                    senderState <= i2s21;

                when i2s21 =>

                    i2sDOut     <= i2sTxReg( 10 );

                    senderState <= i2s22;

                when i2s22 =>

                    i2sDOut     <= i2sTxReg( 9 );

                    senderState <= i2s23;

                when i2s23 =>

                    i2sDOut     <= i2sTxReg( 8 );

                    senderState <= i2s24;

                when i2s24 =>

                    i2sDOut     <= i2sTxReg( 7 );

                    senderState <= i2s25;

                when i2s25 =>

                    i2sDOut     <= i2sTxReg( 6 );

                    senderState <= i2s26;

                when i2s26 =>

                    i2sDOut     <= i2sTxReg( 5 );

                    senderState <= i2s27;

                when i2s27 =>

                    i2sDOut     <= i2sTxReg( 4 );

                    senderState <= i2s28;

                when i2s28 =>

                    i2sDOut     <= i2sTxReg( 3 );

                    senderState <= i2s29;

                when i2s29 =>

                    i2sDOut     <= i2sTxReg( 2 );

                    senderState <= i2s30;

                when i2s30 =>

                    i2sDOut     <= i2sTxReg( 1 );

                    senderState <= i2s31;

                when i2s31 =>

                    i2sDOut     <= i2sTxReg( 0 );
                    i2sLRCk     <= '0';

                    --fiforeadcounter allows reading from fifo every n i2s send cycle
                    --so actual signal frequency will be i2s dac freq / ( fifoReadDiv + 1 )
                    if fifoReadCounter = x"00" then

                        --latch new data to i2sTxReg
                        i2sTxReg    <= fifoDOut;

                        --trigger next data read
                        if fifoEmpty = '0' then

                            fifoRd  <= '1';

                        end if;

                        fifoReadCounter <= fifoReadDiv;

                    else

                        fifoReadCounter <= fifoReadCounter  - 1;

                    end if;

                    senderState <= i2s0;

                when others =>

                    senderState <= i2s0;

            end case;   --senderState is


        end if; --reset = '1'
    end if; --falling_edge( i2sClock )
    
end process;

end behavior;
