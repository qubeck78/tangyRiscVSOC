--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Wed Feb 14 09:32:06 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component divider32s
	port (
		clk: in std_logic;
		rstn: in std_logic;
		dividend: in std_logic_vector(31 downto 0);
		divisor: in std_logic_vector(31 downto 0);
		quotient: out std_logic_vector(31 downto 0)
	);
end component;

your_instance_name: divider32s
	port map (
		clk => clk_i,
		rstn => rstn_i,
		dividend => dividend_i,
		divisor => divisor_i,
		quotient => quotient_o
	);

----------Copy end-------------------
