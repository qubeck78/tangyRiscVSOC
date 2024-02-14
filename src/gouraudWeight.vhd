library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity gouraudWeight is

port(
   --reset
    reset:                          in  std_logic;
    clock:                          in  std_logic;
    
    edge:                           in std_logic_vector( 31 downto 0 );
    area:                           in std_logic_vector( 31 downto 0 );
    
    weight:                         out std_logic_vector( 31 downto 0 )

);

end gouraudWeight;

architecture behavior of gouraudWeight is


component divider32s
	port (
		clk: in std_logic;
		rstn: in std_logic;
		dividend: in std_logic_vector(31 downto 0);
		divisor: in std_logic_vector(31 downto 0);
		quotient: out std_logic_vector(31 downto 0)
	);
end component;


begin

divider32sInst: divider32s
port map(
    
    clk         => clock,
    rstn        => not reset,
    dividend    => edge( 23 downto 0 ) & x"00",
    divisor     => area,
    
    quotient    => weight
);
   
end behavior;
