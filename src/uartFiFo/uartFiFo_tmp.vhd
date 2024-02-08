--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Thu Feb  8 12:48:04 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component uartFiFo
	port (
		Data: in std_logic_vector(7 downto 0);
		Clk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Reset: in std_logic;
		Q: out std_logic_vector(7 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

your_instance_name: uartFiFo
	port map (
		Data => Data_i,
		Clk => Clk_i,
		WrEn => WrEn_i,
		RdEn => RdEn_i,
		Reset => Reset_i,
		Q => Q_o,
		Empty => Empty_o,
		Full => Full_o
	);

----------Copy end-------------------
