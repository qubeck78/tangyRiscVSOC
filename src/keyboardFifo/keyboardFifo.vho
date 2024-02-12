--
--Written by GowinSynthesis
--Tool Version "V1.9.9"
--Mon Feb 12 13:36:18 2024

--Source file index table:
--file0 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_HS/data/fifo_hs.v"
--file1 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_HS/data/fifo_hs_top.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw2a;
use gw2a.components.all;

entity keyboardFifo is
port(
  Data :  in std_logic_vector(31 downto 0);
  WrClk :  in std_logic;
  RdClk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Q :  out std_logic_vector(31 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end keyboardFifo;
architecture beh of keyboardFifo is
  signal fifo_inst_wfull_val1 : std_logic ;
  signal \fifo_inst_Equal.mem\ : std_logic ;
  signal \fifo_inst_Equal.mem_84\ : std_logic ;
  signal \fifo_inst_Equal.mem_83\ : std_logic ;
  signal \fifo_inst_Equal.mem_82\ : std_logic ;
  signal \fifo_inst_Equal.mem_89\ : std_logic ;
  signal \fifo_inst_Equal.mem_88\ : std_logic ;
  signal \fifo_inst_Equal.mem_87\ : std_logic ;
  signal \fifo_inst_Equal.mem_86\ : std_logic ;
  signal \fifo_inst_Equal.mem_93\ : std_logic ;
  signal \fifo_inst_Equal.mem_92\ : std_logic ;
  signal \fifo_inst_Equal.mem_91\ : std_logic ;
  signal \fifo_inst_Equal.mem_90\ : std_logic ;
  signal \fifo_inst_Equal.mem_97\ : std_logic ;
  signal \fifo_inst_Equal.mem_96\ : std_logic ;
  signal \fifo_inst_Equal.mem_95\ : std_logic ;
  signal \fifo_inst_Equal.mem_94\ : std_logic ;
  signal \fifo_inst_Equal.mem_101\ : std_logic ;
  signal \fifo_inst_Equal.mem_100\ : std_logic ;
  signal \fifo_inst_Equal.mem_99\ : std_logic ;
  signal \fifo_inst_Equal.mem_98\ : std_logic ;
  signal \fifo_inst_Equal.mem_105\ : std_logic ;
  signal \fifo_inst_Equal.mem_104\ : std_logic ;
  signal \fifo_inst_Equal.mem_103\ : std_logic ;
  signal \fifo_inst_Equal.mem_102\ : std_logic ;
  signal \fifo_inst_Equal.mem_109\ : std_logic ;
  signal \fifo_inst_Equal.mem_108\ : std_logic ;
  signal \fifo_inst_Equal.mem_107\ : std_logic ;
  signal \fifo_inst_Equal.mem_106\ : std_logic ;
  signal \fifo_inst_Equal.mem_113\ : std_logic ;
  signal \fifo_inst_Equal.mem_112\ : std_logic ;
  signal \fifo_inst_Equal.mem_111\ : std_logic ;
  signal \fifo_inst_Equal.mem_110\ : std_logic ;
  signal \fifo_inst_Equal.mem_117\ : std_logic ;
  signal \fifo_inst_Equal.mem_116\ : std_logic ;
  signal \fifo_inst_Equal.mem_115\ : std_logic ;
  signal \fifo_inst_Equal.mem_114\ : std_logic ;
  signal \fifo_inst_Equal.mem_121\ : std_logic ;
  signal \fifo_inst_Equal.mem_120\ : std_logic ;
  signal \fifo_inst_Equal.mem_119\ : std_logic ;
  signal \fifo_inst_Equal.mem_118\ : std_logic ;
  signal \fifo_inst_Equal.mem_125\ : std_logic ;
  signal \fifo_inst_Equal.mem_124\ : std_logic ;
  signal \fifo_inst_Equal.mem_123\ : std_logic ;
  signal \fifo_inst_Equal.mem_122\ : std_logic ;
  signal \fifo_inst_Equal.mem_129\ : std_logic ;
  signal \fifo_inst_Equal.mem_128\ : std_logic ;
  signal \fifo_inst_Equal.mem_127\ : std_logic ;
  signal \fifo_inst_Equal.mem_126\ : std_logic ;
  signal \fifo_inst_Equal.mem_133\ : std_logic ;
  signal \fifo_inst_Equal.mem_132\ : std_logic ;
  signal \fifo_inst_Equal.mem_131\ : std_logic ;
  signal \fifo_inst_Equal.mem_130\ : std_logic ;
  signal \fifo_inst_Equal.mem_137\ : std_logic ;
  signal \fifo_inst_Equal.mem_136\ : std_logic ;
  signal \fifo_inst_Equal.mem_135\ : std_logic ;
  signal \fifo_inst_Equal.mem_134\ : std_logic ;
  signal \fifo_inst_Equal.mem_141\ : std_logic ;
  signal \fifo_inst_Equal.mem_140\ : std_logic ;
  signal \fifo_inst_Equal.mem_139\ : std_logic ;
  signal \fifo_inst_Equal.mem_138\ : std_logic ;
  signal \fifo_inst_Equal.mem_145\ : std_logic ;
  signal \fifo_inst_Equal.mem_144\ : std_logic ;
  signal \fifo_inst_Equal.mem_143\ : std_logic ;
  signal \fifo_inst_Equal.mem_142\ : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0\ : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0_7_DO3\ : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0_7_DO2\ : std_logic ;
  signal fifo_inst_n156 : std_logic ;
  signal fifo_inst_n156_3 : std_logic ;
  signal fifo_inst_n157 : std_logic ;
  signal fifo_inst_n157_3 : std_logic ;
  signal fifo_inst_n158 : std_logic ;
  signal fifo_inst_n158_3 : std_logic ;
  signal fifo_inst_n159 : std_logic ;
  signal fifo_inst_n159_3 : std_logic ;
  signal fifo_inst_n160 : std_logic ;
  signal fifo_inst_n160_3 : std_logic ;
  signal fifo_inst_n22 : std_logic ;
  signal fifo_inst_wfull_val : std_logic ;
  signal \fifo_inst_Equal.mem_147\ : std_logic ;
  signal \fifo_inst_Equal.mem_149\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_0_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_1_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_2_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_3_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_4_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_5_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_6_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_7_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_8_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_9_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_10_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_11_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_12_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_13_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_14_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_15_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_16_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_17_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_18_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_19_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_20_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_21_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_22_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_23_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_24_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_25_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_26_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_27_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_28_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_29_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_30_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.mem_DOL_31_G[0]\ : std_logic ;
  signal \fifo_inst_Equal.wbinnext_0\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_1\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_4\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_1\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_4\ : std_logic ;
  signal fifo_inst_wfull_val_4 : std_logic ;
  signal fifo_inst_wfull_val_5 : std_logic ;
  signal fifo_inst_wfull_val_6 : std_logic ;
  signal fifo_inst_rempty_val : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0_18\ : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_inst/rbin_num\ : std_logic_vector(4 downto 0);
  signal \fifo_inst/rptr\ : std_logic_vector(5 downto 0);
  signal \fifo_inst/wptr\ : std_logic_vector(5 downto 0);
  signal \fifo_inst/Equal.wbin\ : std_logic_vector(4 downto 0);
  signal \fifo_inst/Equal.rq2_wptr\ : std_logic_vector(5 downto 0);
  signal \fifo_inst/Equal.rgraynext\ : std_logic_vector(4 downto 0);
  signal \fifo_inst/Equal.wgraynext\ : std_logic_vector(4 downto 0);
  signal \fifo_inst/rbin_num_next\ : std_logic_vector(5 downto 0);
  signal \fifo_inst/Equal.wbinnext\ : std_logic_vector(5 downto 1);
  signal NN : std_logic;
  signal NN_0 : std_logic;
begin
\fifo_inst/rbin_num_4_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(4),
  D => \fifo_inst/rbin_num_next\(4),
  CLK => RdClk);
\fifo_inst/rbin_num_3_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(3),
  D => \fifo_inst/rbin_num_next\(3),
  CLK => RdClk);
\fifo_inst/rbin_num_2_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(2),
  D => \fifo_inst/rbin_num_next\(2),
  CLK => RdClk);
\fifo_inst/rbin_num_1_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(1),
  D => \fifo_inst/rbin_num_next\(1),
  CLK => RdClk);
\fifo_inst/rbin_num_0_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(0),
  D => \fifo_inst/rbin_num_next\(0),
  CLK => RdClk);
\fifo_inst/Equal.wdata_q_31_s0\: DFFE
port map (
  Q => Q(31),
  D => \fifo_inst_Equal.mem_DOL_31_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_30_s0\: DFFE
port map (
  Q => Q(30),
  D => \fifo_inst_Equal.mem_DOL_30_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_29_s0\: DFFE
port map (
  Q => Q(29),
  D => \fifo_inst_Equal.mem_DOL_29_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_28_s0\: DFFE
port map (
  Q => Q(28),
  D => \fifo_inst_Equal.mem_DOL_28_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_27_s0\: DFFE
port map (
  Q => Q(27),
  D => \fifo_inst_Equal.mem_DOL_27_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_26_s0\: DFFE
port map (
  Q => Q(26),
  D => \fifo_inst_Equal.mem_DOL_26_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_25_s0\: DFFE
port map (
  Q => Q(25),
  D => \fifo_inst_Equal.mem_DOL_25_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_24_s0\: DFFE
port map (
  Q => Q(24),
  D => \fifo_inst_Equal.mem_DOL_24_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_23_s0\: DFFE
port map (
  Q => Q(23),
  D => \fifo_inst_Equal.mem_DOL_23_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_22_s0\: DFFE
port map (
  Q => Q(22),
  D => \fifo_inst_Equal.mem_DOL_22_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_21_s0\: DFFE
port map (
  Q => Q(21),
  D => \fifo_inst_Equal.mem_DOL_21_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_20_s0\: DFFE
port map (
  Q => Q(20),
  D => \fifo_inst_Equal.mem_DOL_20_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_19_s0\: DFFE
port map (
  Q => Q(19),
  D => \fifo_inst_Equal.mem_DOL_19_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_18_s0\: DFFE
port map (
  Q => Q(18),
  D => \fifo_inst_Equal.mem_DOL_18_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_17_s0\: DFFE
port map (
  Q => Q(17),
  D => \fifo_inst_Equal.mem_DOL_17_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_16_s0\: DFFE
port map (
  Q => Q(16),
  D => \fifo_inst_Equal.mem_DOL_16_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_15_s0\: DFFE
port map (
  Q => Q(15),
  D => \fifo_inst_Equal.mem_DOL_15_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_14_s0\: DFFE
port map (
  Q => Q(14),
  D => \fifo_inst_Equal.mem_DOL_14_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_13_s0\: DFFE
port map (
  Q => Q(13),
  D => \fifo_inst_Equal.mem_DOL_13_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_12_s0\: DFFE
port map (
  Q => Q(12),
  D => \fifo_inst_Equal.mem_DOL_12_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_11_s0\: DFFE
port map (
  Q => Q(11),
  D => \fifo_inst_Equal.mem_DOL_11_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_10_s0\: DFFE
port map (
  Q => Q(10),
  D => \fifo_inst_Equal.mem_DOL_10_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_9_s0\: DFFE
port map (
  Q => Q(9),
  D => \fifo_inst_Equal.mem_DOL_9_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_8_s0\: DFFE
port map (
  Q => Q(8),
  D => \fifo_inst_Equal.mem_DOL_8_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_7_s0\: DFFE
port map (
  Q => Q(7),
  D => \fifo_inst_Equal.mem_DOL_7_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_6_s0\: DFFE
port map (
  Q => Q(6),
  D => \fifo_inst_Equal.mem_DOL_6_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_5_s0\: DFFE
port map (
  Q => Q(5),
  D => \fifo_inst_Equal.mem_DOL_5_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_4_s0\: DFFE
port map (
  Q => Q(4),
  D => \fifo_inst_Equal.mem_DOL_4_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_3_s0\: DFFE
port map (
  Q => Q(3),
  D => \fifo_inst_Equal.mem_DOL_3_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_2_s0\: DFFE
port map (
  Q => Q(2),
  D => \fifo_inst_Equal.mem_DOL_2_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_1_s0\: DFFE
port map (
  Q => Q(1),
  D => \fifo_inst_Equal.mem_DOL_1_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/Equal.wdata_q_0_s0\: DFFE
port map (
  Q => Q(0),
  D => \fifo_inst_Equal.mem_DOL_0_G[0]\,
  CLK => RdClk,
  CE => fifo_inst_n22);
\fifo_inst/rptr_5_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(5),
  D => \fifo_inst/rbin_num_next\(5),
  CLK => RdClk);
\fifo_inst/rptr_4_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(4),
  D => \fifo_inst/Equal.rgraynext\(4),
  CLK => RdClk);
\fifo_inst/rptr_3_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(3),
  D => \fifo_inst/Equal.rgraynext\(3),
  CLK => RdClk);
\fifo_inst/rptr_2_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(2),
  D => \fifo_inst/Equal.rgraynext\(2),
  CLK => RdClk);
\fifo_inst/rptr_1_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(1),
  D => \fifo_inst/Equal.rgraynext\(1),
  CLK => RdClk);
\fifo_inst/rptr_0_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(0),
  D => \fifo_inst/Equal.rgraynext\(0),
  CLK => RdClk);
\fifo_inst/wptr_5_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(5),
  D => \fifo_inst/Equal.wbinnext\(5),
  CLK => WrClk);
\fifo_inst/wptr_4_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(4),
  D => \fifo_inst/Equal.wgraynext\(4),
  CLK => WrClk);
\fifo_inst/wptr_3_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(3),
  D => \fifo_inst/Equal.wgraynext\(3),
  CLK => WrClk);
\fifo_inst/wptr_2_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(2),
  D => \fifo_inst/Equal.wgraynext\(2),
  CLK => WrClk);
\fifo_inst/wptr_1_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(1),
  D => \fifo_inst/Equal.wgraynext\(1),
  CLK => WrClk);
\fifo_inst/wptr_0_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(0),
  D => \fifo_inst/Equal.wgraynext\(0),
  CLK => WrClk);
\fifo_inst/Equal.wbin_4_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(4),
  D => \fifo_inst/Equal.wbinnext\(4),
  CLK => WrClk);
\fifo_inst/Equal.wbin_3_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(3),
  D => \fifo_inst/Equal.wbinnext\(3),
  CLK => WrClk);
\fifo_inst/Equal.wbin_2_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(2),
  D => \fifo_inst/Equal.wbinnext\(2),
  CLK => WrClk);
\fifo_inst/Equal.wbin_1_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(1),
  D => \fifo_inst/Equal.wbinnext\(1),
  CLK => WrClk);
\fifo_inst/Equal.wbin_0_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(0),
  D => \fifo_inst_Equal.wbinnext_0\,
  CLK => WrClk);
\fifo_inst/Empty_s0\: DFF
port map (
  Q => NN,
  D => fifo_inst_rempty_val,
  CLK => RdClk);
\fifo_inst/wfull_val1_s0\: DFFP
port map (
  Q => fifo_inst_wfull_val1,
  D => fifo_inst_wfull_val,
  CLK => WrClk,
  PRESET => fifo_inst_wfull_val);
\fifo_inst/Full_s0\: DFFP
port map (
  Q => NN_0,
  D => fifo_inst_wfull_val1,
  CLK => WrClk,
  PRESET => fifo_inst_wfull_val);
\fifo_inst/Equal.mem_Equal.mem_0_0_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem\,
  DO(2) => \fifo_inst_Equal.mem_84\,
  DO(1) => \fifo_inst_Equal.mem_83\,
  DO(0) => \fifo_inst_Equal.mem_82\,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_1_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_89\,
  DO(2) => \fifo_inst_Equal.mem_88\,
  DO(1) => \fifo_inst_Equal.mem_87\,
  DO(0) => \fifo_inst_Equal.mem_86\,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_2_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_93\,
  DO(2) => \fifo_inst_Equal.mem_92\,
  DO(1) => \fifo_inst_Equal.mem_91\,
  DO(0) => \fifo_inst_Equal.mem_90\,
  DI(3 downto 0) => Data(11 downto 8),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_3_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_97\,
  DO(2) => \fifo_inst_Equal.mem_96\,
  DO(1) => \fifo_inst_Equal.mem_95\,
  DO(0) => \fifo_inst_Equal.mem_94\,
  DI(3 downto 0) => Data(15 downto 12),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_4_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_101\,
  DO(2) => \fifo_inst_Equal.mem_100\,
  DO(1) => \fifo_inst_Equal.mem_99\,
  DO(0) => \fifo_inst_Equal.mem_98\,
  DI(3 downto 0) => Data(19 downto 16),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_5_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_105\,
  DO(2) => \fifo_inst_Equal.mem_104\,
  DO(1) => \fifo_inst_Equal.mem_103\,
  DO(0) => \fifo_inst_Equal.mem_102\,
  DI(3 downto 0) => Data(23 downto 20),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_6_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_109\,
  DO(2) => \fifo_inst_Equal.mem_108\,
  DO(1) => \fifo_inst_Equal.mem_107\,
  DO(0) => \fifo_inst_Equal.mem_106\,
  DI(3 downto 0) => Data(27 downto 24),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_0_7_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_113\,
  DO(2) => \fifo_inst_Equal.mem_112\,
  DO(1) => \fifo_inst_Equal.mem_111\,
  DO(0) => \fifo_inst_Equal.mem_110\,
  DI(3 downto 0) => Data(31 downto 28),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_147\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_0_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_117\,
  DO(2) => \fifo_inst_Equal.mem_116\,
  DO(1) => \fifo_inst_Equal.mem_115\,
  DO(0) => \fifo_inst_Equal.mem_114\,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_1_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_121\,
  DO(2) => \fifo_inst_Equal.mem_120\,
  DO(1) => \fifo_inst_Equal.mem_119\,
  DO(0) => \fifo_inst_Equal.mem_118\,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_2_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_125\,
  DO(2) => \fifo_inst_Equal.mem_124\,
  DO(1) => \fifo_inst_Equal.mem_123\,
  DO(0) => \fifo_inst_Equal.mem_122\,
  DI(3 downto 0) => Data(11 downto 8),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_3_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_129\,
  DO(2) => \fifo_inst_Equal.mem_128\,
  DO(1) => \fifo_inst_Equal.mem_127\,
  DO(0) => \fifo_inst_Equal.mem_126\,
  DI(3 downto 0) => Data(15 downto 12),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_4_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_133\,
  DO(2) => \fifo_inst_Equal.mem_132\,
  DO(1) => \fifo_inst_Equal.mem_131\,
  DO(0) => \fifo_inst_Equal.mem_130\,
  DI(3 downto 0) => Data(19 downto 16),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_5_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_137\,
  DO(2) => \fifo_inst_Equal.mem_136\,
  DO(1) => \fifo_inst_Equal.mem_135\,
  DO(0) => \fifo_inst_Equal.mem_134\,
  DI(3 downto 0) => Data(23 downto 20),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_6_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_141\,
  DO(2) => \fifo_inst_Equal.mem_140\,
  DO(1) => \fifo_inst_Equal.mem_139\,
  DO(0) => \fifo_inst_Equal.mem_138\,
  DI(3 downto 0) => Data(27 downto 24),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.mem_Equal.mem_1_7_s\: RAM16SDP4
port map (
  DO(3) => \fifo_inst_Equal.mem_145\,
  DO(2) => \fifo_inst_Equal.mem_144\,
  DO(1) => \fifo_inst_Equal.mem_143\,
  DO(0) => \fifo_inst_Equal.mem_142\,
  DI(3 downto 0) => Data(31 downto 28),
  WAD(3 downto 0) => \fifo_inst/Equal.wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_inst/rbin_num_next\(3 downto 0),
  WRE => \fifo_inst_Equal.mem_149\,
  CLK => WrClk);
\fifo_inst/Equal.rq1_wptr_0_s2\: DFF
port map (
  Q => \fifo_inst_Equal.rq1_wptr_0\,
  D => \fifo_inst_Equal.rq1_wptr_0_18\,
  CLK => RdClk);
\fifo_inst/Equal.rq1_wptr_0_s4\: RAM16S4
port map (
  DO(3 downto 0) => \fifo_inst/Equal.rq2_wptr\(3 downto 0),
  DI(3 downto 0) => \fifo_inst/wptr\(3 downto 0),
  AD(3) => GND_0,
  AD(2) => GND_0,
  AD(1) => GND_0,
  AD(0) => \fifo_inst_Equal.rq1_wptr_0\,
  WRE => VCC_0,
  CLK => RdClk);
\fifo_inst/Equal.rq1_wptr_0_s6\: RAM16S4
port map (
  DO(3) => \fifo_inst_Equal.rq1_wptr_0_7_DO3\,
  DO(2) => \fifo_inst_Equal.rq1_wptr_0_7_DO2\,
  DO(1 downto 0) => \fifo_inst/Equal.rq2_wptr\(5 downto 4),
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => \fifo_inst/wptr\(5 downto 4),
  AD(3) => GND_0,
  AD(2) => GND_0,
  AD(1) => GND_0,
  AD(0) => \fifo_inst_Equal.rq1_wptr_0\,
  WRE => VCC_0,
  CLK => RdClk);
\fifo_inst/n156_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n156,
  COUT => fifo_inst_n156_3,
  I0 => \fifo_inst/Equal.rgraynext\(0),
  I1 => \fifo_inst/Equal.rq2_wptr\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_inst/n157_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n157,
  COUT => fifo_inst_n157_3,
  I0 => \fifo_inst/Equal.rgraynext\(1),
  I1 => \fifo_inst/Equal.rq2_wptr\(1),
  I3 => GND_0,
  CIN => fifo_inst_n156_3);
\fifo_inst/n158_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n158,
  COUT => fifo_inst_n158_3,
  I0 => \fifo_inst/Equal.rgraynext\(2),
  I1 => \fifo_inst/Equal.rq2_wptr\(2),
  I3 => GND_0,
  CIN => fifo_inst_n157_3);
\fifo_inst/n159_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n159,
  COUT => fifo_inst_n159_3,
  I0 => \fifo_inst/Equal.rgraynext\(3),
  I1 => \fifo_inst/Equal.rq2_wptr\(3),
  I3 => GND_0,
  CIN => fifo_inst_n158_3);
\fifo_inst/n160_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n160,
  COUT => fifo_inst_n160_3,
  I0 => \fifo_inst/Equal.rgraynext\(4),
  I1 => \fifo_inst/Equal.rq2_wptr\(4),
  I3 => GND_0,
  CIN => fifo_inst_n159_3);
\fifo_inst/n22_s1\: LUT3
generic map (
  INIT => X"0E"
)
port map (
  F => fifo_inst_n22,
  I0 => RdEn,
  I1 => NN,
  I2 => fifo_inst_rempty_val);
\fifo_inst/Equal.rgraynext_1_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(1),
  I0 => \fifo_inst/rbin_num_next\(1),
  I1 => \fifo_inst_Equal.rgraynext_1\,
  I2 => \fifo_inst/rbin_num\(2));
\fifo_inst/Equal.rgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(2),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_1\,
  I2 => \fifo_inst/rbin_num\(3));
\fifo_inst/Equal.rgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(3),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_1\,
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/Equal.rgraynext_4_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(4),
  I0 => \fifo_inst_Equal.rgraynext_1\,
  I1 => \fifo_inst_Equal.rgraynext_4\,
  I2 => \fifo_inst/rbin_num\(4),
  I3 => \fifo_inst/rptr\(5));
\fifo_inst/Equal.wgraynext_1_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(1),
  I0 => \fifo_inst/Equal.wbinnext\(1),
  I1 => \fifo_inst_Equal.wgraynext_1\,
  I2 => \fifo_inst/Equal.wbin\(2));
\fifo_inst/Equal.wgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(2),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_1\,
  I2 => \fifo_inst/Equal.wbin\(3));
\fifo_inst/Equal.wgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(3),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_1\,
  I2 => \fifo_inst/Equal.wbin\(3),
  I3 => \fifo_inst/Equal.wbin\(4));
\fifo_inst/Equal.wgraynext_4_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(4),
  I0 => \fifo_inst_Equal.wgraynext_1\,
  I1 => \fifo_inst_Equal.wgraynext_4\,
  I2 => \fifo_inst/Equal.wbin\(4),
  I3 => \fifo_inst/wptr\(5));
\fifo_inst/wfull_val_s0\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_inst_wfull_val,
  I0 => fifo_inst_wfull_val_4,
  I1 => fifo_inst_wfull_val_5,
  I2 => fifo_inst_wfull_val_6);
\fifo_inst/Equal.mem_s81\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => \fifo_inst_Equal.mem_147\,
  I0 => NN_0,
  I1 => \fifo_inst/Equal.wbin\(4),
  I2 => WrEn);
\fifo_inst/Equal.mem_s82\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => \fifo_inst_Equal.mem_149\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Equal.wbin\(4));
\fifo_inst/Equal.mem_DOL_0_G[0]_s0\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_0_G[0]\,
  I0 => \fifo_inst_Equal.mem_114\,
  I1 => \fifo_inst_Equal.mem_82\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_1_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_1_G[0]\,
  I0 => \fifo_inst_Equal.mem_83\,
  I1 => \fifo_inst_Equal.mem_115\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_2_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_2_G[0]\,
  I0 => \fifo_inst_Equal.mem_84\,
  I1 => \fifo_inst_Equal.mem_116\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_3_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_3_G[0]\,
  I0 => \fifo_inst_Equal.mem\,
  I1 => \fifo_inst_Equal.mem_117\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_4_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_4_G[0]\,
  I0 => \fifo_inst_Equal.mem_86\,
  I1 => \fifo_inst_Equal.mem_118\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_5_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_5_G[0]\,
  I0 => \fifo_inst_Equal.mem_87\,
  I1 => \fifo_inst_Equal.mem_119\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_6_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_6_G[0]\,
  I0 => \fifo_inst_Equal.mem_88\,
  I1 => \fifo_inst_Equal.mem_120\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_7_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_7_G[0]\,
  I0 => \fifo_inst_Equal.mem_89\,
  I1 => \fifo_inst_Equal.mem_121\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_8_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_8_G[0]\,
  I0 => \fifo_inst_Equal.mem_90\,
  I1 => \fifo_inst_Equal.mem_122\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_9_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_9_G[0]\,
  I0 => \fifo_inst_Equal.mem_91\,
  I1 => \fifo_inst_Equal.mem_123\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_10_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_10_G[0]\,
  I0 => \fifo_inst_Equal.mem_92\,
  I1 => \fifo_inst_Equal.mem_124\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_11_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_11_G[0]\,
  I0 => \fifo_inst_Equal.mem_93\,
  I1 => \fifo_inst_Equal.mem_125\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_12_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_12_G[0]\,
  I0 => \fifo_inst_Equal.mem_94\,
  I1 => \fifo_inst_Equal.mem_126\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_13_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_13_G[0]\,
  I0 => \fifo_inst_Equal.mem_95\,
  I1 => \fifo_inst_Equal.mem_127\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_14_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_14_G[0]\,
  I0 => \fifo_inst_Equal.mem_96\,
  I1 => \fifo_inst_Equal.mem_128\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_15_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_15_G[0]\,
  I0 => \fifo_inst_Equal.mem_97\,
  I1 => \fifo_inst_Equal.mem_129\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_16_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_16_G[0]\,
  I0 => \fifo_inst_Equal.mem_98\,
  I1 => \fifo_inst_Equal.mem_130\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_17_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_17_G[0]\,
  I0 => \fifo_inst_Equal.mem_99\,
  I1 => \fifo_inst_Equal.mem_131\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_18_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_18_G[0]\,
  I0 => \fifo_inst_Equal.mem_100\,
  I1 => \fifo_inst_Equal.mem_132\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_19_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_19_G[0]\,
  I0 => \fifo_inst_Equal.mem_101\,
  I1 => \fifo_inst_Equal.mem_133\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_20_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_20_G[0]\,
  I0 => \fifo_inst_Equal.mem_102\,
  I1 => \fifo_inst_Equal.mem_134\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_21_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_21_G[0]\,
  I0 => \fifo_inst_Equal.mem_103\,
  I1 => \fifo_inst_Equal.mem_135\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_22_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_22_G[0]\,
  I0 => \fifo_inst_Equal.mem_104\,
  I1 => \fifo_inst_Equal.mem_136\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_23_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_23_G[0]\,
  I0 => \fifo_inst_Equal.mem_105\,
  I1 => \fifo_inst_Equal.mem_137\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_24_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_24_G[0]\,
  I0 => \fifo_inst_Equal.mem_106\,
  I1 => \fifo_inst_Equal.mem_138\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_25_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_25_G[0]\,
  I0 => \fifo_inst_Equal.mem_107\,
  I1 => \fifo_inst_Equal.mem_139\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_26_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_26_G[0]\,
  I0 => \fifo_inst_Equal.mem_108\,
  I1 => \fifo_inst_Equal.mem_140\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_27_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_27_G[0]\,
  I0 => \fifo_inst_Equal.mem_109\,
  I1 => \fifo_inst_Equal.mem_141\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_28_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_28_G[0]\,
  I0 => \fifo_inst_Equal.mem_110\,
  I1 => \fifo_inst_Equal.mem_142\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_29_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_29_G[0]\,
  I0 => \fifo_inst_Equal.mem_111\,
  I1 => \fifo_inst_Equal.mem_143\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_30_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_30_G[0]\,
  I0 => \fifo_inst_Equal.mem_112\,
  I1 => \fifo_inst_Equal.mem_144\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Equal.mem_DOL_31_G[0]_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_inst_Equal.mem_DOL_31_G[0]\,
  I0 => \fifo_inst_Equal.mem_113\,
  I1 => \fifo_inst_Equal.mem_145\,
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/rbin_num_next_0_s6\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => \fifo_inst/rbin_num_next\(0),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/rbin_num_next_1_s4\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/rbin_num_next\(1),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_2_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(2),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_1\);
\fifo_inst/rbin_num_next_3_s4\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(3),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_1\,
  I2 => \fifo_inst/rbin_num\(3));
\fifo_inst/rbin_num_next_5_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(5),
  I0 => \fifo_inst/rbin_num\(4),
  I1 => \fifo_inst_Equal.rgraynext_1\,
  I2 => \fifo_inst_Equal.rgraynext_4\,
  I3 => \fifo_inst/rptr\(5));
\fifo_inst/Equal.wbinnext_0_s3\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => \fifo_inst_Equal.wbinnext_0\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Equal.wbin\(0));
\fifo_inst/Equal.wbinnext_1_s3\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(1),
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Equal.wbin\(0),
  I3 => \fifo_inst/Equal.wbin\(1));
\fifo_inst/Equal.wbinnext_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(2),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_1\);
\fifo_inst/Equal.wbinnext_3_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(3),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_1\,
  I2 => \fifo_inst/Equal.wbin\(3));
\fifo_inst/Equal.wbinnext_5_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(5),
  I0 => \fifo_inst/Equal.wbin\(4),
  I1 => \fifo_inst_Equal.wgraynext_1\,
  I2 => \fifo_inst_Equal.wgraynext_4\,
  I3 => \fifo_inst/wptr\(5));
\fifo_inst/Equal.rgraynext_1_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Equal.rgraynext_1\,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/Equal.rgraynext_4_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.rgraynext_4\,
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst/rbin_num\(3));
\fifo_inst/Equal.wgraynext_1_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Equal.wgraynext_1\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Equal.wbin\(0),
  I3 => \fifo_inst/Equal.wbin\(1));
\fifo_inst/Equal.wgraynext_4_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.wgraynext_4\,
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst/Equal.wbin\(3));
\fifo_inst/wfull_val_s1\: LUT4
generic map (
  INIT => X"0990"
)
port map (
  F => fifo_inst_wfull_val_4,
  I0 => \fifo_inst/wptr\(3),
  I1 => \fifo_inst/rptr\(3),
  I2 => \fifo_inst/wptr\(5),
  I3 => \fifo_inst/rptr\(5));
\fifo_inst/wfull_val_s2\: LUT4
generic map (
  INIT => X"0990"
)
port map (
  F => fifo_inst_wfull_val_5,
  I0 => \fifo_inst/wptr\(0),
  I1 => \fifo_inst/rptr\(0),
  I2 => \fifo_inst/wptr\(4),
  I3 => \fifo_inst/rptr\(4));
\fifo_inst/wfull_val_s3\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_6,
  I0 => \fifo_inst/wptr\(1),
  I1 => \fifo_inst/rptr\(1),
  I2 => \fifo_inst/wptr\(2),
  I3 => \fifo_inst/rptr\(2));
\fifo_inst/Equal.wgraynext_0_s1\: LUT4
generic map (
  INIT => X"659A"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(0),
  I0 => \fifo_inst/Equal.wbinnext\(1),
  I1 => NN_0,
  I2 => WrEn,
  I3 => \fifo_inst/Equal.wbin\(0));
\fifo_inst/rbin_num_next_4_s5\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(4),
  I0 => \fifo_inst_Equal.rgraynext_1\,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/Equal.wbinnext_4_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(4),
  I0 => \fifo_inst_Equal.wgraynext_1\,
  I1 => \fifo_inst/Equal.wbin\(2),
  I2 => \fifo_inst/Equal.wbin\(3),
  I3 => \fifo_inst/Equal.wbin\(4));
\fifo_inst/Equal.rgraynext_0_s1\: LUT4
generic map (
  INIT => X"4BB4"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(0),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num_next\(1));
\fifo_inst/rempty_val_s2\: LUT3
generic map (
  INIT => X"09"
)
port map (
  F => fifo_inst_rempty_val,
  I0 => \fifo_inst/rbin_num_next\(5),
  I1 => \fifo_inst/Equal.rq2_wptr\(5),
  I2 => fifo_inst_n160_3);
\fifo_inst/Equal.rq1_wptr_0_s12\: INV
port map (
  O => \fifo_inst_Equal.rq1_wptr_0_18\,
  I => \fifo_inst_Equal.rq1_wptr_0\);
GND_s0: GND
port map (
  G => GND_0);
VCC_s0: VCC
port map (
  V => VCC_0);
GSR_0: GSR
port map (
  GSRI => VCC_0);
  Empty <= NN;
  Full <= NN_0;
end beh;
