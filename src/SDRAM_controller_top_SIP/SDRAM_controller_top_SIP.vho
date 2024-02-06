--
--Written by GowinSynthesis
--Tool Version "V1.9.9"
--Mon Feb  5 12:55:29 2024

--Source file index table:
--file0 "\C:/Users/qubec/Documents/Development/ProjektyVHDL/TangNano20K/tangyRiscVSOC/tangyRiscVSOC/src/SDRAM_controller_top_SIP/temp/SDRC_EMBEDDED/sdrc_defines.v"
--file1 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/SDRAM_controller_top_SIP.v"
--file2 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/sdrc_control_fsm.v"
--file3 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/sdrc_user_interface.v"
--file4 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/sdrc_autorefresh.v"
--file5 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/sdrc_top.v"
--file6 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/SDRC_EMB/data/GENERAL/top_defines.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw2a;
use gw2a.components.all;

entity SDRAM_controller_top_SIP is
port(
  O_sdram_clk :  out std_logic;
  O_sdram_cke :  out std_logic;
  O_sdram_cs_n :  out std_logic;
  O_sdram_cas_n :  out std_logic;
  O_sdram_ras_n :  out std_logic;
  O_sdram_wen_n :  out std_logic;
  O_sdram_dqm :  out std_logic_vector(3 downto 0);
  O_sdram_addr :  out std_logic_vector(10 downto 0);
  O_sdram_ba :  out std_logic_vector(1 downto 0);
  IO_sdram_dq :  inout std_logic_vector(31 downto 0);
  I_sdrc_rst_n :  in std_logic;
  I_sdrc_clk :  in std_logic;
  I_sdram_clk :  in std_logic;
  I_sdrc_selfrefresh :  in std_logic;
  I_sdrc_power_down :  in std_logic;
  I_sdrc_wr_n :  in std_logic;
  I_sdrc_rd_n :  in std_logic;
  I_sdrc_addr :  in std_logic_vector(20 downto 0);
  I_sdrc_data_len :  in std_logic_vector(7 downto 0);
  I_sdrc_dqm :  in std_logic_vector(3 downto 0);
  I_sdrc_data :  in std_logic_vector(31 downto 0);
  O_sdrc_data :  out std_logic_vector(31 downto 0);
  O_sdrc_init_done :  out std_logic;
  O_sdrc_busy_n :  out std_logic;
  O_sdrc_rd_valid :  out std_logic;
  O_sdrc_wrd_ack :  out std_logic);
end SDRAM_controller_top_SIP;
architecture beh of SDRAM_controller_top_SIP is
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\ : std_logic ;
  signal sdrc_top_inst_U0_ctrl_fsm_init : std_logic ;
  signal sdrc_top_inst_U0_I_selfrefresh_reg : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\ : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT\ : std_logic ;
  signal sdrc_top_inst_U0_Flag_sdrc_wrd : std_logic ;
  signal sdrc_top_inst_U0_ctrl_fsm_busy_n : std_logic ;
  signal sdrc_top_inst_U0_ctrl_fsm_data_valid : std_logic ;
  signal \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_IDLE\ : std_logic ;
  signal sdrc_top_inst_U1_ctrl_double_wrd_flag : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_IDLE\ : std_logic ;
  signal sdrc_top_inst_U1_Double_wrd_flag : std_logic ;
  signal sdrc_top_inst_U1_Sdrc_wr_n_i : std_logic ;
  signal sdrc_top_inst_U1_Sdrc_rd_n_i : std_logic ;
  signal sdrc_top_inst_U1_Sdrc_wr_n_i_reg : std_logic ;
  signal sdrc_top_inst_U1_Sdrc_rd_n_i_reg : std_logic ;
  signal sdrc_top_inst_U2_autorefresh_req : std_logic ;
  signal sdrc_top_inst_U2_autorefresh_req_a : std_logic ;
  signal sdrc_top_inst_U0_ctrl_fsm_wrd_done : std_logic ;
  signal sdrc_top_inst_U0_Ctrl_wr_data_valid : std_logic ;
  signal sdrc_top_inst_U0_Reset_autorefresh : std_logic ;
  signal sdrc_top_inst_U0_autorefresh_ack : std_logic ;
  signal sdrc_top_inst_U1_ctrl_fsm_rd_n : std_logic ;
  signal sdrc_top_inst_U1_ctrl_fsm_wr_n : std_logic ;
  signal sdrc_top_inst_U1_User_busy_flag_n : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WRITE\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ_2\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ_2_WAIT\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WAITING\ : std_logic ;
  signal sdrc_top_inst_U1_n245 : std_logic ;
  signal sdrc_top_inst_U1_n245_20 : std_logic ;
  signal sdrc_top_inst_U1_n245_21 : std_logic ;
  signal sdrc_top_inst_U1_n245_22 : std_logic ;
  signal sdrc_top_inst_U1_n245_23 : std_logic ;
  signal sdrc_top_inst_U1_n245_24 : std_logic ;
  signal sdrc_top_inst_U1_n245_25 : std_logic ;
  signal sdrc_top_inst_U1_n245_26 : std_logic ;
  signal sdrc_top_inst_U1_n245_27 : std_logic ;
  signal sdrc_top_inst_U1_n245_28 : std_logic ;
  signal sdrc_top_inst_U1_n245_29 : std_logic ;
  signal sdrc_top_inst_U1_n245_30 : std_logic ;
  signal sdrc_top_inst_U1_n245_31 : std_logic ;
  signal sdrc_top_inst_U1_n245_32 : std_logic ;
  signal sdrc_top_inst_U1_n435 : std_logic ;
  signal sdrc_top_inst_U1_n435_20 : std_logic ;
  signal sdrc_top_inst_U1_n435_21 : std_logic ;
  signal sdrc_top_inst_U1_n435_22 : std_logic ;
  signal sdrc_top_inst_U1_n435_23 : std_logic ;
  signal sdrc_top_inst_U1_n435_24 : std_logic ;
  signal sdrc_top_inst_U1_n435_25 : std_logic ;
  signal sdrc_top_inst_U1_n435_26 : std_logic ;
  signal sdrc_top_inst_U1_n435_27 : std_logic ;
  signal sdrc_top_inst_U1_n435_28 : std_logic ;
  signal sdrc_top_inst_U1_n435_29 : std_logic ;
  signal sdrc_top_inst_U1_n435_30 : std_logic ;
  signal sdrc_top_inst_U1_n435_31 : std_logic ;
  signal sdrc_top_inst_U1_n435_32 : std_logic ;
  signal sdrc_top_inst_U1_User_data_i_0 : std_logic ;
  signal sdrc_top_inst_U1_n128 : std_logic ;
  signal sdrc_top_inst_U1_n128_2 : std_logic ;
  signal sdrc_top_inst_U1_n127 : std_logic ;
  signal sdrc_top_inst_U1_n127_2 : std_logic ;
  signal sdrc_top_inst_U1_n126 : std_logic ;
  signal sdrc_top_inst_U1_n126_2 : std_logic ;
  signal sdrc_top_inst_U1_n125 : std_logic ;
  signal sdrc_top_inst_U1_n125_2 : std_logic ;
  signal sdrc_top_inst_U1_n124 : std_logic ;
  signal sdrc_top_inst_U1_n124_2 : std_logic ;
  signal sdrc_top_inst_U1_n123 : std_logic ;
  signal sdrc_top_inst_U1_n123_2 : std_logic ;
  signal sdrc_top_inst_U1_n122 : std_logic ;
  signal sdrc_top_inst_U1_n122_2 : std_logic ;
  signal sdrc_top_inst_U1_n121 : std_logic ;
  signal sdrc_top_inst_U1_n121_2 : std_logic ;
  signal sdrc_top_inst_U1_n120 : std_logic ;
  signal sdrc_top_inst_U1_n120_2 : std_logic ;
  signal sdrc_top_inst_U1_n119 : std_logic ;
  signal sdrc_top_inst_U1_n119_2 : std_logic ;
  signal sdrc_top_inst_U1_n118 : std_logic ;
  signal sdrc_top_inst_U1_n118_2 : std_logic ;
  signal sdrc_top_inst_U1_n117 : std_logic ;
  signal sdrc_top_inst_U1_n117_2 : std_logic ;
  signal sdrc_top_inst_U1_n981 : std_logic ;
  signal sdrc_top_inst_U1_n981_2 : std_logic ;
  signal sdrc_top_inst_U1_n980 : std_logic ;
  signal sdrc_top_inst_U1_n980_2 : std_logic ;
  signal sdrc_top_inst_U1_n979 : std_logic ;
  signal sdrc_top_inst_U1_n979_2 : std_logic ;
  signal sdrc_top_inst_U1_n978 : std_logic ;
  signal sdrc_top_inst_U1_n978_2 : std_logic ;
  signal sdrc_top_inst_U1_n977 : std_logic ;
  signal sdrc_top_inst_U1_n977_2 : std_logic ;
  signal sdrc_top_inst_U1_n976 : std_logic ;
  signal sdrc_top_inst_U1_n976_2 : std_logic ;
  signal sdrc_top_inst_U1_n975 : std_logic ;
  signal sdrc_top_inst_U1_n975_2 : std_logic ;
  signal sdrc_top_inst_U1_n974 : std_logic ;
  signal sdrc_top_inst_U1_n974_2 : std_logic ;
  signal sdrc_top_inst_U0_n509 : std_logic ;
  signal sdrc_top_inst_U0_n509_3 : std_logic ;
  signal sdrc_top_inst_U0_n510 : std_logic ;
  signal sdrc_top_inst_U0_n510_3 : std_logic ;
  signal sdrc_top_inst_U0_n511 : std_logic ;
  signal sdrc_top_inst_U0_n511_3 : std_logic ;
  signal sdrc_top_inst_U0_n512 : std_logic ;
  signal sdrc_top_inst_U0_n512_3 : std_logic ;
  signal sdrc_top_inst_U0_n513 : std_logic ;
  signal sdrc_top_inst_U0_n513_3 : std_logic ;
  signal sdrc_top_inst_U0_n514 : std_logic ;
  signal sdrc_top_inst_U0_n514_3 : std_logic ;
  signal sdrc_top_inst_U0_n515 : std_logic ;
  signal sdrc_top_inst_U0_n515_3 : std_logic ;
  signal sdrc_top_inst_U0_n516 : std_logic ;
  signal sdrc_top_inst_U0_n516_3 : std_logic ;
  signal sdrc_top_inst_U0_n529 : std_logic ;
  signal sdrc_top_inst_U0_n529_3 : std_logic ;
  signal sdrc_top_inst_U0_n530 : std_logic ;
  signal sdrc_top_inst_U0_n530_3 : std_logic ;
  signal sdrc_top_inst_U0_n531 : std_logic ;
  signal sdrc_top_inst_U0_n531_3 : std_logic ;
  signal sdrc_top_inst_U0_n532 : std_logic ;
  signal sdrc_top_inst_U0_n532_3 : std_logic ;
  signal sdrc_top_inst_U0_n533 : std_logic ;
  signal sdrc_top_inst_U0_n533_3 : std_logic ;
  signal sdrc_top_inst_U0_n534 : std_logic ;
  signal sdrc_top_inst_U0_n534_3 : std_logic ;
  signal sdrc_top_inst_U0_n535 : std_logic ;
  signal sdrc_top_inst_U0_n535_3 : std_logic ;
  signal sdrc_top_inst_U0_n536 : std_logic ;
  signal sdrc_top_inst_U0_n536_3 : std_logic ;
  signal sdrc_top_inst_U0_Reset_init_count : std_logic ;
  signal sdrc_top_inst_U0_n243 : std_logic ;
  signal sdrc_top_inst_U0_Reset_cmd_count : std_logic ;
  signal sdrc_top_inst_U0_n273 : std_logic ;
  signal sdrc_top_inst_U0_n274 : std_logic ;
  signal sdrc_top_inst_U0_n275 : std_logic ;
  signal sdrc_top_inst_U0_n277 : std_logic ;
  signal sdrc_top_inst_U0_n278 : std_logic ;
  signal sdrc_top_inst_U0_n956 : std_logic ;
  signal sdrc_top_inst_U1_n9 : std_logic ;
  signal sdrc_top_inst_U1_n1594 : std_logic ;
  signal sdrc_top_inst_U1_n983 : std_logic ;
  signal sdrc_top_inst_U1_n984 : std_logic ;
  signal sdrc_top_inst_U1_n985 : std_logic ;
  signal sdrc_top_inst_U1_n986 : std_logic ;
  signal sdrc_top_inst_U1_n987 : std_logic ;
  signal sdrc_top_inst_U1_n988 : std_logic ;
  signal sdrc_top_inst_U1_n989 : std_logic ;
  signal sdrc_top_inst_U1_n990 : std_logic ;
  signal sdrc_top_inst_U2_n73 : std_logic ;
  signal sdrc_top_inst_U0_n962 : std_logic ;
  signal sdrc_top_inst_U0_O_ctrl_fsm_wrd_done : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_data_31 : std_logic ;
  signal sdrc_top_inst_U0_n661 : std_logic ;
  signal sdrc_top_inst_U1_n95 : std_logic ;
  signal sdrc_top_inst_U1_n645 : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\ : std_logic ;
  signal sdrc_top_inst_U0_n927 : std_logic ;
  signal sdrc_top_inst_U0_n930 : std_logic ;
  signal sdrc_top_inst_U0_n961 : std_logic ;
  signal sdrc_top_inst_U0_n964 : std_logic ;
  signal sdrc_top_inst_U0_n966 : std_logic ;
  signal sdrc_top_inst_U0_n974 : std_logic ;
  signal sdrc_top_inst_U0_n976 : std_logic ;
  signal sdrc_top_inst_U0_n980 : std_logic ;
  signal sdrc_top_inst_U0_n982 : std_logic ;
  signal sdrc_top_inst_U0_n984 : std_logic ;
  signal sdrc_top_inst_U0_n986 : std_logic ;
  signal sdrc_top_inst_U0_n626 : std_logic ;
  signal sdrc_top_inst_U0_n636 : std_logic ;
  signal sdrc_top_inst_U0_n642 : std_logic ;
  signal sdrc_top_inst_U0_n652 : std_logic ;
  signal sdrc_top_inst_U1_n96 : std_logic ;
  signal sdrc_top_inst_U1_n97 : std_logic ;
  signal sdrc_top_inst_U1_n98 : std_logic ;
  signal sdrc_top_inst_U1_n645_15 : std_logic ;
  signal sdrc_top_inst_U1_n570 : std_logic ;
  signal sdrc_top_inst_U1_n572 : std_logic ;
  signal sdrc_top_inst_U1_n574 : std_logic ;
  signal sdrc_top_inst_U1_n576 : std_logic ;
  signal sdrc_top_inst_U1_n578 : std_logic ;
  signal sdrc_top_inst_U1_n580 : std_logic ;
  signal sdrc_top_inst_U1_n582 : std_logic ;
  signal sdrc_top_inst_U1_n584 : std_logic ;
  signal sdrc_top_inst_U1_n586 : std_logic ;
  signal sdrc_top_inst_U1_n588 : std_logic ;
  signal sdrc_top_inst_U1_n590 : std_logic ;
  signal sdrc_top_inst_U1_n592 : std_logic ;
  signal sdrc_top_inst_U1_n594 : std_logic ;
  signal sdrc_top_inst_U1_n596 : std_logic ;
  signal sdrc_top_inst_U1_n598 : std_logic ;
  signal sdrc_top_inst_U1_n600 : std_logic ;
  signal sdrc_top_inst_U1_n602 : std_logic ;
  signal sdrc_top_inst_U1_n604 : std_logic ;
  signal sdrc_top_inst_U1_n606 : std_logic ;
  signal sdrc_top_inst_U1_n608 : std_logic ;
  signal sdrc_top_inst_U1_n610 : std_logic ;
  signal sdrc_top_inst_U1_n625 : std_logic ;
  signal sdrc_top_inst_U1_n627 : std_logic ;
  signal sdrc_top_inst_U1_n629 : std_logic ;
  signal sdrc_top_inst_U1_n631 : std_logic ;
  signal sdrc_top_inst_U1_n633 : std_logic ;
  signal sdrc_top_inst_U1_n635 : std_logic ;
  signal sdrc_top_inst_U1_n637 : std_logic ;
  signal sdrc_top_inst_U1_n639 : std_logic ;
  signal sdrc_top_inst_U0_n95 : std_logic ;
  signal sdrc_top_inst_U0_n97 : std_logic ;
  signal sdrc_top_inst_U0_n99 : std_logic ;
  signal sdrc_top_inst_U0_n101 : std_logic ;
  signal sdrc_top_inst_U0_n103 : std_logic ;
  signal sdrc_top_inst_U0_n105 : std_logic ;
  signal sdrc_top_inst_U0_n107 : std_logic ;
  signal sdrc_top_inst_U0_n109 : std_logic ;
  signal sdrc_top_inst_U0_n111 : std_logic ;
  signal sdrc_top_inst_U0_n596 : std_logic ;
  signal sdrc_top_inst_U0_n598 : std_logic ;
  signal sdrc_top_inst_U0_n600 : std_logic ;
  signal sdrc_top_inst_U0_n602 : std_logic ;
  signal sdrc_top_inst_U0_n606 : std_logic ;
  signal sdrc_top_inst_U0_n608 : std_logic ;
  signal sdrc_top_inst_U0_n610 : std_logic ;
  signal sdrc_top_inst_U0_n612 : std_logic ;
  signal sdrc_top_inst_U0_n614 : std_logic ;
  signal sdrc_top_inst_U0_n616 : std_logic ;
  signal sdrc_top_inst_U0_n618 : std_logic ;
  signal sdrc_top_inst_U0_n620 : std_logic ;
  signal sdrc_top_inst_U0_n622 : std_logic ;
  signal sdrc_top_inst_U0_n624 : std_logic ;
  signal sdrc_top_inst_U1_n547 : std_logic ;
  signal sdrc_top_inst_U1_n548 : std_logic ;
  signal sdrc_top_inst_U1_n549 : std_logic ;
  signal sdrc_top_inst_U1_n562 : std_logic ;
  signal sdrc_top_inst_U1_n565 : std_logic ;
  signal sdrc_top_inst_U1_n559 : std_logic ;
  signal sdrc_top_inst_U0_n955 : std_logic ;
  signal sdrc_top_inst_U0_n968 : std_logic ;
  signal sdrc_top_inst_U0_n970 : std_logic ;
  signal sdrc_top_inst_U0_n972 : std_logic ;
  signal sdrc_top_inst_U1_n648 : std_logic ;
  signal sdrc_top_inst_U1_n654 : std_logic ;
  signal sdrc_top_inst_U1_n657 : std_logic ;
  signal sdrc_top_inst_U1_n660 : std_logic ;
  signal sdrc_top_inst_U1_n663 : std_logic ;
  signal sdrc_top_inst_U1_n666 : std_logic ;
  signal sdrc_top_inst_U1_n669 : std_logic ;
  signal sdrc_top_inst_U0_n93 : std_logic ;
  signal sdrc_top_inst_U1_n568 : std_logic ;
  signal sdrc_top_inst_U2_n52 : std_logic ;
  signal sdrc_top_inst_U2_n49 : std_logic ;
  signal sdrc_top_inst_U2_n48 : std_logic ;
  signal sdrc_top_inst_U2_n55 : std_logic ;
  signal sdrc_top_inst_U0_O_autorefresh_ack : std_logic ;
  signal sdrc_top_inst_U1_O_sdrc_wrd_ack : std_logic ;
  signal sdrc_top_inst_U0_n9 : std_logic ;
  signal sdrc_top_inst_U0_n8 : std_logic ;
  signal sdrc_top_inst_U0_n7 : std_logic ;
  signal sdrc_top_inst_U0_n155 : std_logic ;
  signal sdrc_top_inst_U0_n154 : std_logic ;
  signal sdrc_top_inst_U0_n153 : std_logic ;
  signal sdrc_top_inst_U1_n13 : std_logic ;
  signal sdrc_top_inst_U1_n12 : std_logic ;
  signal sdrc_top_inst_U1_n11 : std_logic ;
  signal sdrc_top_inst_U0_n272 : std_logic ;
  signal sdrc_top_inst_U0_n274_4 : std_logic ;
  signal sdrc_top_inst_U0_n275_4 : std_logic ;
  signal sdrc_top_inst_U0_n277_4 : std_logic ;
  signal sdrc_top_inst_U0_n959 : std_logic ;
  signal sdrc_top_inst_U0_n959_5 : std_logic ;
  signal sdrc_top_inst_U1_n984_5 : std_logic ;
  signal sdrc_top_inst_U1_n984_6 : std_logic ;
  signal sdrc_top_inst_U1_n986_4 : std_logic ;
  signal sdrc_top_inst_U1_n987_4 : std_logic ;
  signal sdrc_top_inst_U1_n988_4 : std_logic ;
  signal sdrc_top_inst_U1_n989_4 : std_logic ;
  signal sdrc_top_inst_U1_n990_4 : std_logic ;
  signal sdrc_top_inst_U2_n73_5 : std_logic ;
  signal sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6 : std_logic ;
  signal sdrc_top_inst_U0_Flag_sdrc_wrd_8 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_data_31_8 : std_logic ;
  signal sdrc_top_inst_U1_n562_19 : std_logic ;
  signal sdrc_top_inst_U1_n559_18 : std_logic ;
  signal sdrc_top_inst_U1_n648_18 : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ_9\ : std_logic ;
  signal \sdrc_top_inst_U1_User_model_state.STATE_READ_10\ : std_logic ;
  signal sdrc_top_inst_U0_n927_9 : std_logic ;
  signal sdrc_top_inst_U0_n927_10 : std_logic ;
  signal sdrc_top_inst_U0_n930_9 : std_logic ;
  signal sdrc_top_inst_U0_n958 : std_logic ;
  signal sdrc_top_inst_U0_n974_11 : std_logic ;
  signal sdrc_top_inst_U0_n976_11 : std_logic ;
  signal sdrc_top_inst_U0_n980_11 : std_logic ;
  signal sdrc_top_inst_U0_n982_11 : std_logic ;
  signal sdrc_top_inst_U0_n984_11 : std_logic ;
  signal sdrc_top_inst_U0_n986_11 : std_logic ;
  signal sdrc_top_inst_U0_n634 : std_logic ;
  signal sdrc_top_inst_U0_n650 : std_logic ;
  signal sdrc_top_inst_U1_n95_16 : std_logic ;
  signal sdrc_top_inst_U1_n95_17 : std_logic ;
  signal sdrc_top_inst_U1_n96_15 : std_logic ;
  signal sdrc_top_inst_U1_n96_16 : std_logic ;
  signal sdrc_top_inst_U1_n97_14 : std_logic ;
  signal sdrc_top_inst_U1_n97_15 : std_logic ;
  signal sdrc_top_inst_U1_n97_16 : std_logic ;
  signal sdrc_top_inst_U1_n98_15 : std_logic ;
  signal sdrc_top_inst_U1_n98_16 : std_logic ;
  signal sdrc_top_inst_U1_n645_16 : std_logic ;
  signal sdrc_top_inst_U1_n642 : std_logic ;
  signal sdrc_top_inst_U1_n570_13 : std_logic ;
  signal sdrc_top_inst_U1_n570_14 : std_logic ;
  signal sdrc_top_inst_U1_n572_13 : std_logic ;
  signal sdrc_top_inst_U1_n574_13 : std_logic ;
  signal sdrc_top_inst_U1_n576_13 : std_logic ;
  signal sdrc_top_inst_U1_n578_13 : std_logic ;
  signal sdrc_top_inst_U1_n580_13 : std_logic ;
  signal sdrc_top_inst_U1_n582_13 : std_logic ;
  signal sdrc_top_inst_U1_n584_13 : std_logic ;
  signal sdrc_top_inst_U1_n586_13 : std_logic ;
  signal sdrc_top_inst_U1_n588_13 : std_logic ;
  signal sdrc_top_inst_U1_n590_13 : std_logic ;
  signal sdrc_top_inst_U1_n592_13 : std_logic ;
  signal sdrc_top_inst_U1_n594_13 : std_logic ;
  signal sdrc_top_inst_U1_n625_13 : std_logic ;
  signal sdrc_top_inst_U1_n627_13 : std_logic ;
  signal sdrc_top_inst_U1_n629_13 : std_logic ;
  signal sdrc_top_inst_U1_n631_13 : std_logic ;
  signal sdrc_top_inst_U1_n633_13 : std_logic ;
  signal sdrc_top_inst_U1_n635_13 : std_logic ;
  signal sdrc_top_inst_U1_n637_13 : std_logic ;
  signal sdrc_top_inst_U1_n639_13 : std_logic ;
  signal sdrc_top_inst_U0_n95_15 : std_logic ;
  signal sdrc_top_inst_U0_n99_15 : std_logic ;
  signal sdrc_top_inst_U0_n103_15 : std_logic ;
  signal sdrc_top_inst_U0_n593 : std_logic ;
  signal sdrc_top_inst_U0_n596_24 : std_logic ;
  signal sdrc_top_inst_U0_n596_26 : std_logic ;
  signal sdrc_top_inst_U0_n598_25 : std_logic ;
  signal sdrc_top_inst_U0_n598_26 : std_logic ;
  signal sdrc_top_inst_U0_n606_23 : std_logic ;
  signal sdrc_top_inst_U0_n606_24 : std_logic ;
  signal sdrc_top_inst_U0_n608_24 : std_logic ;
  signal sdrc_top_inst_U0_n612_24 : std_logic ;
  signal sdrc_top_inst_U0_n616_24 : std_logic ;
  signal sdrc_top_inst_U0_n618_24 : std_logic ;
  signal sdrc_top_inst_U1_n547_21 : std_logic ;
  signal sdrc_top_inst_U1_n547_23 : std_logic ;
  signal sdrc_top_inst_U1_n550 : std_logic ;
  signal sdrc_top_inst_U1_n554 : std_logic ;
  signal sdrc_top_inst_U1_n559_19 : std_logic ;
  signal sdrc_top_inst_U0_n955_11 : std_logic ;
  signal sdrc_top_inst_U0_n968_11 : std_logic ;
  signal sdrc_top_inst_U0_n970_11 : std_logic ;
  signal sdrc_top_inst_U0_n972_11 : std_logic ;
  signal sdrc_top_inst_U1_n648_19 : std_logic ;
  signal sdrc_top_inst_U1_n648_20 : std_logic ;
  signal sdrc_top_inst_U1_n657_16 : std_logic ;
  signal sdrc_top_inst_U1_n657_17 : std_logic ;
  signal sdrc_top_inst_U1_n663_16 : std_logic ;
  signal sdrc_top_inst_U1_n663_17 : std_logic ;
  signal sdrc_top_inst_U2_n54 : std_logic ;
  signal sdrc_top_inst_U2_n51 : std_logic ;
  signal sdrc_top_inst_U2_n50 : std_logic ;
  signal sdrc_top_inst_U2_n49_8 : std_logic ;
  signal sdrc_top_inst_U2_n48_8 : std_logic ;
  signal sdrc_top_inst_U2_n46 : std_logic ;
  signal sdrc_top_inst_U2_n45 : std_logic ;
  signal sdrc_top_inst_U2_n44 : std_logic ;
  signal sdrc_top_inst_U2_n55_7 : std_logic ;
  signal sdrc_top_inst_U0_n705 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7 : std_logic ;
  signal sdrc_top_inst_U0_O_autorefresh_ack_7 : std_logic ;
  signal sdrc_top_inst_U1_n984_7 : std_logic ;
  signal sdrc_top_inst_U1_n984_8 : std_logic ;
  signal sdrc_top_inst_U1_n984_9 : std_logic ;
  signal sdrc_top_inst_U1_n984_10 : std_logic ;
  signal sdrc_top_inst_U2_n73_6 : std_logic ;
  signal sdrc_top_inst_U0_Flag_sdrc_wrd_9 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_data_31_9 : std_logic ;
  signal sdrc_top_inst_U0_n927_11 : std_logic ;
  signal sdrc_top_inst_U1_n95_20 : std_logic ;
  signal sdrc_top_inst_U1_n98_17 : std_logic ;
  signal sdrc_top_inst_U1_n645_17 : std_logic ;
  signal sdrc_top_inst_U0_n593_24 : std_logic ;
  signal sdrc_top_inst_U0_n596_27 : std_logic ;
  signal sdrc_top_inst_U0_n596_28 : std_logic ;
  signal sdrc_top_inst_U0_n596_29 : std_logic ;
  signal sdrc_top_inst_U0_n596_30 : std_logic ;
  signal sdrc_top_inst_U0_n598_27 : std_logic ;
  signal sdrc_top_inst_U0_n606_25 : std_logic ;
  signal sdrc_top_inst_U0_n618_25 : std_logic ;
  signal sdrc_top_inst_U0_n618_26 : std_logic ;
  signal sdrc_top_inst_U1_n547_24 : std_logic ;
  signal sdrc_top_inst_U1_n648_21 : std_logic ;
  signal sdrc_top_inst_U1_n984_11 : std_logic ;
  signal sdrc_top_inst_U1_n984_12 : std_logic ;
  signal sdrc_top_inst_U1_n984_13 : std_logic ;
  signal sdrc_top_inst_U1_n984_14 : std_logic ;
  signal sdrc_top_inst_U0_n927_12 : std_logic ;
  signal sdrc_top_inst_U0_n596_31 : std_logic ;
  signal sdrc_top_inst_U1_n648_22 : std_logic ;
  signal sdrc_top_inst_U0_n273_6 : std_logic ;
  signal sdrc_top_inst_U0_n276 : std_logic ;
  signal sdrc_top_inst_U0_n620_25 : std_logic ;
  signal sdrc_top_inst_U0_n616_27 : std_logic ;
  signal sdrc_top_inst_U0_n632 : std_logic ;
  signal sdrc_top_inst_U0_n648 : std_logic ;
  signal sdrc_top_inst_U0_n705_8 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7_9 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_6 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_5 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_4 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_3 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_2 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_1 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_col_0 : std_logic ;
  signal sdrc_top_inst_U1_n654_18 : std_logic ;
  signal sdrc_top_inst_U1_n96_18 : std_logic ;
  signal sdrc_top_inst_U2_Count_autorefresh_11 : std_logic ;
  signal sdrc_top_inst_U0_n604 : std_logic ;
  signal sdrc_top_inst_U0_n593_26 : std_logic ;
  signal sdrc_top_inst_U0_n97_17 : std_logic ;
  signal sdrc_top_inst_U0_n959_7 : std_logic ;
  signal sdrc_top_inst_U0_n101_17 : std_logic ;
  signal sdrc_top_inst_U1_n657_21 : std_logic ;
  signal sdrc_top_inst_U1_n559_22 : std_logic ;
  signal sdrc_top_inst_U1_n547_26 : std_logic ;
  signal sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1 : std_logic ;
  signal sdrc_top_inst_U1_n562_22 : std_logic ;
  signal sdrc_top_inst_U1_n657_23 : std_logic ;
  signal sdrc_top_inst_U0_n598_31 : std_logic ;
  signal sdrc_top_inst_U0_n600_25 : std_logic ;
  signal sdrc_top_inst_U1_n985_6 : std_logic ;
  signal sdrc_top_inst_U1_n984_16 : std_logic ;
  signal sdrc_top_inst_U1_n983_6 : std_logic ;
  signal sdrc_top_inst_U1_n1714 : std_logic ;
  signal sdrc_top_inst_U1_n556 : std_logic ;
  signal sdrc_top_inst_U1_n554_32 : std_logic ;
  signal sdrc_top_inst_U1_n562_24 : std_logic ;
  signal sdrc_top_inst_U1_n642_19 : std_logic ;
  signal sdrc_top_inst_U1_n642_21 : std_logic ;
  signal sdrc_top_inst_U1_n555 : std_logic ;
  signal sdrc_top_inst_U1_n553 : std_logic ;
  signal sdrc_top_inst_U1_n551 : std_logic ;
  signal sdrc_top_inst_U1_n550_31 : std_logic ;
  signal sdrc_top_inst_U1_n648_26 : std_logic ;
  signal sdrc_top_inst_U1_n95_22 : std_logic ;
  signal sdrc_top_inst_U1_n95_24 : std_logic ;
  signal sdrc_top_inst_U1_n95_26 : std_logic ;
  signal sdrc_top_inst_U2_n47 : std_logic ;
  signal sdrc_top_inst_U1_n982 : std_logic ;
  signal sdrc_top_inst_U0_n958_13 : std_logic ;
  signal sdrc_top_inst_U0_Ctrl_fsm_addr_col_7 : std_logic ;
  signal sdrc_top_inst_U0_Flag_sdrc_wrd_13 : std_logic ;
  signal sdrc_top_inst_U0_n596_35 : std_logic ;
  signal sdrc_top_inst_U0_n279 : std_logic ;
  signal sdrc_top_inst_U0_n276_8 : std_logic ;
  signal sdrc_top_inst_U0_n272_6 : std_logic ;
  signal sdrc_top_inst_U0_Flag_autorefresh : std_logic ;
  signal sdrc_top_inst_U0_Flag_autorefresh0 : std_logic ;
  signal sdrc_top_inst_U1_n1692 : std_logic ;
  signal sdrc_top_inst_U0_n132 : std_logic ;
  signal sdrc_top_inst_U0_n132_14 : std_logic ;
  signal sdrc_top_inst_U0_Ctrl_wr_data_valid_13 : std_logic ;
  signal sdrc_top_inst_U2_n44_11 : std_logic ;
  signal sdrc_top_inst_U2_Count_autorefresh_11_21 : std_logic ;
  signal sdrc_top_inst_U2_n45_11 : std_logic ;
  signal sdrc_top_inst_U2_n46_13 : std_logic ;
  signal sdrc_top_inst_U2_n47_15 : std_logic ;
  signal sdrc_top_inst_U2_n50_11 : std_logic ;
  signal sdrc_top_inst_U2_n51_11 : std_logic ;
  signal sdrc_top_inst_U2_n53 : std_logic ;
  signal sdrc_top_inst_U2_n54_13 : std_logic ;
  signal sdrc_top_inst_U0_n628 : std_logic ;
  signal sdrc_top_inst_U0_n626_19 : std_logic ;
  signal sdrc_top_inst_U0_n632_17 : std_logic ;
  signal sdrc_top_inst_U0_n634_15 : std_logic ;
  signal sdrc_top_inst_U0_n638 : std_logic ;
  signal sdrc_top_inst_U0_n640 : std_logic ;
  signal sdrc_top_inst_U0_n644 : std_logic ;
  signal sdrc_top_inst_U0_n642_19 : std_logic ;
  signal sdrc_top_inst_U0_n648_17 : std_logic ;
  signal sdrc_top_inst_U0_n650_15 : std_logic ;
  signal sdrc_top_inst_U0_n654 : std_logic ;
  signal sdrc_top_inst_U0_n656 : std_logic ;
  signal sdrc_top_inst_U0_n856 : std_logic ;
  signal sdrc_top_inst_U0_n857 : std_logic ;
  signal sdrc_top_inst_U0_n858 : std_logic ;
  signal sdrc_top_inst_U0_n859 : std_logic ;
  signal sdrc_top_inst_U0_n630 : std_logic ;
  signal sdrc_top_inst_U0_n626_21 : std_logic ;
  signal sdrc_top_inst_U0_n646 : std_logic ;
  signal sdrc_top_inst_U0_n642_21 : std_logic ;
  signal sdrc_top_inst_U0_n963 : std_logic ;
  signal sdrc_top_inst_U1_n559_24 : std_logic ;
  signal sdrc_top_inst_U1_n651 : std_logic ;
  signal sdrc_top_inst_U2_Count_autorefresh_11_25 : std_logic ;
  signal sdrc_top_inst_U2_n73_11 : std_logic ;
  signal sdrc_top_inst_U0_n638_16 : std_logic ;
  signal sdrc_top_inst_U0_n634_17 : std_logic ;
  signal sdrc_top_inst_U0_n632_19 : std_logic ;
  signal sdrc_top_inst_U0_n630_19 : std_logic ;
  signal sdrc_top_inst_U0_n628_16 : std_logic ;
  signal sdrc_top_inst_U0_n654_16 : std_logic ;
  signal sdrc_top_inst_U0_n650_17 : std_logic ;
  signal sdrc_top_inst_U0_n648_19 : std_logic ;
  signal sdrc_top_inst_U0_n646_19 : std_logic ;
  signal sdrc_top_inst_U0_n644_16 : std_logic ;
  signal sdrc_top_inst_U1_n129 : std_logic ;
  signal sdrc_top_inst_U0_n316 : std_logic ;
  signal sdrc_top_inst_U0_IO_sdram_dq_0 : std_logic ;
  signal sdrc_top_inst_U0_n962_8 : std_logic ;
  signal sdrc_top_inst_U1_n1276 : std_logic ;
  signal sdrc_top_inst_U1_n1277 : std_logic ;
  signal sdrc_top_inst_U1_n1278 : std_logic ;
  signal sdrc_top_inst_U1_n1279 : std_logic ;
  signal sdrc_top_inst_U1_n1280 : std_logic ;
  signal sdrc_top_inst_U1_n1281 : std_logic ;
  signal sdrc_top_inst_U1_n1282 : std_logic ;
  signal sdrc_top_inst_U1_n1283 : std_logic ;
  signal sdrc_top_inst_U2_O_autorefresh_req : std_logic ;
  signal sdrc_top_inst_U0_n341 : std_logic ;
  signal sdrc_top_inst_U0_n10 : std_logic ;
  signal sdrc_top_inst_U0_n156 : std_logic ;
  signal sdrc_top_inst_U1_n14 : std_logic ;
  signal sdrc_top_inst_U1_User_data_i_0_24 : std_logic ;
  signal VCC_0 : std_logic ;
  signal IO_sdram_dq_in : std_logic_vector(31 downto 0);
  signal \sdrc_top_inst/U0/Count_init_delay\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U0/Count_cmd_delay\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U0/Ctrl_fsm_data\ : std_logic_vector(31 downto 0);
  signal \sdrc_top_inst/U0/Ctrl_fsm_addr_bk\ : std_logic_vector(1 downto 0);
  signal \sdrc_top_inst/U0/Ctrl_fsm_addr_row\ : std_logic_vector(10 downto 0);
  signal \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U0/ctrl_fsm_data1\ : std_logic_vector(31 downto 0);
  signal \sdrc_top_inst/U0/Rd_data_valid_reg\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U1/Count_buffer_wr\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_addr_bk\ : std_logic_vector(1 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_addr_row\ : std_logic_vector(10 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_addr_col\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Addr_row_reg\ : std_logic_vector(10 downto 0);
  signal \sdrc_top_inst/U1/Addr_bank_reg\ : std_logic_vector(1 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_data_len\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Sdrc_data_len_i\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Sdrc_addr_i\ : std_logic_vector(20 downto 0);
  signal \sdrc_top_inst/U1/Column_remain_len_wrd\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Data_len_1_wrd\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Data_len_0_wrd\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U0/Ctrl_fsm_addr_col\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U2/Count_autorefresh\ : std_logic_vector(10 downto 0);
  signal \sdrc_top_inst/U0/Count_burst_num_wr\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U0/Count_burst_num_rd\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/Count_buffer_rd\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\ : std_logic_vector(2 downto 0);
  signal \sdrc_top_inst/U1/Count_data_len_0_wr\ : std_logic_vector(7 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_dqm\ : std_logic_vector(3 downto 0);
  signal \sdrc_top_inst/U1/ctrl_fsm_data0\ : std_logic_vector(31 downto 0);
  signal \sdrc_top_inst/U1/User_data_i_reg\ : std_logic_vector(31 downto 0);
  signal \sdrc_top_inst/U1/Dqm_data_i_reg\ : std_logic_vector(3 downto 0);
  signal NN : std_logic;
  signal NN_0 : std_logic;
  signal NN_1 : std_logic;
  signal NN_2 : std_logic;
  signal NN_3 : std_logic;
  signal NN_4 : std_logic;
begin
IO_sdram_dq_0_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(0),
  IO => IO_sdram_dq(0),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(0),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_1_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(1),
  IO => IO_sdram_dq(1),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(1),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_2_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(2),
  IO => IO_sdram_dq(2),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(2),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_3_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(3),
  IO => IO_sdram_dq(3),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(3),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_4_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(4),
  IO => IO_sdram_dq(4),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(4),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_5_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(5),
  IO => IO_sdram_dq(5),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(5),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_6_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(6),
  IO => IO_sdram_dq(6),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(6),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_7_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(7),
  IO => IO_sdram_dq(7),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(7),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_8_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(8),
  IO => IO_sdram_dq(8),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(8),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_9_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(9),
  IO => IO_sdram_dq(9),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(9),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_10_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(10),
  IO => IO_sdram_dq(10),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(10),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_11_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(11),
  IO => IO_sdram_dq(11),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(11),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_12_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(12),
  IO => IO_sdram_dq(12),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(12),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_13_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(13),
  IO => IO_sdram_dq(13),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(13),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_14_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(14),
  IO => IO_sdram_dq(14),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(14),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_15_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(15),
  IO => IO_sdram_dq(15),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(15),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_16_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(16),
  IO => IO_sdram_dq(16),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(16),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_17_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(17),
  IO => IO_sdram_dq(17),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(17),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_18_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(18),
  IO => IO_sdram_dq(18),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(18),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_19_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(19),
  IO => IO_sdram_dq(19),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(19),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_20_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(20),
  IO => IO_sdram_dq(20),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(20),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_21_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(21),
  IO => IO_sdram_dq(21),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(21),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_22_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(22),
  IO => IO_sdram_dq(22),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(22),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_23_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(23),
  IO => IO_sdram_dq(23),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(23),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_24_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(24),
  IO => IO_sdram_dq(24),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(24),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_25_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(25),
  IO => IO_sdram_dq(25),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(25),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_26_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(26),
  IO => IO_sdram_dq(26),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(26),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_27_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(27),
  IO => IO_sdram_dq(27),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(27),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_28_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(28),
  IO => IO_sdram_dq(28),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(28),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_29_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(29),
  IO => IO_sdram_dq(29),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(29),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_30_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(30),
  IO => IO_sdram_dq(30),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(30),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
IO_sdram_dq_31_iobuf: IOBUF
port map (
  O => IO_sdram_dq_in(31),
  IO => IO_sdram_dq(31),
  I => \sdrc_top_inst/U0/Ctrl_fsm_data\(31),
  OEN => sdrc_top_inst_U0_IO_sdram_dq_0);
\sdrc_top_inst/U0/Count_init_delay_2_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_init_delay\(2),
  D => sdrc_top_inst_U0_n8,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_init_count);
\sdrc_top_inst/U0/Count_init_delay_1_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_init_delay\(1),
  D => sdrc_top_inst_U0_n9,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_init_count);
\sdrc_top_inst/U0/Count_init_delay_0_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_init_delay\(0),
  D => sdrc_top_inst_U0_n10,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_init_count);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_PRECHARGEALL_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\,
  D => sdrc_top_inst_U0_n95,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_PRECHARGE_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\,
  D => sdrc_top_inst_U0_n97,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_AUTOREFRESH1_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\,
  D => sdrc_top_inst_U0_n99,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\,
  D => sdrc_top_inst_U0_n101,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_AUTOREFRESH2_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\,
  D => sdrc_top_inst_U0_n103,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  D => sdrc_top_inst_U0_n105,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_LOAD_MODEREG_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG\,
  D => sdrc_top_inst_U0_n107,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\,
  D => sdrc_top_inst_U0_n109,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_INIT_DONE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\,
  D => sdrc_top_inst_U0_n111,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Flag_init_done_s0\: DFFC
port map (
  Q => sdrc_top_inst_U0_ctrl_fsm_init,
  D => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_cmd_delay_3_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_cmd_delay\(3),
  D => sdrc_top_inst_U0_n153,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_cmd_count);
\sdrc_top_inst/U0/Count_cmd_delay_2_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_cmd_delay\(2),
  D => sdrc_top_inst_U0_n154,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_cmd_count);
\sdrc_top_inst/U0/Count_cmd_delay_1_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_cmd_delay\(1),
  D => sdrc_top_inst_U0_n155,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_cmd_count);
\sdrc_top_inst/U0/Count_cmd_delay_0_s0\: DFFS
port map (
  Q => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  D => sdrc_top_inst_U0_n156,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_Reset_cmd_count);
\sdrc_top_inst/U0/Ctrl_fsm_data_31_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(31),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(31),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_30_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(30),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(30),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_29_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(29),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(29),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_28_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(28),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(28),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_27_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(27),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(27),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_26_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(26),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(26),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_25_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(25),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(25),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_24_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(24),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(24),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_23_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(23),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(23),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_22_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(22),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(22),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_21_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(21),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(21),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_20_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(20),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(20),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_19_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(19),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(19),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_18_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(18),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(18),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_17_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(17),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(17),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_16_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(16),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(16),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_15_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(15),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(15),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_14_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(14),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(14),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_13_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(13),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(13),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_12_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(12),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(12),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_11_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(11),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(11),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_10_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(10),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(10),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_9_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(9),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(9),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_8_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(8),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(8),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_7_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(7),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(7),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_6_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(6),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(6),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_5_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(5),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(5),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_4_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(4),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(4),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_3_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(3),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(3),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_2_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(2),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(2),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_1_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(1),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(1),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_data_0_s0\: DFF
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_data\(0),
  D => \sdrc_top_inst/U1/ctrl_fsm_data0\(0),
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Ctrl_fsm_addr_bk_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_bk\(1),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(1),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_bk_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_bk\(0),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(0),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_10_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(10),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(10),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_9_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(9),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(9),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_8_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(8),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(8),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(7),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(7),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(6),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(6),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(5),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(5),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(4),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(4),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(3),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(3),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(2),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(2),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(1),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(1),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_addr_row_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(0),
  D => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(0),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(7),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(7),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(6),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(6),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(5),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(5),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(4),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(4),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(3),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(3),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(2),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(2),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(1),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(1),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/Ctrl_fsm_burst_num_i_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(0),
  D => \sdrc_top_inst/U1/ctrl_fsm_data_len\(0),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/I_selfrefresh_reg_s0\: DFF
port map (
  Q => sdrc_top_inst_U0_I_selfrefresh_reg,
  D => I_sdrc_selfrefresh,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\,
  D => sdrc_top_inst_U0_n593_26,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_IDLE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  D => sdrc_top_inst_U0_n596,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  D => sdrc_top_inst_U0_n598,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\,
  D => sdrc_top_inst_U0_n600,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_ACTIVE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  D => sdrc_top_inst_U0_n602,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\,
  D => sdrc_top_inst_U0_n604,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  D => sdrc_top_inst_U0_n606,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  D => sdrc_top_inst_U0_n608,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE\,
  D => sdrc_top_inst_U0_n610,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_PRECHARGE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  D => sdrc_top_inst_U0_n612,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_INIT_s0\: DFFP
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\,
  D => sdrc_top_inst_U0_n614,
  CLK => I_sdrc_clk,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_POWER_DOWN_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\,
  D => sdrc_top_inst_U0_n616,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_SELFREFRESH_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\,
  D => sdrc_top_inst_U0_n618,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\,
  D => sdrc_top_inst_U0_n620,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\,
  D => sdrc_top_inst_U0_n622,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT\,
  D => sdrc_top_inst_U0_n624,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Flag_sdrc_wrd_s0\: DFFCE
port map (
  Q => sdrc_top_inst_U0_Flag_sdrc_wrd,
  D => sdrc_top_inst_U0_n341,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Flag_sdrc_wrd_13,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_ctrl_fsm_busy_n_s0\: DFFC
port map (
  Q => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  D => sdrc_top_inst_U0_n705_8,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_ctrl_fsm_data_31_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(31),
  D => IO_sdram_dq_in(31),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_30_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(30),
  D => IO_sdram_dq_in(30),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_29_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(29),
  D => IO_sdram_dq_in(29),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_28_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(28),
  D => IO_sdram_dq_in(28),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_27_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(27),
  D => IO_sdram_dq_in(27),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_26_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(26),
  D => IO_sdram_dq_in(26),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_25_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(25),
  D => IO_sdram_dq_in(25),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_24_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(24),
  D => IO_sdram_dq_in(24),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_23_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(23),
  D => IO_sdram_dq_in(23),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_22_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(22),
  D => IO_sdram_dq_in(22),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_21_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(21),
  D => IO_sdram_dq_in(21),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_20_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(20),
  D => IO_sdram_dq_in(20),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_19_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(19),
  D => IO_sdram_dq_in(19),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_18_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(18),
  D => IO_sdram_dq_in(18),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_17_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(17),
  D => IO_sdram_dq_in(17),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_16_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(16),
  D => IO_sdram_dq_in(16),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_15_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(15),
  D => IO_sdram_dq_in(15),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_14_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(14),
  D => IO_sdram_dq_in(14),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_13_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(13),
  D => IO_sdram_dq_in(13),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_12_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(12),
  D => IO_sdram_dq_in(12),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_11_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(11),
  D => IO_sdram_dq_in(11),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_10_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(10),
  D => IO_sdram_dq_in(10),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_9_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(9),
  D => IO_sdram_dq_in(9),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_8_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(8),
  D => IO_sdram_dq_in(8),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_7_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(7),
  D => IO_sdram_dq_in(7),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_6_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(6),
  D => IO_sdram_dq_in(6),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_5_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(5),
  D => IO_sdram_dq_in(5),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_4_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(4),
  D => IO_sdram_dq_in(4),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_3_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(3),
  D => IO_sdram_dq_in(3),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_2_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(2),
  D => IO_sdram_dq_in(2),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_1_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(1),
  D => IO_sdram_dq_in(1),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/O_ctrl_fsm_data_0_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/ctrl_fsm_data1\(0),
  D => IO_sdram_dq_in(0),
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/Ctrl_rd_data_valid_s0\: DFFC
port map (
  Q => sdrc_top_inst_U0_ctrl_fsm_data_valid,
  D => \sdrc_top_inst/U0/Rd_data_valid_reg\(3),
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Rd_data_valid_reg_3_s0\: DFFC
port map (
  Q => \sdrc_top_inst/U0/Rd_data_valid_reg\(3),
  D => \sdrc_top_inst/U0/Rd_data_valid_reg\(2),
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Rd_data_valid_reg_2_s0\: DFFC
port map (
  Q => \sdrc_top_inst/U0/Rd_data_valid_reg\(2),
  D => \sdrc_top_inst/U0/Rd_data_valid_reg\(1),
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Rd_data_valid_reg_1_s0\: DFFC
port map (
  Q => \sdrc_top_inst/U0/Rd_data_valid_reg\(1),
  D => \sdrc_top_inst/U0/Rd_data_valid_reg\(0),
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Rd_data_valid_reg_0_s0\: DFFC
port map (
  Q => \sdrc_top_inst/U0/Rd_data_valid_reg\(0),
  D => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_sdram_wen_n_s0\: DFF
port map (
  Q => O_sdram_wen_n,
  D => sdrc_top_inst_U0_n955,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/O_sdram_cke_s0\: DFFS
port map (
  Q => O_sdram_cke,
  D => sdrc_top_inst_U0_n962,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n962_8);
\sdrc_top_inst/U0/O_sdram_addr_10_s0\: DFF
port map (
  Q => O_sdram_addr(10),
  D => sdrc_top_inst_U0_n968,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/O_sdram_addr_9_s0\: DFF
port map (
  Q => O_sdram_addr(9),
  D => sdrc_top_inst_U0_n970,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/O_sdram_addr_8_s0\: DFF
port map (
  Q => O_sdram_addr(8),
  D => sdrc_top_inst_U0_n972,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/O_sdram_addr_5_s0\: DFFS
port map (
  Q => O_sdram_addr(5),
  D => sdrc_top_inst_U0_n927,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n962_8);
\sdrc_top_inst/U0/O_sdram_addr_4_s0\: DFFS
port map (
  Q => O_sdram_addr(4),
  D => sdrc_top_inst_U0_n930,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n962_8);
\sdrc_top_inst/U0/Count_init_delay_3_s0\: DFFR
port map (
  Q => \sdrc_top_inst/U0/Count_init_delay\(3),
  D => sdrc_top_inst_U0_n7,
  CLK => I_sdrc_clk,
  RESET => sdrc_top_inst_U0_Reset_init_count);
\sdrc_top_inst/U0/Cmd_init_state.INIT_STATE_IDLE_s0\: DFFP
port map (
  Q => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_IDLE\,
  D => sdrc_top_inst_U0_n93,
  CLK => I_sdrc_clk,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_wr_3_s0\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_wr\(3),
  D => sdrc_top_inst_U1_n11,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_wr_2_s0\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_wr\(2),
  D => sdrc_top_inst_U1_n12,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_wr_1_s0\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_wr\(1),
  D => sdrc_top_inst_U1_n13,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_wr_0_s0\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_wr\(0),
  D => sdrc_top_inst_U1_n14,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_ctrl_double_wrd_flag_s0\: DFFCE
port map (
  Q => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  D => sdrc_top_inst_U1_n1594,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_IDLE_s0\: DFFC
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  D => sdrc_top_inst_U1_n547,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_bk_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(1),
  D => sdrc_top_inst_U1_n570,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_bk_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(0),
  D => sdrc_top_inst_U1_n572,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_10_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(10),
  D => sdrc_top_inst_U1_n574,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_9_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(9),
  D => sdrc_top_inst_U1_n576,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_8_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(8),
  D => sdrc_top_inst_U1_n578,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(7),
  D => sdrc_top_inst_U1_n580,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(6),
  D => sdrc_top_inst_U1_n582,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(5),
  D => sdrc_top_inst_U1_n584,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(4),
  D => sdrc_top_inst_U1_n586,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(3),
  D => sdrc_top_inst_U1_n588,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(2),
  D => sdrc_top_inst_U1_n590,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(1),
  D => sdrc_top_inst_U1_n592,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_row_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(0),
  D => sdrc_top_inst_U1_n594,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(7),
  D => sdrc_top_inst_U1_n596,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7_9);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(6),
  D => sdrc_top_inst_U1_n598,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_6);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(5),
  D => sdrc_top_inst_U1_n600,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_5);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(4),
  D => sdrc_top_inst_U1_n602,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_4);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(3),
  D => sdrc_top_inst_U1_n604,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_3);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(2),
  D => sdrc_top_inst_U1_n606,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_2);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(1),
  D => sdrc_top_inst_U1_n608,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(0),
  D => sdrc_top_inst_U1_n610,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_0);
\sdrc_top_inst/U1/Addr_row_reg_10_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(10),
  D => sdrc_top_inst_U1_n119,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_9_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(9),
  D => sdrc_top_inst_U1_n120,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_8_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(8),
  D => sdrc_top_inst_U1_n121,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(7),
  D => sdrc_top_inst_U1_n122,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(6),
  D => sdrc_top_inst_U1_n123,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(5),
  D => sdrc_top_inst_U1_n124,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(4),
  D => sdrc_top_inst_U1_n125,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(3),
  D => sdrc_top_inst_U1_n126,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(2),
  D => sdrc_top_inst_U1_n127,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_row_reg_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(1),
  D => sdrc_top_inst_U1_n128,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_bank_reg_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_bank_reg\(1),
  D => sdrc_top_inst_U1_n117,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/Addr_bank_reg_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Addr_bank_reg\(0),
  D => sdrc_top_inst_U1_n118,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1692);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(7),
  D => sdrc_top_inst_U1_n625,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(6),
  D => sdrc_top_inst_U1_n627,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(5),
  D => sdrc_top_inst_U1_n629,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(4),
  D => sdrc_top_inst_U1_n631,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(3),
  D => sdrc_top_inst_U1_n633,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(2),
  D => sdrc_top_inst_U1_n635,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(1),
  D => sdrc_top_inst_U1_n637,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_burst_num_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/ctrl_fsm_data_len\(0),
  D => sdrc_top_inst_U1_n639,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_sdrc_rd_flag_s0\: DFFC
port map (
  Q => O_sdrc_rd_valid,
  D => sdrc_top_inst_U0_ctrl_fsm_data_valid,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Double_wrd_flag_s0\: DFFC
port map (
  Q => sdrc_top_inst_U1_Double_wrd_flag,
  D => sdrc_top_inst_U1_n982,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Sdrc_wr_n_i_s0\: DFFP
port map (
  Q => sdrc_top_inst_U1_Sdrc_wr_n_i,
  D => I_sdrc_wr_n,
  CLK => I_sdrc_clk,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Sdrc_rd_n_i_s0\: DFFP
port map (
  Q => sdrc_top_inst_U1_Sdrc_rd_n_i,
  D => I_sdrc_rd_n,
  CLK => I_sdrc_clk,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_user_data_31_s0\: DFFE
port map (
  Q => O_sdrc_data(31),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(31),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_30_s0\: DFFE
port map (
  Q => O_sdrc_data(30),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(30),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_29_s0\: DFFE
port map (
  Q => O_sdrc_data(29),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(29),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_28_s0\: DFFE
port map (
  Q => O_sdrc_data(28),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(28),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_27_s0\: DFFE
port map (
  Q => O_sdrc_data(27),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(27),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_26_s0\: DFFE
port map (
  Q => O_sdrc_data(26),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(26),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_25_s0\: DFFE
port map (
  Q => O_sdrc_data(25),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(25),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_24_s0\: DFFE
port map (
  Q => O_sdrc_data(24),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(24),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_23_s0\: DFFE
port map (
  Q => O_sdrc_data(23),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(23),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_22_s0\: DFFE
port map (
  Q => O_sdrc_data(22),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(22),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_21_s0\: DFFE
port map (
  Q => O_sdrc_data(21),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(21),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_20_s0\: DFFE
port map (
  Q => O_sdrc_data(20),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(20),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_19_s0\: DFFE
port map (
  Q => O_sdrc_data(19),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(19),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_18_s0\: DFFE
port map (
  Q => O_sdrc_data(18),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(18),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_17_s0\: DFFE
port map (
  Q => O_sdrc_data(17),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(17),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_16_s0\: DFFE
port map (
  Q => O_sdrc_data(16),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(16),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_15_s0\: DFFE
port map (
  Q => O_sdrc_data(15),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(15),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_14_s0\: DFFE
port map (
  Q => O_sdrc_data(14),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(14),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_13_s0\: DFFE
port map (
  Q => O_sdrc_data(13),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(13),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_12_s0\: DFFE
port map (
  Q => O_sdrc_data(12),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(12),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_11_s0\: DFFE
port map (
  Q => O_sdrc_data(11),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(11),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_10_s0\: DFFE
port map (
  Q => O_sdrc_data(10),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(10),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_9_s0\: DFFE
port map (
  Q => O_sdrc_data(9),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(9),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_8_s0\: DFFE
port map (
  Q => O_sdrc_data(8),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(8),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_7_s0\: DFFE
port map (
  Q => O_sdrc_data(7),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(7),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_6_s0\: DFFE
port map (
  Q => O_sdrc_data(6),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(6),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_5_s0\: DFFE
port map (
  Q => O_sdrc_data(5),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(5),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_4_s0\: DFFE
port map (
  Q => O_sdrc_data(4),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(4),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_3_s0\: DFFE
port map (
  Q => O_sdrc_data(3),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(3),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_2_s0\: DFFE
port map (
  Q => O_sdrc_data(2),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(2),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_1_s0\: DFFE
port map (
  Q => O_sdrc_data(1),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(1),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_user_data_0_s0\: DFFE
port map (
  Q => O_sdrc_data(0),
  D => \sdrc_top_inst/U0/ctrl_fsm_data1\(0),
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/sdrc_init_done_done_s0\: DFFE
port map (
  Q => NN_4,
  D => sdrc_top_inst_U0_ctrl_fsm_init,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Sdrc_wr_n_i_reg_s0\: DFFE
port map (
  Q => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  D => sdrc_top_inst_U1_Sdrc_wr_n_i,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Sdrc_rd_n_i_reg_s0\: DFFE
port map (
  Q => sdrc_top_inst_U1_Sdrc_rd_n_i_reg,
  D => sdrc_top_inst_U1_Sdrc_rd_n_i,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Sdrc_data_len_i_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(7),
  D => I_sdrc_data_len(7),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(6),
  D => I_sdrc_data_len(6),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(5),
  D => I_sdrc_data_len(5),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(4),
  D => I_sdrc_data_len(4),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(3),
  D => I_sdrc_data_len(3),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(2),
  D => I_sdrc_data_len(2),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(1),
  D => I_sdrc_data_len(1),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_data_len_i_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_data_len_i\(0),
  D => I_sdrc_data_len(0),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_20_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(20),
  D => I_sdrc_addr(20),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_19_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(19),
  D => I_sdrc_addr(19),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_18_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(18),
  D => I_sdrc_addr(18),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_17_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(17),
  D => I_sdrc_addr(17),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_16_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(16),
  D => I_sdrc_addr(16),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_15_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(15),
  D => I_sdrc_addr(15),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_14_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(14),
  D => I_sdrc_addr(14),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_13_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(13),
  D => I_sdrc_addr(13),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_12_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(12),
  D => I_sdrc_addr(12),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_11_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(11),
  D => I_sdrc_addr(11),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_10_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(10),
  D => I_sdrc_addr(10),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_9_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(9),
  D => I_sdrc_addr(9),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_8_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(8),
  D => I_sdrc_addr(8),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(7),
  D => I_sdrc_addr(7),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(6),
  D => I_sdrc_addr(6),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(5),
  D => I_sdrc_addr(5),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(4),
  D => I_sdrc_addr(4),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(3),
  D => I_sdrc_addr(3),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(2),
  D => I_sdrc_addr(2),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(1),
  D => I_sdrc_addr(1),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Sdrc_addr_i_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Sdrc_addr_i\(0),
  D => I_sdrc_addr(0),
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(7),
  D => sdrc_top_inst_U1_n1276,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(6),
  D => sdrc_top_inst_U1_n1277,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(5),
  D => sdrc_top_inst_U1_n1278,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(4),
  D => sdrc_top_inst_U1_n1279,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(3),
  D => sdrc_top_inst_U1_n1280,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(2),
  D => sdrc_top_inst_U1_n1281,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(1),
  D => sdrc_top_inst_U1_n1282,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Column_remain_len_wrd_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Column_remain_len_wrd\(0),
  D => sdrc_top_inst_U1_n1283,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n1714);
\sdrc_top_inst/U1/Data_len_1_wrd_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(7),
  D => sdrc_top_inst_U1_n974,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(6),
  D => sdrc_top_inst_U1_n975,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(5),
  D => sdrc_top_inst_U1_n976,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(4),
  D => sdrc_top_inst_U1_n977,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(3),
  D => sdrc_top_inst_U1_n978,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(2),
  D => sdrc_top_inst_U1_n979,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(1),
  D => sdrc_top_inst_U1_n980,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_1_wrd_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_1_wrd\(0),
  D => sdrc_top_inst_U1_n981,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_7_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(7),
  D => sdrc_top_inst_U1_n983,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_6_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(6),
  D => sdrc_top_inst_U1_n984,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_5_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(5),
  D => sdrc_top_inst_U1_n985,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_4_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(4),
  D => sdrc_top_inst_U1_n986,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_3_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(3),
  D => sdrc_top_inst_U1_n987,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_2_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(2),
  D => sdrc_top_inst_U1_n988,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_1_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(1),
  D => sdrc_top_inst_U1_n989,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/Data_len_0_wrd_0_s0\: DFFE
port map (
  Q => \sdrc_top_inst/U1/Data_len_0_wrd\(0),
  D => sdrc_top_inst_U1_n990,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/O_sdrc_busy_n_s0\: DFFC
port map (
  Q => O_sdrc_busy_n,
  D => sdrc_top_inst_U1_n9,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/O_autorefresh_req_s0\: DFFCE
port map (
  Q => sdrc_top_inst_U2_autorefresh_req,
  D => sdrc_top_inst_U2_n55,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U2_O_autorefresh_req,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/O_autorefresh_req_a_s0\: DFFC
port map (
  Q => sdrc_top_inst_U2_autorefresh_req_a,
  D => sdrc_top_inst_U2_n73,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_ctrl_fsm_wrd_done_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  D => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_7_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(7),
  D => sdrc_top_inst_U0_n272_6,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_6_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(6),
  D => sdrc_top_inst_U0_n273,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_5_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(5),
  D => sdrc_top_inst_U0_n274,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_4_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(4),
  D => sdrc_top_inst_U0_n275,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_3_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(3),
  D => sdrc_top_inst_U0_n276_8,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_2_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(2),
  D => sdrc_top_inst_U0_n277,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_1_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1),
  D => sdrc_top_inst_U0_n278,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_0_s1\: DFFE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  D => sdrc_top_inst_U0_n279,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7);
\sdrc_top_inst/U0/Ctrl_wr_data_valid_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_Ctrl_wr_data_valid,
  D => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_6_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(6),
  D => sdrc_top_inst_U2_n48,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U2_Count_autorefresh_11_21,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_5_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(5),
  D => sdrc_top_inst_U2_n49,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U2_Count_autorefresh_11_21,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(2),
  D => sdrc_top_inst_U2_n52,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U2_Count_autorefresh_11_21,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Reset_autorefresh_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_Reset_autorefresh,
  D => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n661,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_7_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(7),
  D => sdrc_top_inst_U0_n626,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n626_19,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(2),
  D => sdrc_top_inst_U0_n636,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n626_19,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_7_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(7),
  D => sdrc_top_inst_U0_n642,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n642_19,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(2),
  D => sdrc_top_inst_U0_n652,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_n642_19,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_autorefresh_ack_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_autorefresh_ack,
  D => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U0_O_autorefresh_ack,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_sdrc_wrd_ack_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => O_sdrc_wrd_ack,
  D => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_O_sdrc_wrd_ack,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_rd_3_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_rd\(3),
  D => sdrc_top_inst_U1_n95_22,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n95,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_rd_2_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_rd\(2),
  D => sdrc_top_inst_U1_n96,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n95,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_rd_1_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  D => sdrc_top_inst_U1_n97,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n95,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_buffer_rd_0_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  D => sdrc_top_inst_U1_n98,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n95,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  D => sdrc_top_inst_U1_n562,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n562_22,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY_1_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  D => sdrc_top_inst_U1_n565,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n562_22,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY_0_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0),
  D => sdrc_top_inst_U1_n568,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n562_22,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_ctrl_fsm_rd_n_s4\: DFFPE
generic map (
  INIT => '1'
)
port map (
  Q => sdrc_top_inst_U1_ctrl_fsm_rd_n,
  D => sdrc_top_inst_U1_n645_15,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n645,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/O_ctrl_fsm_wr_n_s4\: DFFPE
generic map (
  INIT => '1'
)
port map (
  Q => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  D => sdrc_top_inst_U1_n642_19,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n642_21,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_busy_flag_n_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U1_User_busy_flag_n,
  D => sdrc_top_inst_U1_n559,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n559_24,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_7_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  D => sdrc_top_inst_U1_n648,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_6_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(6),
  D => sdrc_top_inst_U1_n651,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_5_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  D => sdrc_top_inst_U1_n654,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_4_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(4),
  D => sdrc_top_inst_U1_n657,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_3_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  D => sdrc_top_inst_U1_n660,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_2_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(2),
  D => sdrc_top_inst_U1_n663,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_1_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  D => sdrc_top_inst_U1_n666,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/Count_data_len_0_wr_0_s4\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Count_data_len_0_wr\(0),
  D => sdrc_top_inst_U1_n669,
  CLK => I_sdrc_clk,
  CE => sdrc_top_inst_U1_n648_26,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_READ_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  D => sdrc_top_inst_U1_n548,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_WRITE_WAIT_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  D => sdrc_top_inst_U1_n549,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_WRITE_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  D => sdrc_top_inst_U1_n550_31,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_WRITE_2_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  D => sdrc_top_inst_U1_n551,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_READ_WAIT_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  D => sdrc_top_inst_U1_n553,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_READ_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_READ_2\,
  D => sdrc_top_inst_U1_n554_32,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_READ_2_WAIT_s2\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_READ_2_WAIT\,
  D => sdrc_top_inst_U1_n555,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_WRITE_2_WAIT_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\,
  D => sdrc_top_inst_U1_n556,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/User_model_state.STATE_WAITING_s4\: DFFPE
generic map (
  INIT => '1'
)
port map (
  Q => \sdrc_top_inst_U1_User_model_state.STATE_WAITING\,
  D => NN,
  CLK => I_sdrc_clk,
  CE => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  PRESET => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/n245_s16\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245,
  COUT => sdrc_top_inst_U1_n245_20,
  I0 => VCC_0,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0),
  I3 => NN,
  CIN => \sdrc_top_inst/U1/Data_len_0_wrd\(0));
\sdrc_top_inst/U1/n245_s17\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_21,
  COUT => sdrc_top_inst_U1_n245_22,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(1),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_20);
\sdrc_top_inst/U1/n245_s18\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_23,
  COUT => sdrc_top_inst_U1_n245_24,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(2),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(2),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_22);
\sdrc_top_inst/U1/n245_s19\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_25,
  COUT => sdrc_top_inst_U1_n245_26,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(3),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_24);
\sdrc_top_inst/U1/n245_s20\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_27,
  COUT => sdrc_top_inst_U1_n245_28,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(4),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(4),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_26);
\sdrc_top_inst/U1/n245_s21\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_29,
  COUT => sdrc_top_inst_U1_n245_30,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(5),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_28);
\sdrc_top_inst/U1/n245_s22\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n245_31,
  COUT => sdrc_top_inst_U1_n245_32,
  I0 => \sdrc_top_inst/U1/Data_len_0_wrd\(6),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(6),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n245_30);
\sdrc_top_inst/U1/n435_s16\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435,
  COUT => sdrc_top_inst_U1_n435_20,
  I0 => VCC_0,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0),
  I3 => NN,
  CIN => \sdrc_top_inst/U1/Data_len_1_wrd\(0));
\sdrc_top_inst/U1/n435_s17\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_21,
  COUT => sdrc_top_inst_U1_n435_22,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(1),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_20);
\sdrc_top_inst/U1/n435_s18\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_23,
  COUT => sdrc_top_inst_U1_n435_24,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(2),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(2),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_22);
\sdrc_top_inst/U1/n435_s19\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_25,
  COUT => sdrc_top_inst_U1_n435_26,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(3),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_24);
\sdrc_top_inst/U1/n435_s20\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_27,
  COUT => sdrc_top_inst_U1_n435_28,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(4),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(4),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_26);
\sdrc_top_inst/U1/n435_s21\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_29,
  COUT => sdrc_top_inst_U1_n435_30,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(5),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_28);
\sdrc_top_inst/U1/n435_s22\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => sdrc_top_inst_U1_n435_31,
  COUT => sdrc_top_inst_U1_n435_32,
  I0 => \sdrc_top_inst/U1/Data_len_1_wrd\(6),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(6),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n435_30);
\sdrc_top_inst/U1/Buffer_data_in_Buffer_data_in_0_0_s\: SDPX9B
generic map (
  BIT_WIDTH_0 => 36,
  BIT_WIDTH_1 => 36,
  READ_MODE => '0',
  RESET_MODE => "SYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(35 downto 32) => \sdrc_top_inst/U1/ctrl_fsm_dqm\(3 downto 0),
  DO(31 downto 0) => \sdrc_top_inst/U1/ctrl_fsm_data0\(31 downto 0),
  DI(35 downto 32) => \sdrc_top_inst/U1/Dqm_data_i_reg\(3 downto 0),
  DI(31 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(31 downto 0),
  BLKSELA(2) => NN,
  BLKSELA(1) => NN,
  BLKSELA(0) => NN,
  BLKSELB(2) => NN,
  BLKSELB(1) => NN,
  BLKSELB(0) => NN,
  ADA(13) => NN,
  ADA(12) => NN,
  ADA(11) => NN,
  ADA(10) => NN,
  ADA(9) => NN,
  ADA(8 downto 5) => \sdrc_top_inst/U1/Count_buffer_wr\(3 downto 0),
  ADA(4) => NN,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13) => NN,
  ADB(12) => NN,
  ADB(11) => NN,
  ADB(10) => NN,
  ADB(9) => NN,
  ADB(8 downto 5) => \sdrc_top_inst/U1/Count_buffer_rd\(3 downto 0),
  ADB(4) => NN,
  ADB(3) => NN,
  ADB(2) => NN,
  ADB(1) => NN,
  ADB(0) => NN,
  CLKA => I_sdrc_clk,
  CLKB => I_sdrc_clk,
  CEA => I_sdrc_rst_n,
  CEB => sdrc_top_inst_U1_O_ctrl_fsm_data_31,
  OCE => NN,
  RESETA => NN,
  RESETB => NN);
\sdrc_top_inst/U1/User_data_i_0_s2\: DFFE
port map (
  Q => sdrc_top_inst_U1_User_data_i_0,
  D => sdrc_top_inst_U1_User_data_i_0_24,
  CLK => I_sdrc_clk,
  CE => I_sdrc_rst_n);
\sdrc_top_inst/U1/User_data_i_0_s4\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(3 downto 0),
  DI(3 downto 0) => I_sdrc_data(3 downto 0),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s6\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(7 downto 4),
  DI(3 downto 0) => I_sdrc_data(7 downto 4),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s8\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(11 downto 8),
  DI(3 downto 0) => I_sdrc_data(11 downto 8),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s10\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(15 downto 12),
  DI(3 downto 0) => I_sdrc_data(15 downto 12),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s12\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(19 downto 16),
  DI(3 downto 0) => I_sdrc_data(19 downto 16),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s14\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(23 downto 20),
  DI(3 downto 0) => I_sdrc_data(23 downto 20),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s16\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(27 downto 24),
  DI(3 downto 0) => I_sdrc_data(27 downto 24),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/User_data_i_0_s18\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/User_data_i_reg\(31 downto 28),
  DI(3 downto 0) => I_sdrc_data(31 downto 28),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/Dqm_data_i_0_s4\: RAM16S4
port map (
  DO(3 downto 0) => \sdrc_top_inst/U1/Dqm_data_i_reg\(3 downto 0),
  DI(3 downto 0) => I_sdrc_dqm(3 downto 0),
  AD(3) => NN,
  AD(2) => NN,
  AD(1) => NN,
  AD(0) => sdrc_top_inst_U1_User_data_i_0,
  WRE => I_sdrc_rst_n,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U1/n128_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n128,
  COUT => sdrc_top_inst_U1_n128_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(9),
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(8),
  I3 => NN,
  CIN => NN);
\sdrc_top_inst/U1/n127_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n127,
  COUT => sdrc_top_inst_U1_n127_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(10),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n128_2);
\sdrc_top_inst/U1/n126_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n126,
  COUT => sdrc_top_inst_U1_n126_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(11),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n127_2);
\sdrc_top_inst/U1/n125_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n125,
  COUT => sdrc_top_inst_U1_n125_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(12),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n126_2);
\sdrc_top_inst/U1/n124_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n124,
  COUT => sdrc_top_inst_U1_n124_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(13),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n125_2);
\sdrc_top_inst/U1/n123_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n123,
  COUT => sdrc_top_inst_U1_n123_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(14),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n124_2);
\sdrc_top_inst/U1/n122_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n122,
  COUT => sdrc_top_inst_U1_n122_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(15),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n123_2);
\sdrc_top_inst/U1/n121_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n121,
  COUT => sdrc_top_inst_U1_n121_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(16),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n122_2);
\sdrc_top_inst/U1/n120_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n120,
  COUT => sdrc_top_inst_U1_n120_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(17),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n121_2);
\sdrc_top_inst/U1/n119_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n119,
  COUT => sdrc_top_inst_U1_n119_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(18),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n120_2);
\sdrc_top_inst/U1/n118_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n118,
  COUT => sdrc_top_inst_U1_n118_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(19),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n119_2);
\sdrc_top_inst/U1/n117_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n117,
  COUT => sdrc_top_inst_U1_n117_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(20),
  I1 => NN,
  I3 => NN,
  CIN => sdrc_top_inst_U1_n118_2);
\sdrc_top_inst/U1/n981_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n981,
  COUT => sdrc_top_inst_U1_n981_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(0),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(0),
  I3 => NN,
  CIN => NN);
\sdrc_top_inst/U1/n980_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n980,
  COUT => sdrc_top_inst_U1_n980_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(1),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(1),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n981_2);
\sdrc_top_inst/U1/n979_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n979,
  COUT => sdrc_top_inst_U1_n979_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(2),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(2),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n980_2);
\sdrc_top_inst/U1/n978_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n978,
  COUT => sdrc_top_inst_U1_n978_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(3),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(3),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n979_2);
\sdrc_top_inst/U1/n977_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n977,
  COUT => sdrc_top_inst_U1_n977_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(4),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(4),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n978_2);
\sdrc_top_inst/U1/n976_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n976,
  COUT => sdrc_top_inst_U1_n976_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(5),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(5),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n977_2);
\sdrc_top_inst/U1/n975_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n975,
  COUT => sdrc_top_inst_U1_n975_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(6),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(6),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n976_2);
\sdrc_top_inst/U1/n974_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => sdrc_top_inst_U1_n974,
  COUT => sdrc_top_inst_U1_n974_2,
  I0 => \sdrc_top_inst/U1/Sdrc_addr_i\(7),
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(7),
  I3 => NN,
  CIN => sdrc_top_inst_U1_n975_2);
\sdrc_top_inst/U0/O_sdram_cas_n_s1\: DFFS
port map (
  Q => O_sdram_cas_n,
  D => sdrc_top_inst_U0_n958_13,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n956);
\sdrc_top_inst/U0/O_sdram_ras_n_s1\: DFFS
port map (
  Q => O_sdram_ras_n,
  D => sdrc_top_inst_U0_n961,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n959_7);
\sdrc_top_inst/U0/O_sdram_ba_1_s1\: DFFS
port map (
  Q => O_sdram_ba(1),
  D => sdrc_top_inst_U0_n964,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_ba_0_s1\: DFFS
port map (
  Q => O_sdram_ba(0),
  D => sdrc_top_inst_U0_n966,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_7_s1\: DFFS
port map (
  Q => O_sdram_addr(7),
  D => sdrc_top_inst_U0_n974,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_6_s1\: DFFS
port map (
  Q => O_sdram_addr(6),
  D => sdrc_top_inst_U0_n976,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_3_s1\: DFFS
port map (
  Q => O_sdram_addr(3),
  D => sdrc_top_inst_U0_n980,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_2_s1\: DFFS
port map (
  Q => O_sdram_addr(2),
  D => sdrc_top_inst_U0_n982,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_1_s1\: DFFS
port map (
  Q => O_sdram_addr(1),
  D => sdrc_top_inst_U0_n984,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/O_sdram_addr_0_s1\: DFFS
port map (
  Q => O_sdram_addr(0),
  D => sdrc_top_inst_U0_n986,
  CLK => I_sdrc_clk,
  SET => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/n509_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n509,
  COUT => sdrc_top_inst_U0_n509_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(0),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(0),
  I3 => NN,
  CIN => NN);
\sdrc_top_inst/U0/n510_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n510,
  COUT => sdrc_top_inst_U0_n510_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(1),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n509_3);
\sdrc_top_inst/U0/n511_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n511,
  COUT => sdrc_top_inst_U0_n511_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(2),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(2),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n510_3);
\sdrc_top_inst/U0/n512_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n512,
  COUT => sdrc_top_inst_U0_n512_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(3),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(3),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n511_3);
\sdrc_top_inst/U0/n513_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n513,
  COUT => sdrc_top_inst_U0_n513_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(4),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(4),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n512_3);
\sdrc_top_inst/U0/n514_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n514,
  COUT => sdrc_top_inst_U0_n514_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(5),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(5),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n513_3);
\sdrc_top_inst/U0/n515_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n515,
  COUT => sdrc_top_inst_U0_n515_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(6),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(6),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n514_3);
\sdrc_top_inst/U0/n516_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n516,
  COUT => sdrc_top_inst_U0_n516_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(7),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(7),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n515_3);
\sdrc_top_inst/U0/n529_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n529,
  COUT => sdrc_top_inst_U0_n529_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(0),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(0),
  I3 => NN,
  CIN => NN);
\sdrc_top_inst/U0/n530_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n530,
  COUT => sdrc_top_inst_U0_n530_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(1),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n529_3);
\sdrc_top_inst/U0/n531_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n531,
  COUT => sdrc_top_inst_U0_n531_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(2),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(2),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n530_3);
\sdrc_top_inst/U0/n532_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n532,
  COUT => sdrc_top_inst_U0_n532_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(3),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(3),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n531_3);
\sdrc_top_inst/U0/n533_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n533,
  COUT => sdrc_top_inst_U0_n533_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(4),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(4),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n532_3);
\sdrc_top_inst/U0/n534_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n534,
  COUT => sdrc_top_inst_U0_n534_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(5),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(5),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n533_3);
\sdrc_top_inst/U0/n535_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n535,
  COUT => sdrc_top_inst_U0_n535_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(6),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(6),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n534_3);
\sdrc_top_inst/U0/n536_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => sdrc_top_inst_U0_n536,
  COUT => sdrc_top_inst_U0_n536_3,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(7),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_burst_num_i\(7),
  I3 => NN,
  CIN => sdrc_top_inst_U0_n535_3);
\sdrc_top_inst/U0/Reset_init_count_s1\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U0_Reset_init_count,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\,
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\);
\sdrc_top_inst/U0/n243_s0\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => sdrc_top_inst_U0_n243,
  I0 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I1 => sdrc_top_inst_U1_ctrl_fsm_rd_n);
\sdrc_top_inst/U0/Reset_cmd_count_s1\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U0_Reset_cmd_count,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\);
\sdrc_top_inst/U0/n273_s0\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => sdrc_top_inst_U0_n273,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(6),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(6),
  I2 => sdrc_top_inst_U0_n273_6,
  I3 => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/n274_s0\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => sdrc_top_inst_U0_n274,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(5),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(5),
  I2 => sdrc_top_inst_U0_n274_4,
  I3 => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/n275_s0\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => sdrc_top_inst_U0_n275,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(4),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(4),
  I2 => sdrc_top_inst_U0_n275_4,
  I3 => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/n277_s0\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => sdrc_top_inst_U0_n277,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(2),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(2),
  I2 => sdrc_top_inst_U0_n277_4,
  I3 => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/n278_s0\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => sdrc_top_inst_U0_n278,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(1),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1),
  I3 => sdrc_top_inst_U0_n243);
\sdrc_top_inst/U0/n956_s0\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U0_n956,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\,
  I1 => sdrc_top_inst_U0_n959_7);
\sdrc_top_inst/U1/n9_s1\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U1_n9,
  I0 => sdrc_top_inst_U2_autorefresh_req_a,
  I1 => sdrc_top_inst_U1_User_busy_flag_n);
\sdrc_top_inst/U1/n1594_s2\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => sdrc_top_inst_U1_n1594,
  I0 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I1 => sdrc_top_inst_U1_Sdrc_rd_n_i_reg);
\sdrc_top_inst/U1/n983_s0\: LUT2
generic map (
  INIT => X"2"
)
port map (
  F => sdrc_top_inst_U1_n983,
  I0 => \sdrc_top_inst/U1/Sdrc_data_len_i\(7),
  I1 => sdrc_top_inst_U1_n983_6);
\sdrc_top_inst/U1/n984_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n984,
  I0 => sdrc_top_inst_U1_n984_16,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(6),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n985_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n985,
  I0 => sdrc_top_inst_U1_n985_6,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(5),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n986_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n986,
  I0 => sdrc_top_inst_U1_n986_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(4),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n987_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n987,
  I0 => sdrc_top_inst_U1_n987_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(3),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n988_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n988,
  I0 => sdrc_top_inst_U1_n988_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(2),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n989_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n989,
  I0 => sdrc_top_inst_U1_n989_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(1),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U1/n990_s0\: LUT4
generic map (
  INIT => X"CCC5"
)
port map (
  F => sdrc_top_inst_U1_n990,
  I0 => sdrc_top_inst_U1_n990_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(0),
  I2 => sdrc_top_inst_U1_n984_5,
  I3 => sdrc_top_inst_U1_n984_6);
\sdrc_top_inst/U2/n73_s0\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U2_n73,
  I0 => sdrc_top_inst_U2_n73_11,
  I1 => sdrc_top_inst_U2_n73_5);
\sdrc_top_inst/U0/n962_s3\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => sdrc_top_inst_U0_n962,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\);
\sdrc_top_inst/U0/O_ctrl_fsm_wrd_done_s3\: LUT2
generic map (
  INIT => X"B"
)
port map (
  F => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done,
  I0 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\);
\sdrc_top_inst/U1/O_ctrl_fsm_data_31_s5\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_data_31,
  I0 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I1 => I_sdrc_rst_n);
\sdrc_top_inst/U0/n661_s5\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U0_n661,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\);
\sdrc_top_inst/U1/n95_s9\: LUT3
generic map (
  INIT => X"FE"
)
port map (
  F => sdrc_top_inst_U1_n95,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\);
\sdrc_top_inst/U1/n645_s9\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U1_n645,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2\);
\sdrc_top_inst/U1/User_model_state.STATE_READ_s3\: LUT4
generic map (
  INIT => X"0B00"
)
port map (
  F => \sdrc_top_inst_U1_User_model_state.STATE_WAITING_10\,
  I0 => NN_4,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WAITING\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_9\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_READ_10\);
\sdrc_top_inst/U0/n927_s4\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => sdrc_top_inst_U0_n927,
  I0 => sdrc_top_inst_U0_n927_9,
  I1 => sdrc_top_inst_U0_n927_10);
\sdrc_top_inst/U0/n930_s4\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => sdrc_top_inst_U0_n930,
  I0 => sdrc_top_inst_U0_n927_9,
  I1 => sdrc_top_inst_U0_n930_9);
\sdrc_top_inst/U0/n961_s5\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => sdrc_top_inst_U0_n961,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I2 => sdrc_top_inst_U0_n958);
\sdrc_top_inst/U0/n964_s5\: LUT4
generic map (
  INIT => X"F100"
)
port map (
  F => sdrc_top_inst_U0_n964,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_bk\(1),
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n966_s5\: LUT4
generic map (
  INIT => X"F100"
)
port map (
  F => sdrc_top_inst_U0_n966,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_bk\(0),
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n974_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n974,
  I0 => sdrc_top_inst_U0_n974_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n976_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n976,
  I0 => sdrc_top_inst_U0_n976_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n980_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n980,
  I0 => sdrc_top_inst_U0_n980_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n982_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n982,
  I0 => sdrc_top_inst_U0_n982_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n984_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n984,
  I0 => sdrc_top_inst_U0_n984_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n986_s5\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U0_n986,
  I0 => sdrc_top_inst_U0_n986_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n626_s6\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U0_n626,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(6),
  I1 => sdrc_top_inst_U0_n626_21,
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(7),
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/n636_s5\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U0_n636,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(0),
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(2),
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/n642_s6\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U0_n642,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(6),
  I1 => sdrc_top_inst_U0_n642_21,
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(7),
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/n652_s5\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U0_n652,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(0),
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(2),
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U1/n96_s9\: LUT4
generic map (
  INIT => X"FF01"
)
port map (
  F => sdrc_top_inst_U1_n96,
  I0 => sdrc_top_inst_U1_n96_18,
  I1 => sdrc_top_inst_U1_n648_18,
  I2 => sdrc_top_inst_U1_n96_15,
  I3 => sdrc_top_inst_U1_n96_16);
\sdrc_top_inst/U1/n97_s9\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U1_n97,
  I0 => sdrc_top_inst_U1_n97_14,
  I1 => sdrc_top_inst_U1_n97_15,
  I2 => sdrc_top_inst_U1_n97_16);
\sdrc_top_inst/U1/n98_s10\: LUT4
generic map (
  INIT => X"D755"
)
port map (
  F => sdrc_top_inst_U1_n98,
  I0 => sdrc_top_inst_U1_n98_15,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I2 => sdrc_top_inst_U1_n98_16,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\);
\sdrc_top_inst/U1/n645_s10\: LUT3
generic map (
  INIT => X"FE"
)
port map (
  F => sdrc_top_inst_U1_n645_15,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2\,
  I2 => sdrc_top_inst_U1_n645_16);
\sdrc_top_inst/U1/n570_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n570,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_bank_reg\(1),
  I2 => sdrc_top_inst_U1_n570_14);
\sdrc_top_inst/U1/n572_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n572,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_bank_reg\(0),
  I2 => sdrc_top_inst_U1_n572_13);
\sdrc_top_inst/U1/n574_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n574,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(10),
  I2 => sdrc_top_inst_U1_n574_13);
\sdrc_top_inst/U1/n576_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n576,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(9),
  I2 => sdrc_top_inst_U1_n576_13);
\sdrc_top_inst/U1/n578_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n578,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(8),
  I2 => sdrc_top_inst_U1_n578_13);
\sdrc_top_inst/U1/n580_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n580,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(7),
  I2 => sdrc_top_inst_U1_n580_13);
\sdrc_top_inst/U1/n582_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n582,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(6),
  I2 => sdrc_top_inst_U1_n582_13);
\sdrc_top_inst/U1/n584_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n584,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(5),
  I2 => sdrc_top_inst_U1_n584_13);
\sdrc_top_inst/U1/n586_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n586,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(4),
  I2 => sdrc_top_inst_U1_n586_13);
\sdrc_top_inst/U1/n588_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n588,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(3),
  I2 => sdrc_top_inst_U1_n588_13);
\sdrc_top_inst/U1/n590_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n590,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(2),
  I2 => sdrc_top_inst_U1_n590_13);
\sdrc_top_inst/U1/n592_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n592,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(1),
  I2 => sdrc_top_inst_U1_n592_13);
\sdrc_top_inst/U1/n594_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n594,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Addr_row_reg\(0),
  I2 => sdrc_top_inst_U1_n594_13);
\sdrc_top_inst/U1/n596_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n596,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(7));
\sdrc_top_inst/U1/n598_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n598,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(6));
\sdrc_top_inst/U1/n600_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n600,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(5));
\sdrc_top_inst/U1/n602_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n602,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(4));
\sdrc_top_inst/U1/n604_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n604,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(3));
\sdrc_top_inst/U1/n606_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n606,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(2));
\sdrc_top_inst/U1/n608_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n608,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(1));
\sdrc_top_inst/U1/n610_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n610,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(0));
\sdrc_top_inst/U1/n625_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n625,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(7),
  I2 => sdrc_top_inst_U1_n625_13);
\sdrc_top_inst/U1/n627_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n627,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(6),
  I2 => sdrc_top_inst_U1_n627_13);
\sdrc_top_inst/U1/n629_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n629,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(5),
  I2 => sdrc_top_inst_U1_n629_13);
\sdrc_top_inst/U1/n631_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n631,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(4),
  I2 => sdrc_top_inst_U1_n631_13);
\sdrc_top_inst/U1/n633_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n633,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(3),
  I2 => sdrc_top_inst_U1_n633_13);
\sdrc_top_inst/U1/n635_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n635,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(2),
  I2 => sdrc_top_inst_U1_n635_13);
\sdrc_top_inst/U1/n637_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n637,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(1),
  I2 => sdrc_top_inst_U1_n637_13);
\sdrc_top_inst/U1/n639_s8\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U1_n639,
  I0 => sdrc_top_inst_U1_n570_13,
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(0),
  I2 => sdrc_top_inst_U1_n639_13);
\sdrc_top_inst/U0/n95_s10\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n95,
  I0 => sdrc_top_inst_U0_n95_15,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_IDLE\);
\sdrc_top_inst/U0/n97_s10\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n97,
  I0 => sdrc_top_inst_U0_n97_17,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\);
\sdrc_top_inst/U0/n99_s10\: LUT4
generic map (
  INIT => X"FA30"
)
port map (
  F => sdrc_top_inst_U0_n99,
  I0 => sdrc_top_inst_U0_n99_15,
  I1 => sdrc_top_inst_U0_n95_15,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\,
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\);
\sdrc_top_inst/U0/n101_s10\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n101,
  I0 => sdrc_top_inst_U0_n101_17,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\);
\sdrc_top_inst/U0/n103_s10\: LUT4
generic map (
  INIT => X"8F88"
)
port map (
  F => sdrc_top_inst_U0_n103,
  I0 => sdrc_top_inst_U0_n103_15,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\,
  I2 => sdrc_top_inst_U0_n95_15,
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\);
\sdrc_top_inst/U0/n105_s10\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n105,
  I0 => sdrc_top_inst_U0_n101_17,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\);
\sdrc_top_inst/U0/n107_s10\: LUT4
generic map (
  INIT => X"8F88"
)
port map (
  F => sdrc_top_inst_U0_n107,
  I0 => sdrc_top_inst_U0_n103_15,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  I2 => sdrc_top_inst_U0_n95_15,
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG\);
\sdrc_top_inst/U0/n109_s10\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n109,
  I0 => sdrc_top_inst_U0_n97_17,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG\);
\sdrc_top_inst/U0/n111_s11\: LUT3
generic map (
  INIT => X"F8"
)
port map (
  F => sdrc_top_inst_U0_n111,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\,
  I1 => sdrc_top_inst_U0_n99_15,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n596_s19\: LUT4
generic map (
  INIT => X"F4FF"
)
port map (
  F => sdrc_top_inst_U0_n596,
  I0 => sdrc_top_inst_U0_n596_24,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n596_35,
  I3 => sdrc_top_inst_U0_n596_26);
\sdrc_top_inst/U0/n598_s19\: LUT4
generic map (
  INIT => X"F4FC"
)
port map (
  F => sdrc_top_inst_U0_n598,
  I0 => sdrc_top_inst_U0_n598_31,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  I2 => sdrc_top_inst_U0_n598_25,
  I3 => sdrc_top_inst_U0_n598_26);
\sdrc_top_inst/U0/n600_s18\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n600,
  I0 => sdrc_top_inst_U0_n600_25,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\);
\sdrc_top_inst/U0/n602_s18\: LUT4
generic map (
  INIT => X"FA30"
)
port map (
  F => sdrc_top_inst_U0_n602,
  I0 => sdrc_top_inst_U0_n243,
  I1 => sdrc_top_inst_U0_n598_31,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => sdrc_top_inst_U0_Flag_sdrc_wrd_8);
\sdrc_top_inst/U0/n606_s18\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n606,
  I0 => sdrc_top_inst_U0_n516_3,
  I1 => sdrc_top_inst_U0_n606_23,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I3 => sdrc_top_inst_U0_n606_24);
\sdrc_top_inst/U0/n608_s19\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n608,
  I0 => sdrc_top_inst_U0_n536_3,
  I1 => sdrc_top_inst_U0_n606_23,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I3 => sdrc_top_inst_U0_n608_24);
\sdrc_top_inst/U0/n610_s18\: LUT4
generic map (
  INIT => X"4F44"
)
port map (
  F => sdrc_top_inst_U0_n610,
  I0 => sdrc_top_inst_U0_n593,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE\,
  I2 => sdrc_top_inst_U0_n536_3,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/n612_s19\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => sdrc_top_inst_U0_n612,
  I0 => sdrc_top_inst_U0_n600_25,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  I2 => sdrc_top_inst_U0_n612_24);
\sdrc_top_inst/U0/n614_s17\: LUT4
generic map (
  INIT => X"BF00"
)
port map (
  F => sdrc_top_inst_U0_n614,
  I0 => sdrc_top_inst_U0_n596_35,
  I1 => sdrc_top_inst_U0_ctrl_fsm_init,
  I2 => sdrc_top_inst_U0_n596_24,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\);
\sdrc_top_inst/U0/n616_s18\: LUT4
generic map (
  INIT => X"F5C0"
)
port map (
  F => sdrc_top_inst_U0_n616,
  I0 => sdrc_top_inst_U0_n616_27,
  I1 => sdrc_top_inst_U0_n616_24,
  I2 => I_sdrc_power_down,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\);
\sdrc_top_inst/U0/n618_s19\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => sdrc_top_inst_U0_n618,
  I0 => sdrc_top_inst_U0_n598_31,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\,
  I2 => sdrc_top_inst_U0_n618_24);
\sdrc_top_inst/U0/n620_s18\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n620,
  I0 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I1 => sdrc_top_inst_U0_n620_25,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\);
\sdrc_top_inst/U0/n622_s17\: LUT4
generic map (
  INIT => X"F530"
)
port map (
  F => sdrc_top_inst_U0_n622,
  I0 => sdrc_top_inst_U0_n620_25,
  I1 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\);
\sdrc_top_inst/U0/n624_s17\: LUT4
generic map (
  INIT => X"F530"
)
port map (
  F => sdrc_top_inst_U0_n624,
  I0 => sdrc_top_inst_U0_n616_27,
  I1 => I_sdrc_power_down,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT\);
\sdrc_top_inst/U1/n547_s16\: LUT4
generic map (
  INIT => X"0EFF"
)
port map (
  F => sdrc_top_inst_U1_n547,
  I0 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I1 => sdrc_top_inst_U1_n547_21,
  I2 => sdrc_top_inst_U1_n547_26,
  I3 => sdrc_top_inst_U1_n547_23);
\sdrc_top_inst/U1/n548_s22\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => sdrc_top_inst_U1_n548,
  I0 => sdrc_top_inst_U1_Sdrc_rd_n_i_reg,
  I1 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n549_s21\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U1_n549,
  I0 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n562_s13\: LUT4
generic map (
  INIT => X"0708"
)
port map (
  F => sdrc_top_inst_U1_n562,
  I0 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0),
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I2 => sdrc_top_inst_U1_n562_24,
  I3 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2));
\sdrc_top_inst/U1/n565_s12\: LUT3
generic map (
  INIT => X"14"
)
port map (
  F => sdrc_top_inst_U1_n565,
  I0 => sdrc_top_inst_U1_n562_24,
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1));
\sdrc_top_inst/U1/n559_s12\: LUT4
generic map (
  INIT => X"BBB0"
)
port map (
  F => sdrc_top_inst_U1_n559,
  I0 => sdrc_top_inst_U1_n559_19,
  I1 => sdrc_top_inst_U1_n559_18,
  I2 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I3 => sdrc_top_inst_U1_n559_22);
\sdrc_top_inst/U0/n955_s5\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U0_n955,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\,
  I2 => sdrc_top_inst_U0_n959_7,
  I3 => sdrc_top_inst_U0_n955_11);
\sdrc_top_inst/U0/n968_s5\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n968,
  I0 => sdrc_top_inst_U0_n968_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\,
  I3 => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/n970_s5\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n970,
  I0 => sdrc_top_inst_U0_n970_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\,
  I3 => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U0/n972_s5\: LUT4
generic map (
  INIT => X"FFB0"
)
port map (
  F => sdrc_top_inst_U0_n972,
  I0 => sdrc_top_inst_U0_n972_11,
  I1 => sdrc_top_inst_U0_n927_9,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\,
  I3 => sdrc_top_inst_U0_n963);
\sdrc_top_inst/U1/n648_s11\: LUT4
generic map (
  INIT => X"75C0"
)
port map (
  F => sdrc_top_inst_U1_n648,
  I0 => sdrc_top_inst_U1_n648_19,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(6),
  I2 => sdrc_top_inst_U1_n648_20,
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7));
\sdrc_top_inst/U1/n654_s10\: LUT3
generic map (
  INIT => X"3A"
)
port map (
  F => sdrc_top_inst_U1_n654,
  I0 => sdrc_top_inst_U1_n654_18,
  I1 => sdrc_top_inst_U1_n648_19,
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5));
\sdrc_top_inst/U1/n657_s10\: LUT4
generic map (
  INIT => X"5730"
)
port map (
  F => sdrc_top_inst_U1_n657,
  I0 => sdrc_top_inst_U1_n657_16,
  I1 => sdrc_top_inst_U1_n657_17,
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(4));
\sdrc_top_inst/U1/n660_s10\: LUT3
generic map (
  INIT => X"35"
)
port map (
  F => sdrc_top_inst_U1_n660,
  I0 => sdrc_top_inst_U1_n657_17,
  I1 => sdrc_top_inst_U1_n657_16,
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3));
\sdrc_top_inst/U1/n663_s10\: LUT4
generic map (
  INIT => X"5730"
)
port map (
  F => sdrc_top_inst_U1_n663,
  I0 => sdrc_top_inst_U1_n663_16,
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I2 => sdrc_top_inst_U1_n663_17,
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(2));
\sdrc_top_inst/U1/n666_s10\: LUT4
generic map (
  INIT => X"5730"
)
port map (
  F => sdrc_top_inst_U1_n666,
  I0 => sdrc_top_inst_U1_n663_16,
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0),
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1));
\sdrc_top_inst/U1/n669_s10\: LUT3
generic map (
  INIT => X"35"
)
port map (
  F => sdrc_top_inst_U1_n669,
  I0 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I1 => sdrc_top_inst_U1_n663_16,
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0));
\sdrc_top_inst/U0/n93_s10\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U0_n93,
  I0 => sdrc_top_inst_U0_n95_15,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_IDLE\);
\sdrc_top_inst/U1/n568_s14\: LUT3
generic map (
  INIT => X"1F"
)
port map (
  F => sdrc_top_inst_U1_n568,
  I0 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0),
  I1 => sdrc_top_inst_U1_n562_24,
  I2 => sdrc_top_inst_U1_n562_19);
\sdrc_top_inst/U2/n52_s3\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U2_n52,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(0),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(2),
  I3 => sdrc_top_inst_U2_n54);
\sdrc_top_inst/U2/n49_s3\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U2_n49,
  I0 => sdrc_top_inst_U2_n49_8,
  I1 => sdrc_top_inst_U2_n51,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(5),
  I3 => sdrc_top_inst_U2_n54);
\sdrc_top_inst/U2/n48_s3\: LUT4
generic map (
  INIT => X"7800"
)
port map (
  F => sdrc_top_inst_U2_n48,
  I0 => sdrc_top_inst_U2_n49_8,
  I1 => sdrc_top_inst_U2_n48_8,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(6),
  I3 => sdrc_top_inst_U2_n54);
\sdrc_top_inst/U2/n55_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U2_n55,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(0),
  I1 => sdrc_top_inst_U2_n73_11,
  I2 => sdrc_top_inst_U2_n55_7,
  I3 => sdrc_top_inst_U2_n49_8);
\sdrc_top_inst/U0/O_autorefresh_ack_s4\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => sdrc_top_inst_U0_O_autorefresh_ack,
  I0 => sdrc_top_inst_U0_O_autorefresh_ack_7,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\);
\sdrc_top_inst/U1/O_sdrc_wrd_ack_s4\: LUT4
generic map (
  INIT => X"F0EE"
)
port map (
  F => sdrc_top_inst_U1_O_sdrc_wrd_ack,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I2 => sdrc_top_inst_U1_n1594,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U0/n9_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => sdrc_top_inst_U0_n9,
  I0 => \sdrc_top_inst/U0/Count_init_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_init_delay\(1));
\sdrc_top_inst/U0/n8_s0\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => sdrc_top_inst_U0_n8,
  I0 => \sdrc_top_inst/U0/Count_init_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_init_delay\(1),
  I2 => \sdrc_top_inst/U0/Count_init_delay\(2));
\sdrc_top_inst/U0/n7_s0\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => sdrc_top_inst_U0_n7,
  I0 => \sdrc_top_inst/U0/Count_init_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_init_delay\(1),
  I2 => \sdrc_top_inst/U0/Count_init_delay\(2),
  I3 => \sdrc_top_inst/U0/Count_init_delay\(3));
\sdrc_top_inst/U0/n155_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => sdrc_top_inst_U0_n155,
  I0 => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_cmd_delay\(1));
\sdrc_top_inst/U0/n154_s0\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => sdrc_top_inst_U0_n154,
  I0 => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_cmd_delay\(1),
  I2 => \sdrc_top_inst/U0/Count_cmd_delay\(2));
\sdrc_top_inst/U0/n153_s0\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => sdrc_top_inst_U0_n153,
  I0 => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_cmd_delay\(1),
  I2 => \sdrc_top_inst/U0/Count_cmd_delay\(2),
  I3 => \sdrc_top_inst/U0/Count_cmd_delay\(3));
\sdrc_top_inst/U1/n13_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => sdrc_top_inst_U1_n13,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(1),
  I1 => \sdrc_top_inst/U1/Count_buffer_wr\(0));
\sdrc_top_inst/U1/n12_s0\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => sdrc_top_inst_U1_n12,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(1),
  I1 => \sdrc_top_inst/U1/Count_buffer_wr\(0),
  I2 => \sdrc_top_inst/U1/Count_buffer_wr\(2));
\sdrc_top_inst/U1/n11_s0\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => sdrc_top_inst_U1_n11,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(2),
  I1 => \sdrc_top_inst/U1/Count_buffer_wr\(1),
  I2 => \sdrc_top_inst/U1/Count_buffer_wr\(0),
  I3 => \sdrc_top_inst/U1/Count_buffer_wr\(3));
\sdrc_top_inst/U0/n272_s1\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => sdrc_top_inst_U0_n272,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(6),
  I1 => sdrc_top_inst_U0_n273_6,
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(7));
\sdrc_top_inst/U0/n274_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n274_4,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(4),
  I1 => sdrc_top_inst_U0_n275_4);
\sdrc_top_inst/U0/n275_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U0_n275_4,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(3),
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(2),
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1));
\sdrc_top_inst/U0/n277_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n277_4,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1));
\sdrc_top_inst/U0/n959_s1\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U0_n959,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\);
\sdrc_top_inst/U0/n959_s2\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U0_n959_5,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\);
\sdrc_top_inst/U1/n984_s2\: LUT4
generic map (
  INIT => X"4F00"
)
port map (
  F => sdrc_top_inst_U1_n984_5,
  I0 => sdrc_top_inst_U1_n984_7,
  I1 => sdrc_top_inst_U1_n984_8,
  I2 => sdrc_top_inst_U1_n984_9,
  I3 => sdrc_top_inst_U1_n984_10);
\sdrc_top_inst/U1/n984_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U1_n984_6,
  I0 => \sdrc_top_inst/U1/Sdrc_data_len_i\(7),
  I1 => sdrc_top_inst_U1_n983_6);
\sdrc_top_inst/U1/n986_s1\: LUT4
generic map (
  INIT => X"5CCC"
)
port map (
  F => sdrc_top_inst_U1_n986_4,
  I0 => \sdrc_top_inst/U1/Column_remain_len_wrd\(4),
  I1 => I_sdrc_addr(4),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n987_s1\: LUT4
generic map (
  INIT => X"5CCC"
)
port map (
  F => sdrc_top_inst_U1_n987_4,
  I0 => \sdrc_top_inst/U1/Column_remain_len_wrd\(3),
  I1 => I_sdrc_addr(3),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n988_s1\: LUT4
generic map (
  INIT => X"5CCC"
)
port map (
  F => sdrc_top_inst_U1_n988_4,
  I0 => \sdrc_top_inst/U1/Column_remain_len_wrd\(2),
  I1 => I_sdrc_addr(2),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n989_s1\: LUT4
generic map (
  INIT => X"5CCC"
)
port map (
  F => sdrc_top_inst_U1_n989_4,
  I0 => \sdrc_top_inst/U1/Column_remain_len_wrd\(1),
  I1 => I_sdrc_addr(1),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n990_s1\: LUT4
generic map (
  INIT => X"5CCC"
)
port map (
  F => sdrc_top_inst_U1_n990_4,
  I0 => \sdrc_top_inst/U1/Column_remain_len_wrd\(0),
  I1 => I_sdrc_addr(0),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U2/n73_s2\: LUT4
generic map (
  INIT => X"1C00"
)
port map (
  F => sdrc_top_inst_U2_n73_5,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(2),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(3),
  I3 => \sdrc_top_inst/U2/Count_autorefresh\(4));
\sdrc_top_inst/U0/O_ctrl_fsm_wrd_done_s4\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I0 => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_cmd_delay\(2),
  I2 => \sdrc_top_inst/U0/Count_cmd_delay\(3),
  I3 => \sdrc_top_inst/U0/Count_cmd_delay\(1));
\sdrc_top_inst/U0/Flag_sdrc_wrd_s4\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U0_Flag_sdrc_wrd_8,
  I0 => sdrc_top_inst_U0_Flag_sdrc_wrd_9,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U1/O_ctrl_fsm_data_31_s6\: LUT4
generic map (
  INIT => X"DD0D"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_9,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I3 => sdrc_top_inst_U1_n98_16);
\sdrc_top_inst/U1/n562_s14\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => sdrc_top_inst_U1_n562_19,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\);
\sdrc_top_inst/U1/n559_s13\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U1_n559_18,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WAITING\,
  I1 => sdrc_top_inst_U1_n547_26);
\sdrc_top_inst/U1/n648_s12\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U1_n648_18,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\);
\sdrc_top_inst/U1/User_model_state.STATE_READ_s4\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => \sdrc_top_inst_U1_User_model_state.STATE_READ_9\,
  I0 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I1 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I2 => sdrc_top_inst_U1_n547_26);
\sdrc_top_inst/U1/User_model_state.STATE_READ_s5\: LUT3
generic map (
  INIT => X"0E"
)
port map (
  F => \sdrc_top_inst_U1_User_model_state.STATE_READ_10\,
  I0 => sdrc_top_inst_U1_n550,
  I1 => sdrc_top_inst_U1_n562_24,
  I2 => sdrc_top_inst_U1_n559_19);
\sdrc_top_inst/U0/n927_s5\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => sdrc_top_inst_U0_n927_9,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\,
  I2 => sdrc_top_inst_U0_n962,
  I3 => sdrc_top_inst_U0_n927_11);
\sdrc_top_inst/U0/n927_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n927_10,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(5),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(5));
\sdrc_top_inst/U0/n930_s5\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n930_9,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(4),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(4));
\sdrc_top_inst/U0/n958_s6\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => sdrc_top_inst_U0_n958,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\,
  I3 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n974_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n974_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(7),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(7));
\sdrc_top_inst/U0/n976_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n976_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(6),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(6));
\sdrc_top_inst/U0/n980_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n980_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(3),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(3));
\sdrc_top_inst/U0/n982_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n982_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(2),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(2));
\sdrc_top_inst/U0/n984_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n984_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(1));
\sdrc_top_inst/U0/n986_s6\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n986_11,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I1 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(0));
\sdrc_top_inst/U0/n634_s6\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n634,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(0),
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(2));
\sdrc_top_inst/U0/n650_s6\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n650,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(0),
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(2));
\sdrc_top_inst/U1/n95_s11\: LUT4
generic map (
  INIT => X"30AF"
)
port map (
  F => sdrc_top_inst_U1_n95_16,
  I0 => sdrc_top_inst_U1_n95_26,
  I1 => sdrc_top_inst_U1_n95_24,
  I2 => sdrc_top_inst_U1_n95_20,
  I3 => \sdrc_top_inst/U1/Count_buffer_rd\(3));
\sdrc_top_inst/U1/n95_s12\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => sdrc_top_inst_U1_n95_17,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(3),
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(3),
  I2 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n96_s11\: LUT4
generic map (
  INIT => X"00BF"
)
port map (
  F => sdrc_top_inst_U1_n96_15,
  I0 => sdrc_top_inst_U1_n95_26,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I2 => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  I3 => \sdrc_top_inst/U1/Count_buffer_rd\(2));
\sdrc_top_inst/U1/n96_s12\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => sdrc_top_inst_U1_n96_16,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(2),
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(2),
  I2 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n97_s10\: LUT3
generic map (
  INIT => X"0B"
)
port map (
  F => sdrc_top_inst_U1_n97_14,
  I0 => sdrc_top_inst_U1_n95_26,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I2 => \sdrc_top_inst/U1/Count_buffer_rd\(1));
\sdrc_top_inst/U1/n97_s11\: LUT4
generic map (
  INIT => X"00BF"
)
port map (
  F => sdrc_top_inst_U1_n97_15,
  I0 => sdrc_top_inst_U1_n95_24,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  I2 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I3 => sdrc_top_inst_U1_n648_18);
\sdrc_top_inst/U1/n97_s12\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => sdrc_top_inst_U1_n97_16,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(1),
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  I2 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n98_s11\: LUT3
generic map (
  INIT => X"0D"
)
port map (
  F => sdrc_top_inst_U1_n98_15,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I2 => sdrc_top_inst_U1_n98_17);
\sdrc_top_inst/U1/n98_s12\: LUT3
generic map (
  INIT => X"2B"
)
port map (
  F => sdrc_top_inst_U1_n98_16,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  I1 => \sdrc_top_inst/U1/Data_len_0_wrd\(7),
  I2 => sdrc_top_inst_U1_n245_32);
\sdrc_top_inst/U1/n645_s11\: LUT4
generic map (
  INIT => X"F400"
)
port map (
  F => sdrc_top_inst_U1_n645_16,
  I0 => sdrc_top_inst_U1_n554,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I2 => sdrc_top_inst_U1_n645_17,
  I3 => sdrc_top_inst_U1_ctrl_fsm_rd_n);
\sdrc_top_inst/U1/n642_s12\: LUT4
generic map (
  INIT => X"0BBB"
)
port map (
  F => sdrc_top_inst_U1_n642,
  I0 => sdrc_top_inst_U1_n554,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg);
\sdrc_top_inst/U1/n570_s9\: LUT4
generic map (
  INIT => X"00BF"
)
port map (
  F => sdrc_top_inst_U1_n570_13,
  I0 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\);
\sdrc_top_inst/U1/n570_s10\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n570_14,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(1),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(20));
\sdrc_top_inst/U1/n572_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n572_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_bk\(0),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(19));
\sdrc_top_inst/U1/n574_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n574_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(10),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(18));
\sdrc_top_inst/U1/n576_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n576_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(9),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(17));
\sdrc_top_inst/U1/n578_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n578_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(8),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(16));
\sdrc_top_inst/U1/n580_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n580_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(7),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(15));
\sdrc_top_inst/U1/n582_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n582_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(6),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(14));
\sdrc_top_inst/U1/n584_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n584_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(5),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(13));
\sdrc_top_inst/U1/n586_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n586_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(4),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(12));
\sdrc_top_inst/U1/n588_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n588_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(3),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(11));
\sdrc_top_inst/U1/n590_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n590_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(2),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(10));
\sdrc_top_inst/U1/n592_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n592_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(1),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(9));
\sdrc_top_inst/U1/n594_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n594_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_row\(0),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(8));
\sdrc_top_inst/U1/n625_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n625_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(7),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(7));
\sdrc_top_inst/U1/n627_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n627_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(6),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(6));
\sdrc_top_inst/U1/n629_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n629_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(5),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(5));
\sdrc_top_inst/U1/n631_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n631_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(4),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(4));
\sdrc_top_inst/U1/n633_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n633_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(3),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(3));
\sdrc_top_inst/U1/n635_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n635_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(2),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(2));
\sdrc_top_inst/U1/n637_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n637_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(1),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(1));
\sdrc_top_inst/U1/n639_s9\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n639_13,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_data_len\(0),
  I1 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst/U1/Data_len_0_wrd\(0));
\sdrc_top_inst/U0/n95_s11\: LUT4
generic map (
  INIT => X"EEE0"
)
port map (
  F => sdrc_top_inst_U0_n95_15,
  I0 => sdrc_top_inst_U0_n959_5,
  I1 => sdrc_top_inst_U0_n99_15,
  I2 => sdrc_top_inst_U0_n959,
  I3 => sdrc_top_inst_U0_n103_15);
\sdrc_top_inst/U0/n99_s11\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => sdrc_top_inst_U0_n99_15,
  I0 => \sdrc_top_inst/U0/Count_init_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_init_delay\(2),
  I2 => \sdrc_top_inst/U0/Count_init_delay\(3),
  I3 => \sdrc_top_inst/U0/Count_init_delay\(1));
\sdrc_top_inst/U0/n103_s11\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => sdrc_top_inst_U0_n103_15,
  I0 => \sdrc_top_inst/U0/Count_init_delay\(0),
  I1 => \sdrc_top_inst/U0/Count_init_delay\(1),
  I2 => \sdrc_top_inst/U0/Count_init_delay\(2),
  I3 => \sdrc_top_inst/U0/Count_init_delay\(3));
\sdrc_top_inst/U0/n593_s19\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n593,
  I0 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I1 => sdrc_top_inst_U0_n593_24);
\sdrc_top_inst/U0/n596_s20\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n596_24,
  I0 => sdrc_top_inst_U0_n596_27,
  I1 => sdrc_top_inst_U0_n596_28);
\sdrc_top_inst/U0/n596_s22\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => sdrc_top_inst_U0_n596_26,
  I0 => sdrc_top_inst_U0_O_autorefresh_ack_7,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\,
  I2 => sdrc_top_inst_U0_n596_29,
  I3 => sdrc_top_inst_U0_n596_30);
\sdrc_top_inst/U0/n598_s21\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => sdrc_top_inst_U0_n598_25,
  I0 => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  I1 => sdrc_top_inst_U0_Flag_autorefresh,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I3 => sdrc_top_inst_U0_n705);
\sdrc_top_inst/U0/n598_s22\: LUT4
generic map (
  INIT => X"00EF"
)
port map (
  F => sdrc_top_inst_U0_n598_26,
  I0 => sdrc_top_inst_U0_n243,
  I1 => sdrc_top_inst_U0_Flag_sdrc_wrd_9,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I3 => sdrc_top_inst_U0_n598_27);
\sdrc_top_inst/U0/n606_s19\: LUT3
generic map (
  INIT => X"E0"
)
port map (
  F => sdrc_top_inst_U0_n606_23,
  I0 => sdrc_top_inst_U0_n606_25,
  I1 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I2 => sdrc_top_inst_U0_n593_24);
\sdrc_top_inst/U0/n606_s20\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => sdrc_top_inst_U0_n606_24,
  I0 => sdrc_top_inst_U0_Flag_sdrc_wrd,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\,
  I2 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6);
\sdrc_top_inst/U0/n608_s20\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n608_24,
  I0 => sdrc_top_inst_U0_Flag_sdrc_wrd,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\,
  I2 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6);
\sdrc_top_inst/U0/n612_s20\: LUT4
generic map (
  INIT => X"7077"
)
port map (
  F => sdrc_top_inst_U0_n612_24,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE\,
  I1 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I2 => sdrc_top_inst_U0_n516_3,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/n616_s20\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U0_n616_24,
  I0 => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U0/n618_s20\: LUT4
generic map (
  INIT => X"F400"
)
port map (
  F => sdrc_top_inst_U0_n618_24,
  I0 => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  I1 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I2 => sdrc_top_inst_U0_n618_25,
  I3 => sdrc_top_inst_U0_n618_26);
\sdrc_top_inst/U1/n547_s17\: LUT4
generic map (
  INIT => X"77F0"
)
port map (
  F => sdrc_top_inst_U1_n547_21,
  I0 => sdrc_top_inst_U1_Double_wrd_flag,
  I1 => sdrc_top_inst_U1_n547_24,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => sdrc_top_inst_U0_ctrl_fsm_wrd_done);
\sdrc_top_inst/U1/n547_s19\: LUT4
generic map (
  INIT => X"05CF"
)
port map (
  F => sdrc_top_inst_U1_n547_23,
  I0 => NN_4,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_10\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WAITING\);
\sdrc_top_inst/U1/n550_s25\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => sdrc_top_inst_U1_n550,
  I0 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0));
\sdrc_top_inst/U1/n554_s26\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => sdrc_top_inst_U1_n554,
  I0 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I1 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I2 => sdrc_top_inst_U1_Double_wrd_flag);
\sdrc_top_inst/U1/n559_s14\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U1_n559_19,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I2 => sdrc_top_inst_U1_Sdrc_rd_n_i_reg);
\sdrc_top_inst/U0/n955_s6\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => sdrc_top_inst_U0_n955_11,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U0/n968_s6\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n968_11,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(10));
\sdrc_top_inst/U0/n970_s6\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n970_11,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(9));
\sdrc_top_inst/U0/n972_s6\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n972_11,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\,
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_row\(8));
\sdrc_top_inst/U1/n648_s13\: LUT4
generic map (
  INIT => X"F800"
)
port map (
  F => sdrc_top_inst_U1_n648_19,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  I1 => sdrc_top_inst_U1_n648_21,
  I2 => sdrc_top_inst_U1_n648_18,
  I3 => sdrc_top_inst_U1_n663_16);
\sdrc_top_inst/U1/n648_s14\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n648_20,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  I1 => sdrc_top_inst_U1_n654_18);
\sdrc_top_inst/U1/n657_s11\: LUT4
generic map (
  INIT => X"B0BB"
)
port map (
  F => sdrc_top_inst_U1_n657_16,
  I0 => sdrc_top_inst_U1_n657_21,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I2 => sdrc_top_inst_U1_n657_23,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\);
\sdrc_top_inst/U1/n657_s12\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n657_17,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I1 => sdrc_top_inst_U1_n657_21,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I3 => sdrc_top_inst_U1_n657_23);
\sdrc_top_inst/U1/n663_s11\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => sdrc_top_inst_U1_n663_16,
  I0 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_9,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I2 => sdrc_top_inst_U1_n95_24);
\sdrc_top_inst/U1/n663_s12\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n663_17,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0));
\sdrc_top_inst/U2/n54_s4\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U2_n54,
  I0 => sdrc_top_inst_U0_autorefresh_ack,
  I1 => sdrc_top_inst_U2_Count_autorefresh_11_25);
\sdrc_top_inst/U2/n51_s4\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U2_n51,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(0),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(2));
\sdrc_top_inst/U2/n50_s4\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => sdrc_top_inst_U2_n50,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(3),
  I1 => sdrc_top_inst_U2_n51,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(4));
\sdrc_top_inst/U2/n49_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U2_n49_8,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(3),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(4));
\sdrc_top_inst/U2/n48_s4\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U2_n48_8,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(0),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(2),
  I3 => \sdrc_top_inst/U2/Count_autorefresh\(5));
\sdrc_top_inst/U2/n46_s4\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U2_n46,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(6),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(7),
  I2 => sdrc_top_inst_U2_n49_8,
  I3 => sdrc_top_inst_U2_n48_8);
\sdrc_top_inst/U2/n45_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U2_n45,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(8),
  I1 => sdrc_top_inst_U2_n46);
\sdrc_top_inst/U2/n44_s4\: LUT4
generic map (
  INIT => X"8700"
)
port map (
  F => sdrc_top_inst_U2_n44,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(9),
  I1 => sdrc_top_inst_U2_n45,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(10),
  I3 => sdrc_top_inst_U2_Count_autorefresh_11_25);
\sdrc_top_inst/U2/n55_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U2_n55_7,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(2));
\sdrc_top_inst/U0/n705_s2\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U0_n705,
  I0 => I_sdrc_power_down,
  I1 => sdrc_top_inst_U0_I_selfrefresh_reg);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_7_s5\: LUT3
generic map (
  INIT => X"D0"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I0 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I1 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\);
\sdrc_top_inst/U0/O_autorefresh_ack_s5\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => sdrc_top_inst_U0_O_autorefresh_ack_7,
  I0 => \sdrc_top_inst/U0/Count_cmd_delay\(1),
  I1 => \sdrc_top_inst/U0/Count_cmd_delay\(2),
  I2 => \sdrc_top_inst/U0/Count_cmd_delay\(0),
  I3 => \sdrc_top_inst/U0/Count_cmd_delay\(3));
\sdrc_top_inst/U1/n984_s4\: LUT4
generic map (
  INIT => X"4F00"
)
port map (
  F => sdrc_top_inst_U1_n984_7,
  I0 => sdrc_top_inst_U1_n984_11,
  I1 => sdrc_top_inst_U1_n984_12,
  I2 => sdrc_top_inst_U1_n984_13,
  I3 => sdrc_top_inst_U1_n984_14);
\sdrc_top_inst/U1/n984_s5\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n984_8,
  I0 => sdrc_top_inst_U1_n986_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(4),
  I2 => sdrc_top_inst_U1_n985_6,
  I3 => \sdrc_top_inst/U1/Sdrc_data_len_i\(5));
\sdrc_top_inst/U1/n984_s6\: LUT4
generic map (
  INIT => X"EEE0"
)
port map (
  F => sdrc_top_inst_U1_n984_9,
  I0 => \sdrc_top_inst/U1/Sdrc_data_len_i\(5),
  I1 => sdrc_top_inst_U1_n985_6,
  I2 => \sdrc_top_inst/U1/Sdrc_data_len_i\(6),
  I3 => sdrc_top_inst_U1_n984_16);
\sdrc_top_inst/U1/n984_s7\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n984_10,
  I0 => sdrc_top_inst_U1_n984_16,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(6),
  I2 => sdrc_top_inst_U1_n983_6,
  I3 => \sdrc_top_inst/U1/Sdrc_data_len_i\(7));
\sdrc_top_inst/U2/n73_s3\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => sdrc_top_inst_U2_n73_6,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(5),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(6),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(7),
  I3 => \sdrc_top_inst/U2/Count_autorefresh\(8));
\sdrc_top_inst/U0/Flag_sdrc_wrd_s5\: LUT4
generic map (
  INIT => X"00FE"
)
port map (
  F => sdrc_top_inst_U0_Flag_sdrc_wrd_9,
  I0 => I_sdrc_power_down,
  I1 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I2 => sdrc_top_inst_U0_Flag_autorefresh,
  I3 => sdrc_top_inst_U1_ctrl_double_wrd_flag);
\sdrc_top_inst/U1/O_ctrl_fsm_data_31_s7\: LUT3
generic map (
  INIT => X"2B"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_data_31_9,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(7),
  I2 => sdrc_top_inst_U1_n435_32);
\sdrc_top_inst/U0/n927_s7\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => sdrc_top_inst_U0_n927_11,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\,
  I1 => sdrc_top_inst_U0_n606_25,
  I2 => sdrc_top_inst_U0_n927_12);
\sdrc_top_inst/U1/n95_s15\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U1_n95_20,
  I0 => \sdrc_top_inst/U1/Count_buffer_rd\(2),
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  I2 => \sdrc_top_inst/U1/Count_buffer_rd\(0));
\sdrc_top_inst/U1/n98_s13\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => sdrc_top_inst_U1_n98_17,
  I0 => \sdrc_top_inst/U1/Count_buffer_wr\(0),
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(0),
  I2 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U1/n645_s12\: LUT3
generic map (
  INIT => X"B0"
)
port map (
  F => sdrc_top_inst_U1_n645_17,
  I0 => sdrc_top_inst_U1_Sdrc_rd_n_i_reg,
  I1 => sdrc_top_inst_U1_Sdrc_wr_n_i_reg,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U0/n593_s20\: LUT4
generic map (
  INIT => X"B000"
)
port map (
  F => sdrc_top_inst_U0_n593_24,
  I0 => sdrc_top_inst_U0_O_autorefresh_ack_7,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\,
  I2 => sdrc_top_inst_U0_n598_26,
  I3 => sdrc_top_inst_U0_n596_27);
\sdrc_top_inst/U0/n596_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U0_n596_27,
  I0 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\,
  I2 => I_sdrc_power_down,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\);
\sdrc_top_inst/U0/n596_s24\: LUT4
generic map (
  INIT => X"E0EE"
)
port map (
  F => sdrc_top_inst_U0_n596_28,
  I0 => sdrc_top_inst_U0_n606_25,
  I1 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I2 => sdrc_top_inst_U0_O_autorefresh_ack_7,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\);
\sdrc_top_inst/U0/n596_s25\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U0_n596_29,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\,
  I1 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6);
\sdrc_top_inst/U0/n596_s26\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => sdrc_top_inst_U0_n596_30,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_EXIT\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT\,
  I2 => sdrc_top_inst_U0_n596_31);
\sdrc_top_inst/U0/n598_s23\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => sdrc_top_inst_U0_n598_27,
  I0 => sdrc_top_inst_U0_ctrl_fsm_init,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\);
\sdrc_top_inst/U0/n606_s21\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => sdrc_top_inst_U0_n606_25,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_DATAIN2ACTIVE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\);
\sdrc_top_inst/U0/n618_s21\: LUT4
generic map (
  INIT => X"0D00"
)
port map (
  F => sdrc_top_inst_U0_n618_25,
  I0 => sdrc_top_inst_U0_Flag_autorefresh,
  I1 => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  I2 => sdrc_top_inst_U0_n243,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH\);
\sdrc_top_inst/U0/n618_s22\: LUT3
generic map (
  INIT => X"B0"
)
port map (
  F => sdrc_top_inst_U0_n618_26,
  I0 => sdrc_top_inst_U1_ctrl_double_wrd_flag,
  I1 => I_sdrc_power_down,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U1/n547_s20\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => sdrc_top_inst_U1_n547_24,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2_WAIT\);
\sdrc_top_inst/U1/n648_s15\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U1_n648_21,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(4),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  I2 => sdrc_top_inst_U1_n648_22);
\sdrc_top_inst/U1/n984_s8\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n984_11,
  I0 => sdrc_top_inst_U1_n990_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(0),
  I2 => sdrc_top_inst_U1_n989_4,
  I3 => \sdrc_top_inst/U1/Sdrc_data_len_i\(1));
\sdrc_top_inst/U1/n984_s9\: LUT4
generic map (
  INIT => X"EEE0"
)
port map (
  F => sdrc_top_inst_U1_n984_12,
  I0 => \sdrc_top_inst/U1/Sdrc_data_len_i\(1),
  I1 => sdrc_top_inst_U1_n989_4,
  I2 => \sdrc_top_inst/U1/Sdrc_data_len_i\(2),
  I3 => sdrc_top_inst_U1_n988_4);
\sdrc_top_inst/U1/n984_s10\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => sdrc_top_inst_U1_n984_13,
  I0 => sdrc_top_inst_U1_n988_4,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(2),
  I2 => sdrc_top_inst_U1_n987_4,
  I3 => \sdrc_top_inst/U1/Sdrc_data_len_i\(3));
\sdrc_top_inst/U1/n984_s11\: LUT4
generic map (
  INIT => X"EEE0"
)
port map (
  F => sdrc_top_inst_U1_n984_14,
  I0 => \sdrc_top_inst/U1/Sdrc_data_len_i\(3),
  I1 => sdrc_top_inst_U1_n987_4,
  I2 => \sdrc_top_inst/U1/Sdrc_data_len_i\(4),
  I3 => sdrc_top_inst_U1_n986_4);
\sdrc_top_inst/U0/n927_s8\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => sdrc_top_inst_U0_n927_12,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN_EXIT\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_AUTOREFRESH_DELAY\);
\sdrc_top_inst/U0/n596_s27\: LUT3
generic map (
  INIT => X"E0"
)
port map (
  F => sdrc_top_inst_U0_n596_31,
  I0 => sdrc_top_inst_U0_ctrl_fsm_init,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\);
\sdrc_top_inst/U1/n648_s16\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U1_n648_22,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(2),
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0));
\sdrc_top_inst/U0/n273_s2\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n273_6,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(5),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(4),
  I2 => sdrc_top_inst_U0_n275_4);
\sdrc_top_inst/U0/n276_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => sdrc_top_inst_U0_n276,
  I0 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(2),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I2 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(1),
  I3 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(3));
\sdrc_top_inst/U0/n620_s20\: LUT4
generic map (
  INIT => X"7000"
)
port map (
  F => sdrc_top_inst_U0_n620_25,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_POWER_DOWN\,
  I1 => I_sdrc_power_down,
  I2 => sdrc_top_inst_U0_n598_26,
  I3 => sdrc_top_inst_U0_n596_28);
\sdrc_top_inst/U0/n616_s22\: LUT4
generic map (
  INIT => X"7000"
)
port map (
  F => sdrc_top_inst_U0_n616_27,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_SELFREFRESH_WAIT\,
  I1 => sdrc_top_inst_U0_I_selfrefresh_reg,
  I2 => sdrc_top_inst_U0_n598_26,
  I3 => sdrc_top_inst_U0_n596_28);
\sdrc_top_inst/U0/n632_s7\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U0_n632,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(3),
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(0),
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(2));
\sdrc_top_inst/U0/n648_s7\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U0_n648,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(3),
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(0),
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(2));
\sdrc_top_inst/U0/n705_s3\: LUT4
generic map (
  INIT => X"0004"
)
port map (
  F => sdrc_top_inst_U0_n705_8,
  I0 => sdrc_top_inst_U0_Flag_autorefresh0,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => I_sdrc_power_down,
  I3 => sdrc_top_inst_U0_I_selfrefresh_reg);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_7_s6\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7_9,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(7),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_6_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_6,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(6),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_5_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_5,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(5),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_4_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_4,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(4),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_3_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_3,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(3),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_2_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_2,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(2),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_1_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_1,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(1),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_col_0_s5\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_0,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst/U1/Sdrc_addr_i\(0),
  I2 => sdrc_top_inst_U1_O_ctrl_fsm_addr_col_7,
  I3 => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1);
\sdrc_top_inst/U1/n654_s12\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => sdrc_top_inst_U1_n654_18,
  I0 => sdrc_top_inst_U1_O_ctrl_fsm_data_31_8,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(4),
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(3),
  I3 => sdrc_top_inst_U1_n648_22);
\sdrc_top_inst/U1/n96_s13\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => sdrc_top_inst_U1_n96_18,
  I0 => sdrc_top_inst_U1_n95_24,
  I1 => \sdrc_top_inst/U1/Count_buffer_rd\(2),
  I2 => \sdrc_top_inst/U1/Count_buffer_rd\(1),
  I3 => \sdrc_top_inst/U1/Count_buffer_rd\(0));
\sdrc_top_inst/U2/Count_autorefresh_11_s6\: LUT4
generic map (
  INIT => X"5700"
)
port map (
  F => sdrc_top_inst_U2_Count_autorefresh_11,
  I0 => sdrc_top_inst_U2_n49_8,
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(2),
  I3 => sdrc_top_inst_U2_n73_6);
\sdrc_top_inst/U0/n604_s19\: LUT4
generic map (
  INIT => X"FF70"
)
port map (
  F => sdrc_top_inst_U0_n604,
  I0 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I1 => sdrc_top_inst_U0_n593_24,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE2RW_DELAY\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_ACTIVE\);
\sdrc_top_inst/U0/n593_s21\: LUT4
generic map (
  INIT => X"FF70"
)
port map (
  F => sdrc_top_inst_U0_n593_26,
  I0 => sdrc_top_inst_U0_O_ctrl_fsm_wrd_done_6,
  I1 => sdrc_top_inst_U0_n593_24,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE_DELAY\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_PRECHARGE\);
\sdrc_top_inst/U0/n97_s12\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => sdrc_top_inst_U0_n97_17,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\,
  I2 => sdrc_top_inst_U0_n99_15);
\sdrc_top_inst/U0/n959_s3\: LUT4
generic map (
  INIT => X"FEFF"
)
port map (
  F => sdrc_top_inst_U0_n959_7,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_IDLE\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2_DELAY\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1_DELAY\,
  I3 => sdrc_top_inst_U0_n959_5);
\sdrc_top_inst/U0/n101_s12\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => sdrc_top_inst_U0_n101_17,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_LOAD_MODEREG_DELAY\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGE_DELAY\,
  I2 => sdrc_top_inst_U0_n103_15);
\sdrc_top_inst/U1/n657_s15\: LUT4
generic map (
  INIT => X"D400"
)
port map (
  F => sdrc_top_inst_U1_n657_21,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  I1 => \sdrc_top_inst/U1/Data_len_1_wrd\(7),
  I2 => sdrc_top_inst_U1_n435_32,
  I3 => sdrc_top_inst_U1_n648_22);
\sdrc_top_inst/U1/n559_s16\: LUT4
generic map (
  INIT => X"5400"
)
port map (
  F => sdrc_top_inst_U1_n559_22,
  I0 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2_WAIT\,
  I3 => sdrc_top_inst_U1_User_busy_flag_n);
\sdrc_top_inst/U1/n547_s21\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => sdrc_top_inst_U1_n547_26,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2_WAIT\);
\sdrc_top_inst/U1/O_ctrl_fsm_addr_bk_1_s4\: LUT4
generic map (
  INIT => X"FE00"
)
port map (
  F => sdrc_top_inst_U1_O_ctrl_fsm_addr_bk_1,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I3 => I_sdrc_rst_n);
\sdrc_top_inst/U1/n562_s16\: LUT4
generic map (
  INIT => X"FEFF"
)
port map (
  F => sdrc_top_inst_U1_n562_22,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I3 => sdrc_top_inst_U1_n562_24);
\sdrc_top_inst/U1/n657_s16\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => sdrc_top_inst_U1_n657_23,
  I0 => sdrc_top_inst_U1_n98_16,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(2),
  I2 => \sdrc_top_inst/U1/Count_data_len_0_wr\(1),
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(0));
\sdrc_top_inst/U0/n598_s25\: LUT4
generic map (
  INIT => X"B000"
)
port map (
  F => sdrc_top_inst_U0_n598_31,
  I0 => sdrc_top_inst_U0_ctrl_fsm_init,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_INIT\,
  I2 => sdrc_top_inst_U0_n596_27,
  I3 => sdrc_top_inst_U0_n596_28);
\sdrc_top_inst/U0/n600_s20\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n600_25,
  I0 => sdrc_top_inst_U0_n598_26,
  I1 => sdrc_top_inst_U0_n596_27,
  I2 => sdrc_top_inst_U0_n596_28);
\sdrc_top_inst/U1/n985_s2\: LUT4
generic map (
  INIT => X"3AAA"
)
port map (
  F => sdrc_top_inst_U1_n985_6,
  I0 => I_sdrc_addr(5),
  I1 => \sdrc_top_inst/U1/Column_remain_len_wrd\(5),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n984_s12\: LUT4
generic map (
  INIT => X"3AAA"
)
port map (
  F => sdrc_top_inst_U1_n984_16,
  I0 => I_sdrc_addr(6),
  I1 => \sdrc_top_inst/U1/Column_remain_len_wrd\(6),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n983_s2\: LUT4
generic map (
  INIT => X"3AAA"
)
port map (
  F => sdrc_top_inst_U1_n983_6,
  I0 => I_sdrc_addr(7),
  I1 => \sdrc_top_inst/U1/Column_remain_len_wrd\(7),
  I2 => I_sdrc_wr_n,
  I3 => I_sdrc_rd_n);
\sdrc_top_inst/U1/n1714_s2\: LUT3
generic map (
  INIT => X"70"
)
port map (
  F => sdrc_top_inst_U1_n1714,
  I0 => I_sdrc_wr_n,
  I1 => I_sdrc_rd_n,
  I2 => I_sdrc_rst_n);
\sdrc_top_inst/U1/n556_s26\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n556,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I1 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I2 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I3 => sdrc_top_inst_U1_Double_wrd_flag);
\sdrc_top_inst/U1/n554_s27\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n554_32,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ_WAIT\,
  I1 => sdrc_top_inst_U0_ctrl_fsm_busy_n,
  I2 => sdrc_top_inst_U0_ctrl_fsm_wrd_done,
  I3 => sdrc_top_inst_U1_Double_wrd_flag);
\sdrc_top_inst/U1/n562_s17\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => sdrc_top_inst_U1_n562_24,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\);
\sdrc_top_inst/U1/n642_s13\: LUT4
generic map (
  INIT => X"FFF4"
)
port map (
  F => sdrc_top_inst_U1_n642_19,
  I0 => sdrc_top_inst_U1_n642,
  I1 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\);
\sdrc_top_inst/U1/n642_s14\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U1_n642_21,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\);
\sdrc_top_inst/U1/n555_s24\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n555,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ_2\,
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I3 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0));
\sdrc_top_inst/U1/n553_s24\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n553,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_READ\,
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I3 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0));
\sdrc_top_inst/U1/n551_s24\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n551,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\,
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I3 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0));
\sdrc_top_inst/U1/n550_s26\: LUT4
generic map (
  INIT => X"2000"
)
port map (
  F => sdrc_top_inst_U1_n550_31,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I1 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(2),
  I2 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(1),
  I3 => \sdrc_top_inst/U1/Count_ACTIVE2RW_DELAY\(0));
\sdrc_top_inst/U1/n648_s18\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U1_n648_26,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_WAIT\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2_WAIT\,
  I2 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\);
\sdrc_top_inst/U1/n95_s16\: LUT4
generic map (
  INIT => X"FF0E"
)
port map (
  F => sdrc_top_inst_U1_n95_22,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I2 => sdrc_top_inst_U1_n95_16,
  I3 => sdrc_top_inst_U1_n95_17);
\sdrc_top_inst/U1/n95_s17\: LUT4
generic map (
  INIT => X"2B00"
)
port map (
  F => sdrc_top_inst_U1_n95_24,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  I1 => \sdrc_top_inst/U1/Data_len_0_wrd\(7),
  I2 => sdrc_top_inst_U1_n245_32,
  I3 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE\);
\sdrc_top_inst/U1/n95_s18\: LUT4
generic map (
  INIT => X"0445"
)
port map (
  F => sdrc_top_inst_U1_n95_26,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_WRITE_2\,
  I1 => \sdrc_top_inst/U1/Count_data_len_0_wr\(7),
  I2 => \sdrc_top_inst/U1/Data_len_0_wrd\(7),
  I3 => sdrc_top_inst_U1_n245_32);
\sdrc_top_inst/U2/n47_s5\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => sdrc_top_inst_U2_n47,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(6),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(3),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(4),
  I3 => sdrc_top_inst_U2_n48_8);
\sdrc_top_inst/U1/n982_s18\: LUT3
generic map (
  INIT => X"54"
)
port map (
  F => sdrc_top_inst_U1_n982,
  I0 => sdrc_top_inst_U1_n984_5,
  I1 => \sdrc_top_inst/U1/Sdrc_data_len_i\(7),
  I2 => sdrc_top_inst_U1_n983_6);
\sdrc_top_inst/U0/n958_s7\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => sdrc_top_inst_U0_n958_13,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I2 => sdrc_top_inst_U0_n958);
\sdrc_top_inst/U0/Ctrl_fsm_addr_col_7_s5\: LUT4
generic map (
  INIT => X"FFF7"
)
port map (
  F => sdrc_top_inst_U0_Ctrl_fsm_addr_col_7,
  I0 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I1 => sdrc_top_inst_U1_ctrl_fsm_rd_n,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U0/Flag_sdrc_wrd_s7\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => sdrc_top_inst_U0_Flag_sdrc_wrd_13,
  I0 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I1 => sdrc_top_inst_U1_ctrl_fsm_rd_n,
  I2 => sdrc_top_inst_U0_Flag_sdrc_wrd_9,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U0/n596_s29\: LUT4
generic map (
  INIT => X"0800"
)
port map (
  F => sdrc_top_inst_U0_n596_35,
  I0 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I1 => sdrc_top_inst_U1_ctrl_fsm_rd_n,
  I2 => sdrc_top_inst_U0_Flag_sdrc_wrd_9,
  I3 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U0/n279_s1\: LUT4
generic map (
  INIT => X"3AAA"
)
port map (
  F => sdrc_top_inst_U0_n279,
  I0 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(0),
  I1 => \sdrc_top_inst/U0/Ctrl_fsm_addr_col\(0),
  I2 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I3 => sdrc_top_inst_U1_ctrl_fsm_rd_n);
\sdrc_top_inst/U0/n276_s3\: LUT4
generic map (
  INIT => X"ACCC"
)
port map (
  F => sdrc_top_inst_U0_n276_8,
  I0 => sdrc_top_inst_U0_n276,
  I1 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(3),
  I2 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I3 => sdrc_top_inst_U1_ctrl_fsm_rd_n);
\sdrc_top_inst/U0/n272_s2\: LUT4
generic map (
  INIT => X"ACCC"
)
port map (
  F => sdrc_top_inst_U0_n272_6,
  I0 => sdrc_top_inst_U0_n272,
  I1 => \sdrc_top_inst/U1/ctrl_fsm_addr_col\(7),
  I2 => sdrc_top_inst_U1_ctrl_fsm_wr_n,
  I3 => sdrc_top_inst_U1_ctrl_fsm_rd_n);
\sdrc_top_inst/U1/Addr_row_reg_0_s1\: DFF
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U1/Addr_row_reg\(0),
  D => sdrc_top_inst_U1_n129,
  CLK => I_sdrc_clk);
\sdrc_top_inst/U0/Flag_autorefresh_s4\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_Flag_autorefresh,
  D => sdrc_top_inst_U0_n132,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Flag_autorefresh0_s4\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => sdrc_top_inst_U0_Flag_autorefresh0,
  D => sdrc_top_inst_U0_n132_14,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_sdram_dqm_3_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => NN_3,
  D => sdrc_top_inst_U0_n856,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_sdram_dqm_2_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => NN_2,
  D => sdrc_top_inst_U0_n857,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_sdram_dqm_1_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => NN_1,
  D => sdrc_top_inst_U0_n858,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/O_sdram_dqm_0_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => NN_0,
  D => sdrc_top_inst_U0_n859,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_10_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(10),
  D => sdrc_top_inst_U2_n44_11,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_9_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(9),
  D => sdrc_top_inst_U2_n45_11,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_8_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(8),
  D => sdrc_top_inst_U2_n46_13,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_7_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(7),
  D => sdrc_top_inst_U2_n47_15,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_4_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(4),
  D => sdrc_top_inst_U2_n50_11,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_3_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(3),
  D => sdrc_top_inst_U2_n51_11,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_1_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(1),
  D => sdrc_top_inst_U2_n53,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U2/Count_autorefresh_0_s3\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U2/Count_autorefresh\(0),
  D => sdrc_top_inst_U2_n54_13,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_6_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(6),
  D => sdrc_top_inst_U0_n628_16,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_5_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(5),
  D => sdrc_top_inst_U0_n630_19,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_4_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(4),
  D => sdrc_top_inst_U0_n632_19,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_3_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(3),
  D => sdrc_top_inst_U0_n634_17,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_1_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  D => sdrc_top_inst_U0_n638_16,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_wr_0_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_wr\(0),
  D => sdrc_top_inst_U0_n640,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_6_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(6),
  D => sdrc_top_inst_U0_n644_16,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_5_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(5),
  D => sdrc_top_inst_U0_n646_19,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_4_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(4),
  D => sdrc_top_inst_U0_n648_19,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_3_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(3),
  D => sdrc_top_inst_U0_n650_17,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_1_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  D => sdrc_top_inst_U0_n654_16,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U0/Count_burst_num_rd_0_s2\: DFFC
generic map (
  INIT => '0'
)
port map (
  Q => \sdrc_top_inst/U0/Count_burst_num_rd\(0),
  D => sdrc_top_inst_U0_n656,
  CLK => I_sdrc_clk,
  CLEAR => sdrc_top_inst_U0_n316);
\sdrc_top_inst/U1/n1692_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => sdrc_top_inst_U1_n1692,
  I0 => I_sdrc_rst_n,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\);
\sdrc_top_inst/U0/n132_s5\: LUT3
generic map (
  INIT => X"32"
)
port map (
  F => sdrc_top_inst_U0_n132,
  I0 => sdrc_top_inst_U0_Flag_autorefresh,
  I1 => sdrc_top_inst_U0_Reset_autorefresh,
  I2 => sdrc_top_inst_U2_autorefresh_req);
\sdrc_top_inst/U0/n132_s7\: LUT3
generic map (
  INIT => X"54"
)
port map (
  F => sdrc_top_inst_U0_n132_14,
  I0 => sdrc_top_inst_U0_Reset_autorefresh,
  I1 => sdrc_top_inst_U0_Flag_autorefresh0,
  I2 => sdrc_top_inst_U2_autorefresh_req_a);
\sdrc_top_inst/U0/Ctrl_wr_data_valid_s4\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\);
\sdrc_top_inst/U2/n44_s6\: LUT4
generic map (
  INIT => X"040E"
)
port map (
  F => sdrc_top_inst_U2_n44_11,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(10),
  I2 => sdrc_top_inst_U0_autorefresh_ack,
  I3 => sdrc_top_inst_U2_n44);
\sdrc_top_inst/U2/Count_autorefresh_11_s7\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U2_Count_autorefresh_11_21,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack);
\sdrc_top_inst/U2/n45_s6\: LUT4
generic map (
  INIT => X"1230"
)
port map (
  F => sdrc_top_inst_U2_n45_11,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(9),
  I3 => sdrc_top_inst_U2_n45);
\sdrc_top_inst/U2/n46_s7\: LUT4
generic map (
  INIT => X"1230"
)
port map (
  F => sdrc_top_inst_U2_n46_13,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(8),
  I3 => sdrc_top_inst_U2_n46);
\sdrc_top_inst/U2/n47_s8\: LUT4
generic map (
  INIT => X"1230"
)
port map (
  F => sdrc_top_inst_U2_n47_15,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(7),
  I3 => sdrc_top_inst_U2_n47);
\sdrc_top_inst/U2/n50_s6\: LUT4
generic map (
  INIT => X"3210"
)
port map (
  F => sdrc_top_inst_U2_n50_11,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(4),
  I3 => sdrc_top_inst_U2_n50);
\sdrc_top_inst/U2/n51_s6\: LUT4
generic map (
  INIT => X"1230"
)
port map (
  F => sdrc_top_inst_U2_n51_11,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(3),
  I3 => sdrc_top_inst_U2_n51);
\sdrc_top_inst/U2/n53_s5\: LUT4
generic map (
  INIT => X"1230"
)
port map (
  F => sdrc_top_inst_U2_n53,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(1),
  I3 => \sdrc_top_inst/U2/Count_autorefresh\(0));
\sdrc_top_inst/U2/n54_s7\: LUT3
generic map (
  INIT => X"12"
)
port map (
  F => sdrc_top_inst_U2_n54_13,
  I0 => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I1 => sdrc_top_inst_U0_autorefresh_ack,
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(0));
\sdrc_top_inst/U0/n628_s8\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n628,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(6),
  I2 => sdrc_top_inst_U0_n626_21);
\sdrc_top_inst/U0/n626_s8\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U0_n626_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U0/n632_s10\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n632_17,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(4),
  I2 => sdrc_top_inst_U0_n632);
\sdrc_top_inst/U0/n634_s9\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n634_15,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(3),
  I2 => sdrc_top_inst_U0_n634);
\sdrc_top_inst/U0/n638_s8\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n638,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(0));
\sdrc_top_inst/U0/n640_s7\: LUT3
generic map (
  INIT => X"1A"
)
port map (
  F => sdrc_top_inst_U0_n640,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(0));
\sdrc_top_inst/U0/n644_s8\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n644,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(6),
  I2 => sdrc_top_inst_U0_n642_21);
\sdrc_top_inst/U0/n642_s8\: LUT2
generic map (
  INIT => X"E"
)
port map (
  F => sdrc_top_inst_U0_n642_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\);
\sdrc_top_inst/U0/n648_s10\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n648_17,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(4),
  I2 => sdrc_top_inst_U0_n648);
\sdrc_top_inst/U0/n650_s9\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n650_15,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(3),
  I2 => sdrc_top_inst_U0_n650);
\sdrc_top_inst/U0/n654_s8\: LUT3
generic map (
  INIT => X"28"
)
port map (
  F => sdrc_top_inst_U0_n654,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(1),
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(0));
\sdrc_top_inst/U0/n656_s7\: LUT3
generic map (
  INIT => X"1A"
)
port map (
  F => sdrc_top_inst_U0_n656,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(0));
\sdrc_top_inst/U0/n856_s5\: LUT4
generic map (
  INIT => X"D5C0"
)
port map (
  F => sdrc_top_inst_U0_n856,
  I0 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst/U1/ctrl_fsm_dqm\(3),
  I3 => NN_3);
\sdrc_top_inst/U0/n857_s5\: LUT4
generic map (
  INIT => X"D5C0"
)
port map (
  F => sdrc_top_inst_U0_n857,
  I0 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst/U1/ctrl_fsm_dqm\(2),
  I3 => NN_2);
\sdrc_top_inst/U0/n858_s5\: LUT4
generic map (
  INIT => X"D5C0"
)
port map (
  F => sdrc_top_inst_U0_n858,
  I0 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst/U1/ctrl_fsm_dqm\(1),
  I3 => NN_1);
\sdrc_top_inst/U0/n859_s5\: LUT4
generic map (
  INIT => X"D5C0"
)
port map (
  F => sdrc_top_inst_U0_n859,
  I0 => sdrc_top_inst_U0_Ctrl_wr_data_valid_13,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst/U1/ctrl_fsm_dqm\(0),
  I3 => NN_0);
\sdrc_top_inst/U0/n630_s10\: LUT4
generic map (
  INIT => X"2888"
)
port map (
  F => sdrc_top_inst_U0_n630,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(5),
  I2 => \sdrc_top_inst/U0/Count_burst_num_wr\(4),
  I3 => sdrc_top_inst_U0_n632);
\sdrc_top_inst/U0/n626_s9\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n626_21,
  I0 => \sdrc_top_inst/U0/Count_burst_num_wr\(5),
  I1 => \sdrc_top_inst/U0/Count_burst_num_wr\(4),
  I2 => sdrc_top_inst_U0_n632);
\sdrc_top_inst/U0/n646_s10\: LUT4
generic map (
  INIT => X"2888"
)
port map (
  F => sdrc_top_inst_U0_n646,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(5),
  I2 => \sdrc_top_inst/U0/Count_burst_num_rd\(4),
  I3 => sdrc_top_inst_U0_n648);
\sdrc_top_inst/U0/n642_s9\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U0_n642_21,
  I0 => \sdrc_top_inst/U0/Count_burst_num_rd\(5),
  I1 => \sdrc_top_inst/U0/Count_burst_num_rd\(4),
  I2 => sdrc_top_inst_U0_n648);
\sdrc_top_inst/U0/n963_s1\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => sdrc_top_inst_U0_n963,
  I0 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH2\,
  I1 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_AUTOREFRESH1\,
  I2 => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_PRECHARGEALL\,
  I3 => sdrc_top_inst_U0_n959_7);
\sdrc_top_inst/U1/n559_s17\: LUT3
generic map (
  INIT => X"EF"
)
port map (
  F => sdrc_top_inst_U1_n559_24,
  I0 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_WAITING\,
  I2 => sdrc_top_inst_U1_n547_26);
\sdrc_top_inst/U1/n651_s11\: LUT4
generic map (
  INIT => X"0F88"
)
port map (
  F => sdrc_top_inst_U1_n651,
  I0 => \sdrc_top_inst/U1/Count_data_len_0_wr\(5),
  I1 => sdrc_top_inst_U1_n654_18,
  I2 => sdrc_top_inst_U1_n648_19,
  I3 => \sdrc_top_inst/U1/Count_data_len_0_wr\(6));
\sdrc_top_inst/U2/Count_autorefresh_11_s9\: LUT3
generic map (
  INIT => X"F7"
)
port map (
  F => sdrc_top_inst_U2_Count_autorefresh_11_25,
  I0 => \sdrc_top_inst/U2/Count_autorefresh\(9),
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(10),
  I2 => sdrc_top_inst_U2_Count_autorefresh_11);
\sdrc_top_inst/U2/n73_s6\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => sdrc_top_inst_U2_n73_11,
  I0 => sdrc_top_inst_U2_n73_6,
  I1 => \sdrc_top_inst/U2/Count_autorefresh\(9),
  I2 => \sdrc_top_inst/U2/Count_autorefresh\(10));
\sdrc_top_inst/U0/n638_s9\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n638_16,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n638,
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(1));
\sdrc_top_inst/U0/n634_s10\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n634_17,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n634_15,
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(3));
\sdrc_top_inst/U0/n632_s11\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n632_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n632_17,
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(4));
\sdrc_top_inst/U0/n630_s11\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n630_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n630,
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(5));
\sdrc_top_inst/U0/n628_s9\: LUT4
generic map (
  INIT => X"ABAA"
)
port map (
  F => sdrc_top_inst_U0_n628_16,
  I0 => sdrc_top_inst_U0_n628,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_WRITE_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I3 => \sdrc_top_inst/U0/Count_burst_num_wr\(6));
\sdrc_top_inst/U0/n654_s9\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n654_16,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n654,
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(1));
\sdrc_top_inst/U0/n650_s10\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n650_17,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n650_15,
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(3));
\sdrc_top_inst/U0/n648_s11\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n648_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n648_17,
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(4));
\sdrc_top_inst/U0/n646_s11\: LUT4
generic map (
  INIT => X"F1F0"
)
port map (
  F => sdrc_top_inst_U0_n646_19,
  I0 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I2 => sdrc_top_inst_U0_n646,
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(5));
\sdrc_top_inst/U0/n644_s9\: LUT4
generic map (
  INIT => X"ABAA"
)
port map (
  F => sdrc_top_inst_U0_n644_16,
  I0 => sdrc_top_inst_U0_n644,
  I1 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_READ_WITHOUT_AUTOPRE\,
  I2 => \sdrc_top_inst_U0_Cmd_fsm_state.SDRC_STATE_IDLE\,
  I3 => \sdrc_top_inst/U0/Count_burst_num_rd\(6));
\sdrc_top_inst/U1/n129_s5\: LUT4
generic map (
  INIT => X"70F8"
)
port map (
  F => sdrc_top_inst_U1_n129,
  I0 => I_sdrc_rst_n,
  I1 => \sdrc_top_inst_U1_User_model_state.STATE_IDLE\,
  I2 => \sdrc_top_inst/U1/Addr_row_reg\(0),
  I3 => \sdrc_top_inst/U1/Sdrc_addr_i\(8));
\sdrc_top_inst/U0/n316_s2\: INV
port map (
  O => sdrc_top_inst_U0_n316,
  I => I_sdrc_rst_n);
\sdrc_top_inst/U0/IO_sdram_dq_0_s3\: INV
port map (
  O => sdrc_top_inst_U0_IO_sdram_dq_0,
  I => sdrc_top_inst_U0_Ctrl_wr_data_valid);
\sdrc_top_inst/U0/n962_s4\: INV
port map (
  O => sdrc_top_inst_U0_n962_8,
  I => \sdrc_top_inst_U0_Cmd_init_state.INIT_STATE_INIT_DONE\);
\sdrc_top_inst/U1/n1276_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1276,
  I => I_sdrc_addr(7));
\sdrc_top_inst/U1/n1277_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1277,
  I => I_sdrc_addr(6));
\sdrc_top_inst/U1/n1278_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1278,
  I => I_sdrc_addr(5));
\sdrc_top_inst/U1/n1279_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1279,
  I => I_sdrc_addr(4));
\sdrc_top_inst/U1/n1280_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1280,
  I => I_sdrc_addr(3));
\sdrc_top_inst/U1/n1281_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1281,
  I => I_sdrc_addr(2));
\sdrc_top_inst/U1/n1282_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1282,
  I => I_sdrc_addr(1));
\sdrc_top_inst/U1/n1283_s3\: INV
port map (
  O => sdrc_top_inst_U1_n1283,
  I => I_sdrc_addr(0));
\sdrc_top_inst/U2/O_autorefresh_req_s3\: INV
port map (
  O => sdrc_top_inst_U2_O_autorefresh_req,
  I => sdrc_top_inst_U0_autorefresh_ack);
\sdrc_top_inst/U0/n341_s3\: INV
port map (
  O => sdrc_top_inst_U0_n341,
  I => sdrc_top_inst_U1_ctrl_fsm_wr_n);
\sdrc_top_inst/U0/n10_s2\: INV
port map (
  O => sdrc_top_inst_U0_n10,
  I => \sdrc_top_inst/U0/Count_init_delay\(0));
\sdrc_top_inst/U0/n156_s2\: INV
port map (
  O => sdrc_top_inst_U0_n156,
  I => \sdrc_top_inst/U0/Count_cmd_delay\(0));
\sdrc_top_inst/U1/n14_s2\: INV
port map (
  O => sdrc_top_inst_U1_n14,
  I => \sdrc_top_inst/U1/Count_buffer_wr\(0));
\sdrc_top_inst/U1/User_data_i_0_s24\: INV
port map (
  O => sdrc_top_inst_U1_User_data_i_0_24,
  I => sdrc_top_inst_U1_User_data_i_0);
GND_s2: GND
port map (
  G => NN);
VCC_s2: VCC
port map (
  V => VCC_0);
GSR_0: GSR
port map (
  GSRI => VCC_0);
  O_sdram_clk <= I_sdram_clk;
  O_sdram_cs_n <= NN;
  O_sdram_dqm(0) <= NN_0;
  O_sdram_dqm(1) <= NN_1;
  O_sdram_dqm(2) <= NN_2;
  O_sdram_dqm(3) <= NN_3;
  O_sdrc_init_done <= NN_4;
end beh;
