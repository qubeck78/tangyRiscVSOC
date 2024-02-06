--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: IP file
--Tool Version: V1.9.9 (64-bit)
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Mon Feb  5 13:03:43 2024

library IEEE;
use IEEE.std_logic_1164.all;

entity clkdiv5 is
    port (
        clkout: out std_logic;
        hclkin: in std_logic;
        resetn: in std_logic
    );
end clkdiv5;

architecture Behavioral of clkdiv5 is

    signal gw_gnd: std_logic;

    --component declaration
    component CLKDIV
        generic (
            GSREN: STRING := "false";
            DIV_MODE : STRING := "2"
        );
        port (
            CLKOUT: out std_logic;
            HCLKIN: in std_logic;
            RESETN: in std_logic;
            CALIB: in std_logic
        );
    end component;

begin
    gw_gnd <= '0';

    clkdiv_inst: CLKDIV
        generic map (
            GSREN => "false",
            DIV_MODE => "5"
        )
        port map (
            CLKOUT => clkout,
            HCLKIN => hclkin,
            RESETN => resetn,
            CALIB => gw_gnd
        );

end Behavioral; --clkdiv5
