library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera_mf;
use altera_mf.altera_mf_components.all;


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

begin


-- place audio fifo
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
        fifoDIn         <= ( others => '0' );
        fifoWr          <= '0';
        
        --regs default values
        i2sClockGenMax  <= x"0034";     -- 80000000 / 52 ~ 1536000
        i2sClockGenMid  <= x"001a";     -- toggle clk val in middle     

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
--                           
--                           if wr = '1' then
--                           
--                              fpA <= din;
--                              
--                           end if;

                        ready <= '1';

                    --0x04 rw   audioFiFoStatus                       
                    when x"01" =>

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

                    when others =>
                    
                       dout  <= ( others =>'0' );
                       ready <= '1';
                 
                 end case; --a
              
                 state <= rsWaitForBusCycleEnd;
              
              end if; --ce = '1'
                       
           
           when rsWaitForBusCycleEnd =>
           
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

            i2sTxReg    <= ( others => '0' );
            senderState <= i2s0;

            i2sLRCk     <= '0';
            i2sDOut     <= '0';

        else

            case senderState is

                when i2s0 =>

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

                    --todo: latch new data to i2sTxReg

                    senderState <= i2s0;

                when others =>

                    senderState <= i2s0;

            end case;   --senderState is


        end if; --reset = '1'
    end if; --falling_edge( i2sClock )
    
end process;

end behavior;
