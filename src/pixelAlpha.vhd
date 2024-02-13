library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity pixelAlpha is

port(
   --reset
    reset:                          in  std_logic;
    clock:                          in  std_logic;
       
    colorInA:                       in  std_logic_vector( 15 downto 0 );
    colorInB:                       in  std_logic_vector( 15 downto 0 );
    alpha:                          in  std_logic_vector( 4 downto 0 );
    colorOut:                       out std_logic_vector( 15 downto 0 )
);

end pixelAlpha;

architecture behavior of pixelAlpha is


begin

main: process( all )

variable mulAR:   std_logic_vector( 9 downto 0 );
variable mulAG:   std_logic_vector( 9 downto 0 );
variable mulAB:   std_logic_vector( 9 downto 0 );

variable mulBR:   std_logic_vector( 9 downto 0 );
variable mulBG:   std_logic_vector( 9 downto 0 );
variable mulBB:   std_logic_vector( 9 downto 0 );

variable beta:    std_logic_vector( 4 downto 0 );

variable outR:    std_logic_vector( 4 downto 0 );
variable outG:    std_logic_vector( 4 downto 0 );
variable outB:    std_logic_vector( 4 downto 0 );

begin

   if rising_edge( clock ) then
   
      beta  := not alpha;
      
   
      mulAR := colorInA( 4 downto 0 )     * alpha;
      mulAG := colorInA( 10 downto 6 )    * alpha;
      mulAB := colorInA( 15 downto 11 )   * alpha;
      
      mulBR := colorInB( 4 downto 0 )     * beta;
      mulBG := colorInB( 10 downto 6 )    * beta;
      mulBB := colorInB( 15 downto 11 )   * beta;

      
      outR := mulAR( 9 downto 5 ) + mulBR( 9 downto 5 );
      outG := mulAG( 9 downto 5 ) + mulBG( 9 downto 5 );
      outB := mulAB( 9 downto 5 ) + mulBB( 9 downto 5 );
      
      
      colorOut <= outB & outG & "0" & outR;
      
   end if; -- rising_edge( clock )
   
end process;



end behavior;
