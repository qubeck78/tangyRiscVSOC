library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity UART is

generic(

    clockFreq               : integer := 80000000;
    baudRate                : integer := 200000

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
   
   --uart interface
   uartTXD:          out std_logic;
   uartRXD:          in  std_logic

);

end UART;

architecture behavior of UART is

constant baudCounterMax          : integer := ( clockFreq / baudRate )-1; 
constant baudCounterHalf         : integer := baudCounterMax / 2;
constant baudCounterRxStartBit   : integer := baudCounterMax + baudCounterHalf;

--component uartFiFo IS
--   PORT
--   (
--      clock    : IN STD_LOGIC ;
--      data     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--      rdreq    : IN STD_LOGIC ;
--      wrreq    : IN STD_LOGIC ;
--      empty    : OUT STD_LOGIC ;
--      full     : OUT STD_LOGIC ;
--      q     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--   );
--END component;

component uartFiFo
	port (
		Data: in std_logic_vector(7 downto 0);
		Clk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Reset: in std_logic;
		Q: out std_logic_vector(7 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

component inputSync

    generic(
        inputWidth              : integer := 1
    );

    port(

        clock:                          in  std_logic;

        signalInput:                    in  std_logic_vector( inputWidth - 1 downto 0 );
        signalOutput:                   out std_logic_vector( inputWidth - 1 downto 0 )

    );

end component;


signal txBaudCounter    : std_logic_vector( 15 downto 0 );
signal txBuffer         : std_logic_vector( 7 downto 0 );

signal rxBaudCounter    : std_logic_vector( 15 downto 0 );
signal rxBuffer         : std_logic_vector( 7 downto 0 );

type txState_T is ( txsIdle, txsWaitForStrobeRelease, txsStartBit, txsB0, txsB1, txSB2, txsB3, txsB4, txsB5, txsB6, txsB7, txsStopBit );
signal txState          : txState_T;

type rxState_T is ( rxsWaitForStartBit, rxsB0, rxsB1, rxsB2, rxsB3, rxsB4, rxsB5, rxsB6, rxsB7, rxsStopBit );
signal rxState          : rxState_T;

signal uartRXDSync      : std_logic;


signal dataSenderReady:                std_logic;
signal dataToSend:                     std_logic_vector( 7 downto 0 );
signal dataToSendStrobe:               std_logic;

signal dataReceivedReady:              std_logic;
signal dataReceived:                   std_logic_vector( 7 downto 0 );
signal dataReceivedReadAcknowledge:    std_logic;


--registers signals
type uartRegState_T is ( urWaitForRegAccess, urWaitForBusCycleEnd );
signal uartRegState:       uartRegState_T;

--fifo signals

signal rxFiFoEmpty:        std_logic;
signal rxFiFoWrReq:        std_logic;




begin


registers: process( all )
begin

   if rising_edge( clock ) then
   
      if reset = '1' then
      
         --clear uart write strobe and read ack
         dataToSendStrobe              <= '0';
         dataReceivedReadAcknowledge   <= '0';

         ready                         <= '0';  
         uartRegState                  <= urWaitForRegAccess;           
         
      else
      
      
         --clear uart write strobe and read ack
         dataToSendStrobe              <= '0';
         dataReceivedReadAcknowledge   <= '0';

         
         case uartRegState is
   
            when urWaitForRegAccess =>
         
               if ce = '1' then
               
                  --cpu wants to access registers
               
                  ready <= '0';
                  
                  case a( 7 downto 0 ) is
                  
                  --0x00 rw - uartData
                  when x"00" =>
                  
                        if wr = '0' then
                           
                           dout  <= x"000000" & dataReceived;
                     
                           dataReceivedReadAcknowledge   <= '1';
                        
                        else  -- wr = '1'
                        
                           dataToSend           <= din( 7 downto 0 );
                           
                           dataToSendStrobe     <= '1';
                           
                        end if;

                        ready <= '1';

                     --0x04 r- uartStatus                   
                     when x"01" =>
                     
                        dout                 <= x"000000" & "000000" & dataSenderReady & dataReceivedReady;

                        ready                <= '1';                       
                     
                     when others =>
                     
                        dout  <= ( others => '0' );
                        ready <= '1';
                        
                  end case; -- a( 7 downto 0 ) is
                  
                  uartRegState <= urWaitForBusCycleEnd;
               
               end if; -- ce = '1';
               
            when urWaitForBusCycleEnd =>
            
               --wait for bus cycle to end
               if ce = '0' then
               
                  uartRegState <= urWaitForRegAccess;
                  ready <= '0';
                  
               end if;
               
            when others =>
            
               uartRegState <= urWaitForRegAccess;
               
         end case; --uartRegState is

      end if; --reset = '1'

   end if;--rising_edge( clock )
      
end process;


rxdSyncInst: inputSync
    generic map(
        inputWidth => 1
    )

    port map(

        clock           => clock,
        signalInput(0)  => uartRXD,
        signalOutput(0) => uartRXDSync

    );
    
    
--place rx fifo
dataReceivedReady <= not rxFiFoEmpty;

rxFiFoInst:uartFiFo
port map
   (
      Reset    => reset,
      Clk      => clock,
      Data     => rxBuffer,
      RdEn     => dataReceivedReadAcknowledge,
      WrEn     => rxFiFoWrReq,
      Empty    => rxFiFoEmpty,
--    Full     : OUT STD_LOGIC ;
      Q        => dataReceived
   );
   
   
receiver: process( all )


begin

    if rising_edge( clock ) then

        if reset = '1' then

            rxState             <= rxsWaitForStartBit;
            rxBaudCounter       <= ( others => '0' );
            rxFiFoWrReq          <= '0';

        else

            case rxState is

                when rxsWaitForStartBit =>

                  --clear fifo write request
                  rxFiFoWrReq <= '0';
                        
                    if uartRXDSync = '0' then

                        rxBaudCounter   <= conv_std_logic_vector( baudCounterRxStartBit, rxBaudCounter'length );
                        rxState         <= rxsB0;
                        
                    end if;

                when rxsB0 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 0 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB1;

                    end if;

                when rxsB1 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 1 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB2;

                    end if;

                when rxsB2 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 2 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB3;

                    end if;

                when rxsB3 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 3 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB4;

                    end if;

                when rxsB4 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 4 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB5;

                    end if;

                when rxsB5 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 5 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB6;

                    end if;

                when rxsB6 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 6 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsB7;

                    end if;

                when rxsB7 =>

                    if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;

                    else
                        
                        rxBuffer( 7 )   <= uartRXDSync;
                        rxBaudCounter   <= conv_std_logic_vector( baudCounterMax, rxBaudCounter'length );
                        rxState         <= rxsStopBit;

                    end if;

                when rxsStopBit =>
                     
                  
                     if rxBaudCounter /= 0 then
                    
                        rxBaudCounter <= rxBaudCounter - 1;
                    
                    else
                        
                        
                        --todo: check if stop bit is really '1'


                        --write data to fifo
                        rxFiFoWrReq <= '1';
                        
                        rxState             <= rxsWaitForStartBit;
                        
                        
                    end if;


                when others =>

                    rxState <= rxsWaitForStartBit;

            end case;

            
        end if;

    end if;

end process;



transmitter: process( all )

begin

    if rising_edge( clock ) then

        if reset = '1' then

            txState         <= txsIdle;
            uartTXD         <= '1';
            dataSenderReady <= '1';
            txBuffer        <= ( others => '0' );
            txBaudCounter   <= ( others => '0' );
            
        else

            case txState is


                when txsIdle =>

                    uartTXD         <= '1';
                    dataSenderReady <= '1';

                    if dataToSendStrobe = '1' then
                        
                        txBuffer        <= dataToSend;
                        dataSenderReady <= '0';
                        
                        txState         <= txsWaitForStrobeRelease;

                    end if;

                when txsWaitForStrobeRelease =>

                    if dataToSendStrobe = '0' then
                    
                        txState         <= txsStartBit;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );
                        
                    end if;

                when txsStartBit =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= '0';
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB0;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB0 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 0 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB1;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;
                
                when txsB1 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 1 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB2;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB2 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 2 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB3;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB3 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 3 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB4;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB4 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 4 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB5;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB5 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 5 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB6;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB6 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 6 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsB7;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsB7 =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= txBuffer( 7 );
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsStopBit;
                        txBaudCounter   <= conv_std_logic_vector( baudCounterMax, txBaudCounter'length );

                    end if;

                when txsStopBit =>

                    if txBaudCounter /= 0 then

                        uartTXD         <= '1';
                        txBaudCounter   <= txBaudCounter - 1;

                    else
                        txState         <= txsIdle;

                    end if;

                when others =>

                    txState <= txsIdle;

            end case;



        end if;

    end if;

end process;




end behavior;
