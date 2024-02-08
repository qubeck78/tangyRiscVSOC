library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity inputSync is

generic(

    inputWidth              : integer := 1

);

port(

    clock:                          in  std_logic;

    signalInput:                    in  std_logic_vector( inputWidth - 1 downto 0 );
    signalOutput:                   out std_logic_vector( inputWidth - 1 downto 0 )

);

end inputSync;

architecture behavior of inputSync is

constant signalWidth:   integer := inputWidth - 1;

signal stage1Reg:   std_logic_vector( signalWidth downto 0 );
signal stage2Reg:   std_logic_vector( signalWidth downto 0 );
signal stage3Reg:   std_logic_vector( signalWidth downto 0 );


begin


signalOutput <= stage3Reg;

stage1: process( all )
begin

    if rising_edge( clock ) then

        stage1Reg <= signalInput;

    end if;

end process;

stage2: process( all )
begin

    if rising_edge( clock ) then

        stage2Reg <= stage1Reg;

    end if;

end process;

stage3: process( all )
begin

    if rising_edge( clock ) then

        stage3Reg <= stage2Reg;

    end if;

end process;



end behavior;
