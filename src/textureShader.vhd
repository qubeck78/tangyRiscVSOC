library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity textureShader is

port(
   --reset
    reset:                          in  std_logic;
    clock:                          in  std_logic;
       
    colorIn:                        in  std_logic_vector( 15 downto 0 );
    lightIn:                        in  std_logic_vector( 4 downto 0 );
    colorOut:                       out std_logic_vector( 15 downto 0 )
);

end textureShader;

architecture behavior of textureShader is

--signal mulr: std_logic_vector( 9 downto 0 );
--signal mulg: std_logic_vector( 9 downto 0 );
--signal mulb: std_logic_vector( 9 downto 0 );

begin

main: process( all )

variable mulr: std_logic_vector( 9 downto 0 );
variable mulg: std_logic_vector( 9 downto 0 );
variable mulb: std_logic_vector( 9 downto 0 );


begin

   if rising_edge( clock ) then
   

      mulr :=  colorIn( 4 downto 0 )   * lightIn;
      mulg :=  colorIn( 10 downto 6 )  * lightIn;
      mulb :=  colorIn( 15 downto 11 ) * lightIn;
      
      colorOut <= mulb( 9 downto 5 ) & mulg( 9 downto 5 ) & "0" & mulr( 9 downto 5 );
      
   end if; -- rising_edge( clock )
   
end process;



end behavior;
