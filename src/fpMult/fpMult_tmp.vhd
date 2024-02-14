--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Wed Feb 14 11:06:46 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component fpMult
	port (
		clk: in std_logic;
		rstn: in std_logic;
		data_a: in std_logic_vector(31 downto 0);
		data_b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0)
	);
end component;

your_instance_name: fpMult
	port map (
		clk => clk_i,
		rstn => rstn_i,
		data_a => data_a_i,
		data_b => data_b_i,
		result => result_o
	);

----------Copy end-------------------
