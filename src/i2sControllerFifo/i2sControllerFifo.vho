--
--Written by GowinSynthesis
--Tool Version "V1.9.9"
--Sun Feb 18 13:15:53 2024

--Source file index table:
--file0 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_HS/data/fifo_hs.v"
--file1 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_HS/data/fifo_hs_top.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw2a;
use gw2a.components.all;

entity i2sControllerFifo is
port(
  Data :  in std_logic_vector(31 downto 0);
  WrClk :  in std_logic;
  RdClk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Almost_Empty :  out std_logic;
  Q :  out std_logic_vector(31 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end i2sControllerFifo;
architecture beh of i2sControllerFifo is
  signal fifo_inst_wfull_val1 : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO31\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO30\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO29\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO28\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO27\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO26\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO25\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO24\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO23\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO22\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO21\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO20\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO19\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO18\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO17\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO16\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO31\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO30\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO29\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO28\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO27\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO26\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO25\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO24\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO23\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO22\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO21\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO20\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO19\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO18\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO17\ : std_logic ;
  signal \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO16\ : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0\ : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0_9_DO3\ : std_logic ;
  signal fifo_inst_rcnt_sub_0 : std_logic ;
  signal fifo_inst_rcnt_sub_1 : std_logic ;
  signal fifo_inst_rcnt_sub_2 : std_logic ;
  signal fifo_inst_rcnt_sub_3 : std_logic ;
  signal fifo_inst_rcnt_sub_4 : std_logic ;
  signal fifo_inst_rcnt_sub_5 : std_logic ;
  signal fifo_inst_rcnt_sub_6 : std_logic ;
  signal fifo_inst_rcnt_sub_7 : std_logic ;
  signal fifo_inst_rcnt_sub_8 : std_logic ;
  signal fifo_inst_rcnt_sub_9 : std_logic ;
  signal fifo_inst_rcnt_sub_10 : std_logic ;
  signal fifo_inst_n166 : std_logic ;
  signal fifo_inst_n166_3 : std_logic ;
  signal fifo_inst_n167 : std_logic ;
  signal fifo_inst_n167_3 : std_logic ;
  signal fifo_inst_n168 : std_logic ;
  signal fifo_inst_n168_3 : std_logic ;
  signal fifo_inst_n169 : std_logic ;
  signal fifo_inst_n169_3 : std_logic ;
  signal fifo_inst_n170 : std_logic ;
  signal fifo_inst_n170_3 : std_logic ;
  signal fifo_inst_n171 : std_logic ;
  signal fifo_inst_n171_3 : std_logic ;
  signal fifo_inst_n172 : std_logic ;
  signal fifo_inst_n172_3 : std_logic ;
  signal fifo_inst_n173 : std_logic ;
  signal fifo_inst_n173_3 : std_logic ;
  signal fifo_inst_n174 : std_logic ;
  signal fifo_inst_n174_3 : std_logic ;
  signal fifo_inst_n175 : std_logic ;
  signal fifo_inst_n175_3 : std_logic ;
  signal fifo_inst_n21 : std_logic ;
  signal fifo_inst_n27 : std_logic ;
  signal fifo_inst_n214 : std_logic ;
  signal fifo_inst_wfull_val : std_logic ;
  signal fifo_inst_n458 : std_logic ;
  signal \fifo_inst_Equal.rgraynext_2\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_4\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_6\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_8\ : std_logic ;
  signal \fifo_inst_Equal.rgraynext_9\ : std_logic ;
  signal \fifo_inst_Equal.wcount_r_4\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_2\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_4\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_6\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_8\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_9\ : std_logic ;
  signal fifo_inst_wfull_val_4 : std_logic ;
  signal fifo_inst_wfull_val_5 : std_logic ;
  signal fifo_inst_wfull_val_6 : std_logic ;
  signal fifo_inst_wfull_val_7 : std_logic ;
  signal fifo_inst_n462 : std_logic ;
  signal fifo_inst_n462_5 : std_logic ;
  signal \fifo_inst_Equal.rgraynext_6_5\ : std_logic ;
  signal \fifo_inst_Equal.wgraynext_6_5\ : std_logic ;
  signal fifo_inst_wfull_val_8 : std_logic ;
  signal fifo_inst_wfull_val_9 : std_logic ;
  signal fifo_inst_n462_6 : std_logic ;
  signal fifo_inst_n462_7 : std_logic ;
  signal fifo_inst_n462_9 : std_logic ;
  signal \fifo_inst_Equal.wbinnext_0\ : std_logic ;
  signal fifo_inst_rempty_val : std_logic ;
  signal \fifo_inst_Equal.rq1_wptr_0_19\ : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_inst/rbin_num\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/rptr\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/wptr\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/Equal.wbin\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Equal.wcount_r_d\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/rcnt_sub_d\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/Equal.rq2_wptr\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/rcnt_sub\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/Equal.rgraynext\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Equal.wcount_r\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Equal.wgraynext\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/rbin_num_next\ : std_logic_vector(10 downto 0);
  signal \fifo_inst/Equal.wbinnext\ : std_logic_vector(10 downto 1);
  signal NN : std_logic;
  signal NN_0 : std_logic;
begin
\fifo_inst/rbin_num_9_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(9),
  D => \fifo_inst/rbin_num_next\(9),
  CLK => RdClk);
\fifo_inst/rbin_num_8_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(8),
  D => \fifo_inst/rbin_num_next\(8),
  CLK => RdClk);
\fifo_inst/rbin_num_7_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(7),
  D => \fifo_inst/rbin_num_next\(7),
  CLK => RdClk);
\fifo_inst/rbin_num_6_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(6),
  D => \fifo_inst/rbin_num_next\(6),
  CLK => RdClk);
\fifo_inst/rbin_num_5_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(5),
  D => \fifo_inst/rbin_num_next\(5),
  CLK => RdClk);
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
\fifo_inst/rptr_10_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(10),
  D => \fifo_inst/rbin_num_next\(10),
  CLK => RdClk);
\fifo_inst/rptr_9_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(9),
  D => \fifo_inst/Equal.rgraynext\(9),
  CLK => RdClk);
\fifo_inst/rptr_8_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(8),
  D => \fifo_inst/Equal.rgraynext\(8),
  CLK => RdClk);
\fifo_inst/rptr_7_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(7),
  D => \fifo_inst/Equal.rgraynext\(7),
  CLK => RdClk);
\fifo_inst/rptr_6_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(6),
  D => \fifo_inst/Equal.rgraynext\(6),
  CLK => RdClk);
\fifo_inst/rptr_5_s0\: DFF
port map (
  Q => \fifo_inst/rptr\(5),
  D => \fifo_inst/Equal.rgraynext\(5),
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
\fifo_inst/wptr_10_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(10),
  D => \fifo_inst/Equal.wbinnext\(10),
  CLK => WrClk);
\fifo_inst/wptr_9_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(9),
  D => \fifo_inst/Equal.wgraynext\(9),
  CLK => WrClk);
\fifo_inst/wptr_8_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(8),
  D => \fifo_inst/Equal.wgraynext\(8),
  CLK => WrClk);
\fifo_inst/wptr_7_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(7),
  D => \fifo_inst/Equal.wgraynext\(7),
  CLK => WrClk);
\fifo_inst/wptr_6_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(6),
  D => \fifo_inst/Equal.wgraynext\(6),
  CLK => WrClk);
\fifo_inst/wptr_5_s0\: DFF
port map (
  Q => \fifo_inst/wptr\(5),
  D => \fifo_inst/Equal.wgraynext\(5),
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
\fifo_inst/Equal.wbin_9_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(9),
  D => \fifo_inst/Equal.wbinnext\(9),
  CLK => WrClk);
\fifo_inst/Equal.wbin_8_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(8),
  D => \fifo_inst/Equal.wbinnext\(8),
  CLK => WrClk);
\fifo_inst/Equal.wbin_7_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(7),
  D => \fifo_inst/Equal.wbinnext\(7),
  CLK => WrClk);
\fifo_inst/Equal.wbin_6_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(6),
  D => \fifo_inst/Equal.wbinnext\(6),
  CLK => WrClk);
\fifo_inst/Equal.wbin_5_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wbin\(5),
  D => \fifo_inst/Equal.wbinnext\(5),
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
\fifo_inst/Equal.wcount_r_d_10_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(10),
  D => \fifo_inst/Equal.rq2_wptr\(10),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_9_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(9),
  D => \fifo_inst/Equal.wcount_r\(9),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_8_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(8),
  D => \fifo_inst/Equal.wcount_r\(8),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_7_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(7),
  D => \fifo_inst/Equal.wcount_r\(7),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_6_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(6),
  D => \fifo_inst/Equal.wcount_r\(6),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_5_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(5),
  D => \fifo_inst/Equal.wcount_r\(5),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_4_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(4),
  D => \fifo_inst/Equal.wcount_r\(4),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_3_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(3),
  D => \fifo_inst/Equal.wcount_r\(3),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_2_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(2),
  D => \fifo_inst/Equal.wcount_r\(2),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_1_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(1),
  D => \fifo_inst/Equal.wcount_r\(1),
  CLK => RdClk);
\fifo_inst/Equal.wcount_r_d_0_s0\: DFF
port map (
  Q => \fifo_inst/Equal.wcount_r_d\(0),
  D => \fifo_inst/Equal.wcount_r\(0),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_10_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(10),
  D => \fifo_inst/rcnt_sub\(10),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_9_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(9),
  D => \fifo_inst/rcnt_sub\(9),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_8_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(8),
  D => \fifo_inst/rcnt_sub\(8),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_7_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(7),
  D => \fifo_inst/rcnt_sub\(7),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_6_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(6),
  D => \fifo_inst/rcnt_sub\(6),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_5_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(5),
  D => \fifo_inst/rcnt_sub\(5),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_4_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(4),
  D => \fifo_inst/rcnt_sub\(4),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_3_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(3),
  D => \fifo_inst/rcnt_sub\(3),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_2_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(2),
  D => \fifo_inst/rcnt_sub\(2),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_1_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(1),
  D => \fifo_inst/rcnt_sub\(1),
  CLK => RdClk);
\fifo_inst/rcnt_sub_d_0_s0\: DFF
port map (
  Q => \fifo_inst/rcnt_sub_d\(0),
  D => \fifo_inst/rcnt_sub\(0),
  CLK => RdClk);
\fifo_inst/Empty_s0\: DFF
port map (
  Q => NN,
  D => fifo_inst_rempty_val,
  CLK => RdClk);
\fifo_inst/Almost_Empty_s0\: DFFS
port map (
  Q => Almost_Empty,
  D => fifo_inst_n462_9,
  CLK => RdClk,
  SET => fifo_inst_n458);
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
\fifo_inst/Equal.mem_Equal.mem_0_0_s\: SDPB
generic map (
  BIT_WIDTH_0 => 16,
  BIT_WIDTH_1 => 16,
  READ_MODE => '0',
  RESET_MODE => "SYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO31\,
  DO(30) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO30\,
  DO(29) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO29\,
  DO(28) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO28\,
  DO(27) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO27\,
  DO(26) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO26\,
  DO(25) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO25\,
  DO(24) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO24\,
  DO(23) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO23\,
  DO(22) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO22\,
  DO(21) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO21\,
  DO(20) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO20\,
  DO(19) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO19\,
  DO(18) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO18\,
  DO(17) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO17\,
  DO(16) => \fifo_inst_Equal.mem_Equal.mem_0_0_0_DO16\,
  DO(15 downto 0) => Q(15 downto 0),
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15 downto 0) => Data(15 downto 0),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0,
  ADA(13 downto 4) => \fifo_inst/Equal.wbin\(9 downto 0),
  ADA(3) => GND_0,
  ADA(2) => GND_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 4) => \fifo_inst/rbin_num_next\(9 downto 0),
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  CLKA => WrClk,
  CLKB => RdClk,
  CEA => fifo_inst_n21,
  CEB => fifo_inst_n27,
  OCE => GND_0,
  RESETA => GND_0,
  RESETB => GND_0);
\fifo_inst/Equal.mem_Equal.mem_0_1_s\: SDPB
generic map (
  BIT_WIDTH_0 => 16,
  BIT_WIDTH_1 => 16,
  READ_MODE => '0',
  RESET_MODE => "SYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO31\,
  DO(30) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO30\,
  DO(29) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO29\,
  DO(28) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO28\,
  DO(27) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO27\,
  DO(26) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO26\,
  DO(25) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO25\,
  DO(24) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO24\,
  DO(23) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO23\,
  DO(22) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO22\,
  DO(21) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO21\,
  DO(20) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO20\,
  DO(19) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO19\,
  DO(18) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO18\,
  DO(17) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO17\,
  DO(16) => \fifo_inst_Equal.mem_Equal.mem_0_1_0_DO16\,
  DO(15 downto 0) => Q(31 downto 16),
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15 downto 0) => Data(31 downto 16),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0,
  ADA(13 downto 4) => \fifo_inst/Equal.wbin\(9 downto 0),
  ADA(3) => GND_0,
  ADA(2) => GND_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 4) => \fifo_inst/rbin_num_next\(9 downto 0),
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  CLKA => WrClk,
  CLKB => RdClk,
  CEA => fifo_inst_n21,
  CEB => fifo_inst_n27,
  OCE => GND_0,
  RESETA => GND_0,
  RESETB => GND_0);
\fifo_inst/Equal.rq1_wptr_0_s2\: DFF
port map (
  Q => \fifo_inst_Equal.rq1_wptr_0\,
  D => \fifo_inst_Equal.rq1_wptr_0_19\,
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
  DO(3 downto 0) => \fifo_inst/Equal.rq2_wptr\(7 downto 4),
  DI(3 downto 0) => \fifo_inst/wptr\(7 downto 4),
  AD(3) => GND_0,
  AD(2) => GND_0,
  AD(1) => GND_0,
  AD(0) => \fifo_inst_Equal.rq1_wptr_0\,
  WRE => VCC_0,
  CLK => RdClk);
\fifo_inst/Equal.rq1_wptr_0_s8\: RAM16S4
port map (
  DO(3) => \fifo_inst_Equal.rq1_wptr_0_9_DO3\,
  DO(2 downto 0) => \fifo_inst/Equal.rq2_wptr\(10 downto 8),
  DI(3) => GND_0,
  DI(2 downto 0) => \fifo_inst/wptr\(10 downto 8),
  AD(3) => GND_0,
  AD(2) => GND_0,
  AD(1) => GND_0,
  AD(0) => \fifo_inst_Equal.rq1_wptr_0\,
  WRE => VCC_0,
  CLK => RdClk);
\fifo_inst/rcnt_sub_0_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(0),
  COUT => fifo_inst_rcnt_sub_0,
  I0 => \fifo_inst/Equal.wcount_r_d\(0),
  I1 => \fifo_inst/rbin_num\(0),
  I3 => GND_0,
  CIN => VCC_0);
\fifo_inst/rcnt_sub_1_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(1),
  COUT => fifo_inst_rcnt_sub_1,
  I0 => \fifo_inst/Equal.wcount_r_d\(1),
  I1 => \fifo_inst/rbin_num\(1),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_0);
\fifo_inst/rcnt_sub_2_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(2),
  COUT => fifo_inst_rcnt_sub_2,
  I0 => \fifo_inst/Equal.wcount_r_d\(2),
  I1 => \fifo_inst/rbin_num\(2),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_1);
\fifo_inst/rcnt_sub_3_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(3),
  COUT => fifo_inst_rcnt_sub_3,
  I0 => \fifo_inst/Equal.wcount_r_d\(3),
  I1 => \fifo_inst/rbin_num\(3),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_2);
\fifo_inst/rcnt_sub_4_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(4),
  COUT => fifo_inst_rcnt_sub_4,
  I0 => \fifo_inst/Equal.wcount_r_d\(4),
  I1 => \fifo_inst/rbin_num\(4),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_3);
\fifo_inst/rcnt_sub_5_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(5),
  COUT => fifo_inst_rcnt_sub_5,
  I0 => \fifo_inst/Equal.wcount_r_d\(5),
  I1 => \fifo_inst/rbin_num\(5),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_4);
\fifo_inst/rcnt_sub_6_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(6),
  COUT => fifo_inst_rcnt_sub_6,
  I0 => \fifo_inst/Equal.wcount_r_d\(6),
  I1 => \fifo_inst/rbin_num\(6),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_5);
\fifo_inst/rcnt_sub_7_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(7),
  COUT => fifo_inst_rcnt_sub_7,
  I0 => \fifo_inst/Equal.wcount_r_d\(7),
  I1 => \fifo_inst/rbin_num\(7),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_6);
\fifo_inst/rcnt_sub_8_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(8),
  COUT => fifo_inst_rcnt_sub_8,
  I0 => \fifo_inst/Equal.wcount_r_d\(8),
  I1 => \fifo_inst/rbin_num\(8),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_7);
\fifo_inst/rcnt_sub_9_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(9),
  COUT => fifo_inst_rcnt_sub_9,
  I0 => \fifo_inst/Equal.wcount_r_d\(9),
  I1 => \fifo_inst/rbin_num\(9),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_8);
\fifo_inst/rcnt_sub_10_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(10),
  COUT => fifo_inst_rcnt_sub_10,
  I0 => fifo_inst_n214,
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_9);
\fifo_inst/n166_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n166,
  COUT => fifo_inst_n166_3,
  I0 => \fifo_inst/Equal.rgraynext\(0),
  I1 => \fifo_inst/Equal.rq2_wptr\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_inst/n167_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n167,
  COUT => fifo_inst_n167_3,
  I0 => \fifo_inst/Equal.rgraynext\(1),
  I1 => \fifo_inst/Equal.rq2_wptr\(1),
  I3 => GND_0,
  CIN => fifo_inst_n166_3);
\fifo_inst/n168_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n168,
  COUT => fifo_inst_n168_3,
  I0 => \fifo_inst/Equal.rgraynext\(2),
  I1 => \fifo_inst/Equal.rq2_wptr\(2),
  I3 => GND_0,
  CIN => fifo_inst_n167_3);
\fifo_inst/n169_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n169,
  COUT => fifo_inst_n169_3,
  I0 => \fifo_inst/Equal.rgraynext\(3),
  I1 => \fifo_inst/Equal.rq2_wptr\(3),
  I3 => GND_0,
  CIN => fifo_inst_n168_3);
\fifo_inst/n170_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n170,
  COUT => fifo_inst_n170_3,
  I0 => \fifo_inst/Equal.rgraynext\(4),
  I1 => \fifo_inst/Equal.rq2_wptr\(4),
  I3 => GND_0,
  CIN => fifo_inst_n169_3);
\fifo_inst/n171_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n171,
  COUT => fifo_inst_n171_3,
  I0 => \fifo_inst/Equal.rgraynext\(5),
  I1 => \fifo_inst/Equal.rq2_wptr\(5),
  I3 => GND_0,
  CIN => fifo_inst_n170_3);
\fifo_inst/n172_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n172,
  COUT => fifo_inst_n172_3,
  I0 => \fifo_inst/Equal.rgraynext\(6),
  I1 => \fifo_inst/Equal.rq2_wptr\(6),
  I3 => GND_0,
  CIN => fifo_inst_n171_3);
\fifo_inst/n173_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n173,
  COUT => fifo_inst_n173_3,
  I0 => \fifo_inst/Equal.rgraynext\(7),
  I1 => \fifo_inst/Equal.rq2_wptr\(7),
  I3 => GND_0,
  CIN => fifo_inst_n172_3);
\fifo_inst/n174_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n174,
  COUT => fifo_inst_n174_3,
  I0 => \fifo_inst/Equal.rgraynext\(8),
  I1 => \fifo_inst/Equal.rq2_wptr\(8),
  I3 => GND_0,
  CIN => fifo_inst_n173_3);
\fifo_inst/n175_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n175,
  COUT => fifo_inst_n175_3,
  I0 => \fifo_inst/Equal.rgraynext\(9),
  I1 => \fifo_inst/Equal.rq2_wptr\(9),
  I3 => GND_0,
  CIN => fifo_inst_n174_3);
\fifo_inst/n21_s1\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n21,
  I0 => NN_0,
  I1 => WrEn);
\fifo_inst/n27_s1\: LUT3
generic map (
  INIT => X"0E"
)
port map (
  F => fifo_inst_n27,
  I0 => RdEn,
  I1 => NN,
  I2 => fifo_inst_rempty_val);
\fifo_inst/Equal.rgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(2),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst/rbin_num\(3));
\fifo_inst/Equal.rgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(3),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/Equal.rgraynext_4_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(4),
  I0 => \fifo_inst/rbin_num\(4),
  I1 => \fifo_inst_Equal.rgraynext_4\,
  I2 => \fifo_inst/rbin_num\(5));
\fifo_inst/Equal.rgraynext_5_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(5),
  I0 => \fifo_inst/rbin_num\(4),
  I1 => \fifo_inst_Equal.rgraynext_4\,
  I2 => \fifo_inst/rbin_num\(5),
  I3 => \fifo_inst/rbin_num\(6));
\fifo_inst/Equal.rgraynext_7_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(7),
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst_Equal.rgraynext_6\,
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Equal.rgraynext_8_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(8),
  I0 => \fifo_inst_Equal.rgraynext_6\,
  I1 => \fifo_inst_Equal.rgraynext_8\,
  I2 => \fifo_inst/rbin_num\(8),
  I3 => \fifo_inst/rbin_num\(9));
\fifo_inst/Equal.rgraynext_9_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(9),
  I0 => \fifo_inst/rbin_num\(9),
  I1 => \fifo_inst_Equal.rgraynext_9\,
  I2 => \fifo_inst/rptr\(10));
\fifo_inst/Equal.wcount_r_9_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(9),
  I0 => \fifo_inst/Equal.rq2_wptr\(10),
  I1 => \fifo_inst/Equal.rq2_wptr\(9));
\fifo_inst/Equal.wcount_r_7_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(7),
  I0 => \fifo_inst/Equal.rq2_wptr\(10),
  I1 => \fifo_inst/Equal.rq2_wptr\(9),
  I2 => \fifo_inst/Equal.rq2_wptr\(8),
  I3 => \fifo_inst/Equal.rq2_wptr\(7));
\fifo_inst/Equal.wcount_r_6_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(6),
  I0 => \fifo_inst/Equal.rq2_wptr\(6),
  I1 => \fifo_inst/Equal.wcount_r\(7));
\fifo_inst/Equal.wcount_r_3_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(3),
  I0 => \fifo_inst/Equal.rq2_wptr\(6),
  I1 => \fifo_inst/Equal.rq2_wptr\(3),
  I2 => \fifo_inst/Equal.wcount_r\(7),
  I3 => \fifo_inst_Equal.wcount_r_4\);
\fifo_inst/Equal.wcount_r_2_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(2),
  I0 => \fifo_inst/Equal.rq2_wptr\(2),
  I1 => \fifo_inst/Equal.wcount_r\(3));
\fifo_inst/Equal.wcount_r_1_s0\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(1),
  I0 => \fifo_inst/Equal.rq2_wptr\(2),
  I1 => \fifo_inst/Equal.rq2_wptr\(1),
  I2 => \fifo_inst/Equal.wcount_r\(3));
\fifo_inst/Equal.wcount_r_0_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(0),
  I0 => \fifo_inst/Equal.rq2_wptr\(2),
  I1 => \fifo_inst/Equal.rq2_wptr\(1),
  I2 => \fifo_inst/Equal.rq2_wptr\(0),
  I3 => \fifo_inst/Equal.wcount_r\(3));
\fifo_inst/n214_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => fifo_inst_n214,
  I0 => \fifo_inst/Equal.wcount_r_d\(10),
  I1 => \fifo_inst/rptr\(10));
\fifo_inst/Equal.wgraynext_1_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(1),
  I0 => \fifo_inst/Equal.wbin\(0),
  I1 => fifo_inst_n21,
  I2 => \fifo_inst/Equal.wbin\(1),
  I3 => \fifo_inst/Equal.wbin\(2));
\fifo_inst/Equal.wgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(2),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst/Equal.wbin\(3));
\fifo_inst/Equal.wgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(3),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst/Equal.wbin\(3),
  I3 => \fifo_inst/Equal.wbin\(4));
\fifo_inst/Equal.wgraynext_4_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(4),
  I0 => \fifo_inst/Equal.wbin\(4),
  I1 => \fifo_inst_Equal.wgraynext_4\,
  I2 => \fifo_inst/Equal.wbin\(5));
\fifo_inst/Equal.wgraynext_5_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(5),
  I0 => \fifo_inst/Equal.wbin\(4),
  I1 => \fifo_inst_Equal.wgraynext_4\,
  I2 => \fifo_inst/Equal.wbin\(5),
  I3 => \fifo_inst/Equal.wbin\(6));
\fifo_inst/Equal.wgraynext_7_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(7),
  I0 => \fifo_inst/Equal.wbin\(6),
  I1 => \fifo_inst_Equal.wgraynext_6\,
  I2 => \fifo_inst/Equal.wbin\(7),
  I3 => \fifo_inst/Equal.wbin\(8));
\fifo_inst/Equal.wgraynext_8_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(8),
  I0 => \fifo_inst_Equal.wgraynext_6\,
  I1 => \fifo_inst_Equal.wgraynext_8\,
  I2 => \fifo_inst/Equal.wbin\(8),
  I3 => \fifo_inst/Equal.wbin\(9));
\fifo_inst/Equal.wgraynext_9_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(9),
  I0 => \fifo_inst/Equal.wbin\(9),
  I1 => \fifo_inst_Equal.wgraynext_9\,
  I2 => \fifo_inst/wptr\(10));
\fifo_inst/wfull_val_s0\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => fifo_inst_wfull_val,
  I0 => fifo_inst_wfull_val_4,
  I1 => fifo_inst_wfull_val_5,
  I2 => fifo_inst_wfull_val_6,
  I3 => fifo_inst_wfull_val_7);
\fifo_inst/rbin_num_next_2_s5\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(2),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_2\);
\fifo_inst/rbin_num_next_3_s5\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(3),
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst/rbin_num\(3));
\fifo_inst/rbin_num_next_5_s5\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(5),
  I0 => \fifo_inst/rbin_num\(4),
  I1 => \fifo_inst_Equal.rgraynext_4\,
  I2 => \fifo_inst/rbin_num\(5));
\fifo_inst/rbin_num_next_9_s5\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(9),
  I0 => \fifo_inst/rbin_num\(9),
  I1 => \fifo_inst_Equal.rgraynext_9\);
\fifo_inst/rbin_num_next_10_s2\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(10),
  I0 => \fifo_inst/rbin_num\(9),
  I1 => \fifo_inst_Equal.rgraynext_9\,
  I2 => \fifo_inst/rptr\(10));
\fifo_inst/Equal.wbinnext_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(2),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_2\);
\fifo_inst/Equal.wbinnext_3_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(3),
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst/Equal.wbin\(3));
\fifo_inst/Equal.wbinnext_5_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(5),
  I0 => \fifo_inst/Equal.wbin\(4),
  I1 => \fifo_inst_Equal.wgraynext_4\,
  I2 => \fifo_inst/Equal.wbin\(5));
\fifo_inst/Equal.wbinnext_9_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(9),
  I0 => \fifo_inst/Equal.wbin\(9),
  I1 => \fifo_inst_Equal.wgraynext_9\);
\fifo_inst/Equal.wbinnext_10_s2\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(10),
  I0 => \fifo_inst/Equal.wbin\(9),
  I1 => \fifo_inst_Equal.wgraynext_9\,
  I2 => \fifo_inst/wptr\(10));
\fifo_inst/n458_s35\: LUT4
generic map (
  INIT => X"004F"
)
port map (
  F => fifo_inst_n458,
  I0 => \fifo_inst/rcnt_sub_d\(0),
  I1 => fifo_inst_n462,
  I2 => \fifo_inst/rcnt_sub_d\(9),
  I3 => \fifo_inst/rcnt_sub_d\(10));
\fifo_inst/Equal.rgraynext_2_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Equal.rgraynext_2\,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/Equal.rgraynext_4_s1\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Equal.rgraynext_4\,
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst/rbin_num\(3),
  I2 => \fifo_inst_Equal.rgraynext_2\);
\fifo_inst/Equal.rgraynext_6_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.rgraynext_6\,
  I0 => \fifo_inst_Equal.rgraynext_2\,
  I1 => \fifo_inst_Equal.rgraynext_6_5\);
\fifo_inst/Equal.rgraynext_8_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.rgraynext_8\,
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst/rbin_num\(7));
\fifo_inst/Equal.rgraynext_9_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Equal.rgraynext_9\,
  I0 => \fifo_inst/rbin_num\(8),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst_Equal.rgraynext_6_5\,
  I3 => \fifo_inst_Equal.rgraynext_8\);
\fifo_inst/Equal.wcount_r_4_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst_Equal.wcount_r_4\,
  I0 => \fifo_inst/Equal.rq2_wptr\(5),
  I1 => \fifo_inst/Equal.rq2_wptr\(4));
\fifo_inst/Equal.wgraynext_2_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Equal.wgraynext_2\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Equal.wbin\(0),
  I3 => \fifo_inst/Equal.wbin\(1));
\fifo_inst/Equal.wgraynext_4_s1\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Equal.wgraynext_4\,
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst/Equal.wbin\(3),
  I2 => \fifo_inst_Equal.wgraynext_2\);
\fifo_inst/Equal.wgraynext_6_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.wgraynext_6\,
  I0 => \fifo_inst_Equal.wgraynext_2\,
  I1 => \fifo_inst_Equal.wgraynext_6_5\);
\fifo_inst/Equal.wgraynext_8_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Equal.wgraynext_8\,
  I0 => \fifo_inst/Equal.wbin\(6),
  I1 => \fifo_inst/Equal.wbin\(7));
\fifo_inst/Equal.wgraynext_9_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Equal.wgraynext_9\,
  I0 => \fifo_inst/Equal.wbin\(8),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst_Equal.wgraynext_6_5\,
  I3 => \fifo_inst_Equal.wgraynext_8\);
\fifo_inst/wfull_val_s1\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_4,
  I0 => \fifo_inst/wptr\(1),
  I1 => \fifo_inst/rptr\(1),
  I2 => \fifo_inst/wptr\(4),
  I3 => \fifo_inst/rptr\(4));
\fifo_inst/wfull_val_s2\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_5,
  I0 => \fifo_inst/wptr\(7),
  I1 => \fifo_inst/rptr\(7),
  I2 => \fifo_inst/wptr\(8),
  I3 => \fifo_inst/rptr\(8));
\fifo_inst/wfull_val_s3\: LUT4
generic map (
  INIT => X"9000"
)
port map (
  F => fifo_inst_wfull_val_6,
  I0 => \fifo_inst/wptr\(0),
  I1 => \fifo_inst/rptr\(0),
  I2 => fifo_inst_wfull_val_8,
  I3 => fifo_inst_wfull_val_9);
\fifo_inst/wfull_val_s4\: LUT4
generic map (
  INIT => X"1428"
)
port map (
  F => fifo_inst_wfull_val_7,
  I0 => \fifo_inst/rptr\(10),
  I1 => \fifo_inst/wptr\(9),
  I2 => \fifo_inst/rptr\(9),
  I3 => \fifo_inst/wptr\(10));
\fifo_inst/n462_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => fifo_inst_n462,
  I0 => fifo_inst_n462_6,
  I1 => fifo_inst_n462_7);
\fifo_inst/n462_s2\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => fifo_inst_n462_5,
  I0 => \fifo_inst/rcnt_sub_d\(10),
  I1 => \fifo_inst/rcnt_sub_d\(0),
  I2 => \fifo_inst/rcnt_sub_d\(9),
  I3 => RdEn);
\fifo_inst/Equal.rgraynext_6_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Equal.rgraynext_6_5\,
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst/rbin_num\(3),
  I2 => \fifo_inst/rbin_num\(4),
  I3 => \fifo_inst/rbin_num\(5));
\fifo_inst/Equal.wgraynext_6_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Equal.wgraynext_6_5\,
  I0 => \fifo_inst/Equal.wbin\(2),
  I1 => \fifo_inst/Equal.wbin\(3),
  I2 => \fifo_inst/Equal.wbin\(4),
  I3 => \fifo_inst/Equal.wbin\(5));
\fifo_inst/wfull_val_s5\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_8,
  I0 => \fifo_inst/wptr\(5),
  I1 => \fifo_inst/rptr\(5),
  I2 => \fifo_inst/wptr\(6),
  I3 => \fifo_inst/rptr\(6));
\fifo_inst/wfull_val_s6\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_9,
  I0 => \fifo_inst/wptr\(2),
  I1 => \fifo_inst/rptr\(2),
  I2 => \fifo_inst/wptr\(3),
  I3 => \fifo_inst/rptr\(3));
\fifo_inst/n462_s3\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => fifo_inst_n462_6,
  I0 => \fifo_inst/rcnt_sub_d\(5),
  I1 => \fifo_inst/rcnt_sub_d\(6),
  I2 => \fifo_inst/rcnt_sub_d\(7),
  I3 => \fifo_inst/rcnt_sub_d\(8));
\fifo_inst/n462_s4\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => fifo_inst_n462_7,
  I0 => \fifo_inst/rcnt_sub_d\(1),
  I1 => \fifo_inst/rcnt_sub_d\(2),
  I2 => \fifo_inst/rcnt_sub_d\(3),
  I3 => \fifo_inst/rcnt_sub_d\(4));
\fifo_inst/Equal.wcount_r_8_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(8),
  I0 => \fifo_inst/Equal.rq2_wptr\(8),
  I1 => \fifo_inst/Equal.rq2_wptr\(10),
  I2 => \fifo_inst/Equal.rq2_wptr\(9));
\fifo_inst/n462_s5\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_inst_n462_9,
  I0 => fifo_inst_n462_6,
  I1 => fifo_inst_n462_7,
  I2 => fifo_inst_n462_5);
\fifo_inst/rbin_num_next_1_s6\: LUT4
generic map (
  INIT => X"DF20"
)
port map (
  F => \fifo_inst/rbin_num_next\(1),
  I0 => \fifo_inst/rbin_num\(0),
  I1 => NN,
  I2 => RdEn,
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_0_s7\: LUT3
generic map (
  INIT => X"9A"
)
port map (
  F => \fifo_inst/rbin_num_next\(0),
  I0 => \fifo_inst/rbin_num\(0),
  I1 => NN,
  I2 => RdEn);
\fifo_inst/rbin_num_next_8_s6\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(8),
  I0 => \fifo_inst_Equal.rgraynext_6\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Equal.wcount_r_4_s3\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(4),
  I0 => \fifo_inst/Equal.rq2_wptr\(6),
  I1 => \fifo_inst/Equal.wcount_r\(7),
  I2 => \fifo_inst/Equal.rq2_wptr\(5),
  I3 => \fifo_inst/Equal.rq2_wptr\(4));
\fifo_inst/Equal.wcount_r_5_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Equal.wcount_r\(5),
  I0 => \fifo_inst/Equal.rq2_wptr\(5),
  I1 => \fifo_inst/Equal.rq2_wptr\(6),
  I2 => \fifo_inst/Equal.wcount_r\(7));
\fifo_inst/Equal.wbinnext_8_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(8),
  I0 => \fifo_inst_Equal.wgraynext_6\,
  I1 => \fifo_inst/Equal.wbin\(6),
  I2 => \fifo_inst/Equal.wbin\(7),
  I3 => \fifo_inst/Equal.wbin\(8));
\fifo_inst/Equal.rgraynext_1_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(1),
  I0 => \fifo_inst/rbin_num_next\(1),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst_Equal.rgraynext_2\);
\fifo_inst/rbin_num_next_4_s6\: LUT4
generic map (
  INIT => X"6AAA"
)
port map (
  F => \fifo_inst/rbin_num_next\(4),
  I0 => \fifo_inst/rbin_num\(4),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst_Equal.rgraynext_2\);
\fifo_inst/Equal.wbinnext_4_s4\: LUT4
generic map (
  INIT => X"6AAA"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(4),
  I0 => \fifo_inst/Equal.wbin\(4),
  I1 => \fifo_inst/Equal.wbin\(2),
  I2 => \fifo_inst/Equal.wbin\(3),
  I3 => \fifo_inst_Equal.wgraynext_2\);
\fifo_inst/rbin_num_next_7_s6\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(7),
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst_Equal.rgraynext_6_5\,
  I3 => \fifo_inst/rbin_num\(7));
\fifo_inst/rbin_num_next_6_s6\: LUT3
generic map (
  INIT => X"6A"
)
port map (
  F => \fifo_inst/rbin_num_next\(6),
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst_Equal.rgraynext_6_5\);
\fifo_inst/Equal.rgraynext_6_s3\: LUT4
generic map (
  INIT => X"15EA"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(6),
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst_Equal.rgraynext_2\,
  I2 => \fifo_inst_Equal.rgraynext_6_5\,
  I3 => \fifo_inst/rbin_num\(7));
\fifo_inst/Equal.wbinnext_7_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(7),
  I0 => \fifo_inst/Equal.wbin\(6),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst_Equal.wgraynext_6_5\,
  I3 => \fifo_inst/Equal.wbin\(7));
\fifo_inst/Equal.wbinnext_6_s4\: LUT3
generic map (
  INIT => X"6A"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(6),
  I0 => \fifo_inst/Equal.wbin\(6),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst_Equal.wgraynext_6_5\);
\fifo_inst/Equal.wgraynext_6_s3\: LUT4
generic map (
  INIT => X"15EA"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(6),
  I0 => \fifo_inst/Equal.wbin\(6),
  I1 => \fifo_inst_Equal.wgraynext_2\,
  I2 => \fifo_inst_Equal.wgraynext_6_5\,
  I3 => \fifo_inst/Equal.wbin\(7));
\fifo_inst/Equal.wbinnext_1_s4\: LUT4
generic map (
  INIT => X"DF20"
)
port map (
  F => \fifo_inst/Equal.wbinnext\(1),
  I0 => \fifo_inst/Equal.wbin\(0),
  I1 => NN_0,
  I2 => WrEn,
  I3 => \fifo_inst/Equal.wbin\(1));
\fifo_inst/Equal.wbinnext_0_s4\: LUT3
generic map (
  INIT => X"9A"
)
port map (
  F => \fifo_inst_Equal.wbinnext_0\,
  I0 => \fifo_inst/Equal.wbin\(0),
  I1 => NN_0,
  I2 => WrEn);
\fifo_inst/Equal.wgraynext_0_s1\: LUT4
generic map (
  INIT => X"45BA"
)
port map (
  F => \fifo_inst/Equal.wgraynext\(0),
  I0 => \fifo_inst/Equal.wbin\(0),
  I1 => NN_0,
  I2 => WrEn,
  I3 => \fifo_inst/Equal.wbin\(1));
\fifo_inst/rempty_val_s2\: LUT3
generic map (
  INIT => X"09"
)
port map (
  F => fifo_inst_rempty_val,
  I0 => \fifo_inst/rbin_num_next\(10),
  I1 => \fifo_inst/Equal.rq2_wptr\(10),
  I2 => fifo_inst_n175_3);
\fifo_inst/Equal.rgraynext_0_s1\: LUT4
generic map (
  INIT => X"6966"
)
port map (
  F => \fifo_inst/Equal.rgraynext\(0),
  I0 => \fifo_inst/rbin_num_next\(1),
  I1 => \fifo_inst/rbin_num\(0),
  I2 => NN,
  I3 => RdEn);
\fifo_inst/Equal.rq1_wptr_0_s14\: INV
port map (
  O => \fifo_inst_Equal.rq1_wptr_0_19\,
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
