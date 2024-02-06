--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9 (64-bit)
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Mon Feb  5 22:01:14 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component fontProm
    port (
        dout: out std_logic_vector(7 downto 0);
        clk: in std_logic;
        oce: in std_logic;
        ce: in std_logic;
        reset: in std_logic;
        ad: in std_logic_vector(10 downto 0)
    );
end component;

your_instance_name: fontProm
    port map (
        dout => dout_o,
        clk => clk_i,
        oce => oce_i,
        ce => ce_i,
        reset => reset_i,
        ad => ad_i
    );

----------Copy end-------------------
