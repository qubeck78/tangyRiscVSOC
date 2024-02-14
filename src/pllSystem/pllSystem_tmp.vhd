--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9 (64-bit)
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Wed Feb 14 09:27:08 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component pllSystem
    port (
        clkout: out std_logic;
        lock: out std_logic;
        clkoutp: out std_logic;
        clkoutd: out std_logic;
        reset: in std_logic;
        clkin: in std_logic
    );
end component;

your_instance_name: pllSystem
    port map (
        clkout => clkout_o,
        lock => lock_o,
        clkoutp => clkoutp_o,
        clkoutd => clkoutd_o,
        reset => reset_i,
        clkin => clkin_i
    );

----------Copy end-------------------
