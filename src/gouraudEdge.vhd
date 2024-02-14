library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity gouraudEdge is

port(
   --reset
    reset:                          in  std_logic;
    clock:                          in  std_logic;
   
    e1_x:                           in std_logic_vector( 15 downto 0 );
    e1_y:                           in std_logic_vector( 15 downto 0 );
    
    e2_x:                           in std_logic_vector( 15 downto 0 );
    e2_y:                           in std_logic_vector( 15 downto 0 );

    p_x:                            in std_logic_vector( 15 downto 0 );
    p_y:                            in std_logic_vector( 15 downto 0 );

    
    edge:                           out std_logic_vector( 31 downto 0 )
);

end gouraudEdge;

architecture behavior of gouraudEdge is

signal   a_x:  std_logic_vector( 15 downto 0 );
signal   a_y:  std_logic_vector( 15 downto 0 );

signal   b_x:  std_logic_vector( 15 downto 0 );
signal   b_y:  std_logic_vector( 15 downto 0 );

signal   leftMult: std_logic_vector( 31 downto 0 );
signal   rightMult: std_logic_vector( 31 downto 0 );

begin

main: process( all )

begin

   if rising_edge( clock ) then
   
      if reset = '1' then
      
      
      else
      
         a_x         <= p_x - e1_x;
         a_y         <= p_y - e1_y;
         
         b_x         <= e2_x - e1_x;
         b_y         <= e2_y - e1_y;
         
         leftMult    <= a_x * b_y;
         rightMult   <= a_y * b_x;
         
         edge        <= leftMult - rightMult;
         
      end if; --reset = '1'
   
   end if; --rising_edge( clock )

end process;



end behavior;
