library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity gouraudIterator16 is

port(
   --reset
    reset:                          in  std_logic;
    clock:                          in  std_logic;
       
    weightCB:                       in  std_logic_vector( 15 downto 0 );
    weightAC:                       in  std_logic_vector( 15 downto 0 );
    weightBA:                       in  std_logic_vector( 15 downto 0 );

    valA:                           in  std_logic_vector( 15 downto 0 );
    valB:                           in  std_logic_vector( 15 downto 0 );
    valC:                           in  std_logic_vector( 15 downto 0 );

    valOut:                         out std_logic_vector( 15 downto 0 )
);

end gouraudIterator16;

architecture behavior of gouraudIterator16 is

signal mul1:   std_logic_vector( 31 downto 0 );
signal mul2:   std_logic_vector( 31 downto 0 );
signal mul3:   std_logic_vector( 31 downto 0 );

begin

main: process( all )

variable sum:     std_logic_vector( 31 downto 0 );

begin

   if rising_edge( clock ) then
   
      mul1 <=  weightCB * valA;
      mul2 <=  weightAC * valB;
      mul3 <=  weightBA * valC;
   
      sum   := mul1 + mul2 + mul3;
      
      valOut <= sum( 23 downto 8 );
      
   end if; -- rising_edge( clock )
   
end process;



end behavior;
