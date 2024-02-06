--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9 (64-bit)
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Mon Feb  5 13:03:43 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component clkdiv5
    port (
        clkout: out std_logic;
        hclkin: in std_logic;
        resetn: in std_logic
    );
end component;

your_instance_name: clkdiv5
    port map (
        clkout => clkout_o,
        hclkin => hclkin_i,
        resetn => resetn_i
    );

----------Copy end-------------------
