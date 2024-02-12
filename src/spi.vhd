library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity SPI is
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
end SPI;

architecture behavior of SPI is


signal txBuffer:           std_logic_vector( 7 downto 0 );
signal rxBuffer:           std_logic_vector( 7 downto 0 );

signal misoSync:           std_logic;

signal spiReady:           std_logic;
signal dataToSend:         std_logic_vector( 7 downto 0 );
signal dataReceived:       std_logic_vector( 7 downto 0 );
signal dataToSendStrobe:   std_logic;


type spiState_t is ( spiIdle, spiWaitForStrobeRelease, spiB7L, spiB7H, spiB6L, spiB6H, spiB5L, spiB5H, spiB4L, 
                     spiB4H, spiB3L, spiB3H, spiB2L, spiB2H, spiB1L, spiB1H, spiB0L, spiB0H );
                   
signal spiState:           spiState_t;


type RegState_T is ( rsWaitForRegAccess, rsWaitForBusCycleEnd );

signal regState:           RegState_T;

begin



registers: process( all )
begin

   if rising_edge( clock ) then
   
      if reset = '1' then
      
         dataToSendStrobe     <= '0';
      
         ready                <= '0';  
         regState             <= rsWaitForRegAccess;
         
      else
      
         dataToSendStrobe  <= '0';
         
         case regState is
   
            when rsWaitForRegAccess =>
         
               if ce = '1' then
               
                  --cpu wants to access registers
               
                  ready <= '0';
                  
                  case a( 7 downto 0 ) is
                  
                     --0x00 rw spiData                      
                     when x"00" =>
                     
                        dout  <= x"0000" &  x"00" & dataReceived;
                        
                        if wr = '1' then
                        
                           dataToSend        <= din( 7 downto 0 );
                           dataToSendStrobe  <= '1';
                           
                        end if;

                        ready <= '1';
                        
                     --0x04 r- spiStatus                       
                     when x"01" =>
                     
                        dout  <= x"0000" & "000000000000000" & spiReady;
                        
                        ready <= '1';

                     when others =>
                     
                        dout  <= ( others =>'0' );
                        ready <= '1';
                  
                  end case; --a
               
                  regState <= rsWaitForBusCycleEnd;
               
               end if; --ce = '1'
                        
            
            when rsWaitForBusCycleEnd =>
            
               --wait for bus cycle to end
               if ce = '0' then
               
                  regState <= rsWaitForRegAccess;
                  ready <= '0';
                  
               end if;
               
            when others =>
            
               regState <= rsWaitForRegAccess;
         
         end case; --state
   
      end if; --reset = '1'
   
   end if; --rising_edge( clock )

end process;


   misoSync <= miso;
   
spiInterface: process( all )

begin

   if rising_edge( clock ) then
   
   
      if reset = '1' then
      
         spiState <= spiIdle;
         spiReady <= '1';

         sclk     <= '0';
         mosi     <= '0';
         txBuffer <= ( others => '0' );
         rxBuffer <= ( others => '0' );
         
      else
      
      
         case spiState is 
   
            when spiIdle =>
            
               sclk           <= '0';
               spiReady       <= '1';
               
               dataReceived   <= rxBuffer;
               
               if dataToSendStrobe = '1' then
                  
                  txBuffer <= dataToSend;
                  spiReady <= '0';
                  
                  spiState <= spiWaitForStrobeRelease;
                  
               end if;
               
            when spiWaitForStrobeRelease =>

               spiReady <= '0';

               sclk     <= '0';
            
               if dataToSendStrobe = '0' then
               
                  spiState <= spiB7L;
                  
               end if;
               
            when spiB7L =>

               spiReady <= '0';
            
               mosi     <= txBuffer( 7 );
               
               sclk     <= '0';
               spiState <= spiB7H;
               
            when spiB7H =>

               spiReady <= '0';
               
               rxBuffer( 7 ) <= misoSync;
               
               sclk     <= '1';
               spiState <= spiB6L;
               
            when spiB6L =>
            
               mosi     <= txBuffer( 6 );

               spiReady <= '0';

               sclk     <= '0';
               spiState <= spiB6H;
               
            when spiB6H =>
            
               spiReady <= '0';

               rxBuffer( 6 ) <= misoSync;

               sclk     <= '1';
               spiState <= spiB5L;
               
            when spiB5L =>
            
               mosi     <= txBuffer( 5 );

               spiReady <= '0';
            
               sclk     <= '0';
               spiState <= spiB5H;
               
            when spiB5H =>
            
               spiReady <= '0';

               rxBuffer( 5 ) <= misoSync;

               sclk     <= '1';
               spiState <= spiB4L;
               
            when spiB4L =>
            
               mosi     <= txBuffer( 4 );

               spiReady <= '0';

               sclk     <= '0';
               spiState <= spiB4H;
               
            when spiB4H =>
            
               spiReady <= '0';

               rxBuffer( 4 ) <= misoSync;

               sclk     <= '1';
               spiState <= spiB3L;
               
            when spiB3L =>
            
               mosi     <= txBuffer( 3 );

               spiReady <= '0';
            
               sclk     <= '0';
               spiState <= spiB3H;
               
            when spiB3H =>
            
               rxBuffer( 3 ) <= misoSync;

               spiReady <= '0';

               sclk     <= '1';
               spiState <= spiB2L;
               
            when spiB2L =>
            
               mosi     <= txBuffer( 2 );

               spiReady <= '0';
            
               sclk     <= '0';
               spiState <= spiB2H;
               
            when spiB2H =>

               rxBuffer( 2 ) <= misoSync;

               spiReady <= '0';
            
               sclk     <= '1';
               spiState <= spiB1L;
               
            when spiB1L =>
            
               mosi     <= txBuffer( 1 );

               spiReady <= '0';

               sclk     <= '0';
               spiState <= spiB1H;
               
            when spiB1H =>
            
               spiReady <= '0';

               rxBuffer( 1 ) <= misoSync;

               sclk     <= '1';
               spiState <= spiB0L;
               
            when spiB0L =>
            
               mosi     <= txBuffer( 0 );

               spiReady <= '0';

               sclk     <= '0';
               spiState <= spiB0H;
               
            when spiB0H =>
            
               spiReady <= '0';

               rxBuffer( 0 ) <= misoSync;

               sclk     <= '1';
               spiState <= spiIdle;
               
               
            when others =>
            
               spiState <= spiIdle;
               
         end case;   --spiState is
         
         
      end if; --reset = '1'
   
   
   end if;


end process;



end behavior;
