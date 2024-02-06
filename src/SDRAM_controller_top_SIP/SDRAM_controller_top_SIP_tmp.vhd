--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Mon Feb  5 12:55:29 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component SDRAM_controller_top_SIP
	port (
		O_sdram_clk: out std_logic;
		O_sdram_cke: out std_logic;
		O_sdram_cs_n: out std_logic;
		O_sdram_cas_n: out std_logic;
		O_sdram_ras_n: out std_logic;
		O_sdram_wen_n: out std_logic;
		O_sdram_dqm: out std_logic_vector(3 downto 0);
		O_sdram_addr: out std_logic_vector(10 downto 0);
		O_sdram_ba: out std_logic_vector(1 downto 0);
		IO_sdram_dq: inout std_logic_vector(31 downto 0);
		I_sdrc_rst_n: in std_logic;
		I_sdrc_clk: in std_logic;
		I_sdram_clk: in std_logic;
		I_sdrc_selfrefresh: in std_logic;
		I_sdrc_power_down: in std_logic;
		I_sdrc_wr_n: in std_logic;
		I_sdrc_rd_n: in std_logic;
		I_sdrc_addr: in std_logic_vector(20 downto 0);
		I_sdrc_data_len: in std_logic_vector(7 downto 0);
		I_sdrc_dqm: in std_logic_vector(3 downto 0);
		I_sdrc_data: in std_logic_vector(31 downto 0);
		O_sdrc_data: out std_logic_vector(31 downto 0);
		O_sdrc_init_done: out std_logic;
		O_sdrc_busy_n: out std_logic;
		O_sdrc_rd_valid: out std_logic;
		O_sdrc_wrd_ack: out std_logic
	);
end component;

your_instance_name: SDRAM_controller_top_SIP
	port map (
		O_sdram_clk => O_sdram_clk_o,
		O_sdram_cke => O_sdram_cke_o,
		O_sdram_cs_n => O_sdram_cs_n_o,
		O_sdram_cas_n => O_sdram_cas_n_o,
		O_sdram_ras_n => O_sdram_ras_n_o,
		O_sdram_wen_n => O_sdram_wen_n_o,
		O_sdram_dqm => O_sdram_dqm_o,
		O_sdram_addr => O_sdram_addr_o,
		O_sdram_ba => O_sdram_ba_o,
		IO_sdram_dq => IO_sdram_dq_io,
		I_sdrc_rst_n => I_sdrc_rst_n_i,
		I_sdrc_clk => I_sdrc_clk_i,
		I_sdram_clk => I_sdram_clk_i,
		I_sdrc_selfrefresh => I_sdrc_selfrefresh_i,
		I_sdrc_power_down => I_sdrc_power_down_i,
		I_sdrc_wr_n => I_sdrc_wr_n_i,
		I_sdrc_rd_n => I_sdrc_rd_n_i,
		I_sdrc_addr => I_sdrc_addr_i,
		I_sdrc_data_len => I_sdrc_data_len_i,
		I_sdrc_dqm => I_sdrc_dqm_i,
		I_sdrc_data => I_sdrc_data_i,
		O_sdrc_data => O_sdrc_data_o,
		O_sdrc_init_done => O_sdrc_init_done_o,
		O_sdrc_busy_n => O_sdrc_busy_n_o,
		O_sdrc_rd_valid => O_sdrc_rd_valid_o,
		O_sdrc_wrd_ack => O_sdrc_wrd_ack_o
	);

----------Copy end-------------------
