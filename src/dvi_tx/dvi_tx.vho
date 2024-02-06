--
--Written by GowinSynthesis
--Tool Version "V1.9.9"
--Mon Feb  5 12:34:05 2024

--Source file index table:
--file0 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/DVI_TX/data/dvi_tx_top.v"
--file1 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/DVI_TX/data/rgb2dvi.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw2a;
use gw2a.components.all;

entity DVI_TX_Top is
port(
  I_rst_n :  in std_logic;
  I_serial_clk :  in std_logic;
  I_rgb_clk :  in std_logic;
  I_rgb_vs :  in std_logic;
  I_rgb_hs :  in std_logic;
  I_rgb_de :  in std_logic;
  I_rgb_r :  in std_logic_vector(7 downto 0);
  I_rgb_g :  in std_logic_vector(7 downto 0);
  I_rgb_b :  in std_logic_vector(7 downto 0);
  O_tmds_clk_p :  out std_logic;
  O_tmds_clk_n :  out std_logic;
  O_tmds_data_p :  out std_logic_vector(2 downto 0);
  O_tmds_data_n :  out std_logic_vector(2 downto 0));
end DVI_TX_Top;
architecture beh of DVI_TX_Top is
  signal rgb2dvi_inst_sdataout_r : std_logic ;
  signal rgb2dvi_inst_sdataout_g : std_logic ;
  signal rgb2dvi_inst_sdataout_b : std_logic ;
  signal rgb2dvi_inst_sdataout_clk : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_de_d : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_c1_d : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_c1_d : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_c0_d : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n135 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n135_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n134 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n134_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n133 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n133_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n132 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n132_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n560 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n560_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n559 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n559_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n558 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n558_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n561 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n561_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n560_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n560_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n559_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n559_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n558_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n558_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n135 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n135_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n134 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n134_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n133 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n133_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n132 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n132_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n560 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n560_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n559 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n559_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n558 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n558_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n561 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n561_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n560_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n560_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n559_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n559_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n135 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n135_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n134 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n134_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n133 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n133_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n132 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n132_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n560 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n560_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n559 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n559_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n558 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n558_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n561 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n561_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n560_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n560_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n559_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n559_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n366 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n366_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n365 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n365_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n364 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n364_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n366 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n366_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n365 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n365_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n364 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n364_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n366 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n366_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n365 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n365_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n364 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n364_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n561_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n561_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n561_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n561_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n561_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n561_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n239 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n239_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n238 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n238_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n237 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n237_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n236 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n236_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n367 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n367_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n367_16 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n367_15 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n366_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n366_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n365_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n365_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n239 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n239_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n238 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n238_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n237 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n237_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n236 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n236_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n367 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n367_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n367_16 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n367_15 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n366_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n366_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n365_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n365_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n364_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n364_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n239 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n239_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n238 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n238_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n237 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n237_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n236 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n236_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n367 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n367_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n367_16 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n367_15 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n366_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n366_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n365_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n365_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n364_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n364_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n274 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n596 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n274 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n596 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n274 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n596 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n679 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n679 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n679 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n630 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n653 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n681 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n682 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n683 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n684 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n685 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n686 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n687 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n688 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n689 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n653 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n681 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n682 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n683 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n684 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n685 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n686 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n687 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n688 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n689 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n630 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n653 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n680 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n681 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n682 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n683 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n684 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n685 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n686 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n687 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n688 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n689 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n605 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n604 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n603 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n605 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n604 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n603 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n605 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n604 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n603 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n403 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n402 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n403 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n402 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n403 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n402 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n401 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n630_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n630_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n653_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n682_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n682_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n683_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n683_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n684_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n688_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n682_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n682_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n683_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n683_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n684_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n688_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n630_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n630_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n680_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n682_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n682_5 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n686_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n688_4 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_24 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_22 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n605_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n605_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n604_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n604_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n603_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n603_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n605_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n605_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n604_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n604_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n603_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n603_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n605_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n605_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n604_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n604_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n603_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n603_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n630_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n683_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n683_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n685_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n683_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n683_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n685_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_10 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n683_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n685_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_26 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_27 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_23 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_24 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3_16 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_24 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_24 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n604_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n604_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n604_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_13 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n630_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n630_9 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_12 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_26 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_26 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n114_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n603_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n114_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n603_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n685_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n114_15 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n603_11 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n685_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n630_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_28 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n401 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n401 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n685_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n687_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n684_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n683_8 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n686_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n686_6 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n687_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n680 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n687_7 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n680 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n606 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n606 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n606 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n647 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n670 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n647 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n670 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n647 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n670 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n603_14 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n603_13 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n603_13 : std_logic ;
  signal rgb2dvi_inst_n36 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_b_n404 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_g_n404 : std_logic ;
  signal rgb2dvi_inst_TMDS8b10b_inst_r_n404 : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\ : std_logic_vector(7 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\ : std_logic_vector(4 downto 1);
  signal \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\ : std_logic_vector(9 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\ : std_logic_vector(7 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\ : std_logic_vector(4 downto 1);
  signal \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\ : std_logic_vector(9 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\ : std_logic_vector(7 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\ : std_logic_vector(4 downto 1);
  signal \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\ : std_logic_vector(9 downto 0);
  signal \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\ : std_logic_vector(3 downto 1);
  signal \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\ : std_logic_vector(3 downto 1);
  signal \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\ : std_logic_vector(3 downto 1);
begin
\rgb2dvi_inst/u_LVDS_r\: TLVDS_OBUF
port map (
  O => O_tmds_data_p(2),
  OB => O_tmds_data_n(2),
  I => rgb2dvi_inst_sdataout_r);
\rgb2dvi_inst/u_LVDS_g\: TLVDS_OBUF
port map (
  O => O_tmds_data_p(1),
  OB => O_tmds_data_n(1),
  I => rgb2dvi_inst_sdataout_g);
\rgb2dvi_inst/u_LVDS_b\: TLVDS_OBUF
port map (
  O => O_tmds_data_p(0),
  OB => O_tmds_data_n(0),
  I => rgb2dvi_inst_sdataout_b);
\rgb2dvi_inst/u_LVDS_clk\: TLVDS_OBUF
port map (
  O => O_tmds_clk_p,
  OB => O_tmds_clk_n,
  I => rgb2dvi_inst_sdataout_clk);
\rgb2dvi_inst/u_OSER10_r\: OSER10
port map (
  Q => rgb2dvi_inst_sdataout_r,
  D0 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(0),
  D1 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(1),
  D2 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(2),
  D3 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(3),
  D4 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(4),
  D5 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(5),
  D6 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(6),
  D7 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(7),
  D8 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(8),
  D9 => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(9),
  PCLK => I_rgb_clk,
  FCLK => I_serial_clk,
  RESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/u_OSER10_g\: OSER10
port map (
  Q => rgb2dvi_inst_sdataout_g,
  D0 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(0),
  D1 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(1),
  D2 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(2),
  D3 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(3),
  D4 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(4),
  D5 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(5),
  D6 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(6),
  D7 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(7),
  D8 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(8),
  D9 => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(9),
  PCLK => I_rgb_clk,
  FCLK => I_serial_clk,
  RESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/u_OSER10_b\: OSER10
port map (
  Q => rgb2dvi_inst_sdataout_b,
  D0 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(0),
  D1 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(1),
  D2 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(2),
  D3 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(3),
  D4 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(4),
  D5 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(5),
  D6 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(6),
  D7 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(7),
  D8 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(8),
  D9 => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(9),
  PCLK => I_rgb_clk,
  FCLK => I_serial_clk,
  RESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/u_OSER10_clk\: OSER10
port map (
  Q => rgb2dvi_inst_sdataout_clk,
  D0 => GND_0,
  D1 => GND_0,
  D2 => GND_0,
  D3 => GND_0,
  D4 => GND_0,
  D5 => VCC_0,
  D6 => VCC_0,
  D7 => VCC_0,
  D8 => VCC_0,
  D9 => VCC_0,
  PCLK => I_rgb_clk,
  FCLK => I_serial_clk,
  RESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(6),
  D => I_rgb_r(6),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(5),
  D => I_rgb_r(5),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(4),
  D => I_rgb_r(4),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  D => I_rgb_r(3),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2),
  D => I_rgb_r(2),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  D => I_rgb_r(1),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  D => I_rgb_r(0),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/de_d_s0\: DFFC
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  D => I_rgb_de,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/c1_d_s0\: DFFP
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  D => GND_0,
  CLK => I_rgb_clk,
  PRESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/sel_xnor_s0\: DFFC
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n114,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n603,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n604,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n605,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n606,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_9_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(9),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n680,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_8_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(8),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n681,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(7),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n682,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(6),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n683,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(5),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n684,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n685,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n686,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n687,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n688,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/dout_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/q_out_r\(0),
  D => rgb2dvi_inst_TMDS8b10b_inst_r_n689,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/din_d_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(7),
  D => I_rgb_r(7),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(6),
  D => I_rgb_g(6),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(5),
  D => I_rgb_g(5),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(4),
  D => I_rgb_g(4),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  D => I_rgb_g(3),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2),
  D => I_rgb_g(2),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  D => I_rgb_g(1),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  D => I_rgb_g(0),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/sel_xnor_s0\: DFFC
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n114,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n603,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n604,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n605,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n606,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_9_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(9),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n680,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_8_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(8),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n681,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(7),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n682,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(6),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n683,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(5),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n684,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n685,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n686,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n687,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n688,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/dout_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/q_out_g\(0),
  D => rgb2dvi_inst_TMDS8b10b_inst_g_n689,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_g/din_d_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(7),
  D => I_rgb_g(7),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(6),
  D => I_rgb_b(6),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(5),
  D => I_rgb_b(5),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(4),
  D => I_rgb_b(4),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  D => I_rgb_b(3),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  D => I_rgb_b(2),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  D => I_rgb_b(1),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  D => I_rgb_b(0),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/c1_d_s0\: DFFP
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_b_c1_d,
  D => I_rgb_vs,
  CLK => I_rgb_clk,
  PRESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/sel_xnor_s0\: DFFC
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n114,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n603,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n604,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n605,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n606,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_9_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(9),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n680,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_8_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(8),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n681,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(7),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n682,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_6_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(6),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n683,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_5_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(5),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n684,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_4_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(4),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n685,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_3_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(3),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n686,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_2_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(2),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n687,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_1_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(1),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n688,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/dout_0_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/q_out_b\(0),
  D => rgb2dvi_inst_TMDS8b10b_inst_b_n689,
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/din_d_7_s0\: DFFC
port map (
  Q => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(7),
  D => I_rgb_b(7),
  CLK => I_rgb_clk,
  CLEAR => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_b/c0_d_s0\: DFFP
port map (
  Q => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  D => I_rgb_hs,
  CLK => I_rgb_clk,
  PRESET => rgb2dvi_inst_n36);
\rgb2dvi_inst/TMDS8b10b_inst_r/n135_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n135,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n135_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n134_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n134,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n134_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n135_3);
\rgb2dvi_inst/TMDS8b10b_inst_r/n133_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n133,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n133_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n134_3);
\rgb2dvi_inst/TMDS8b10b_inst_r/n132_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n132,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n132_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n133_3);
\rgb2dvi_inst/TMDS8b10b_inst_r/n560_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n560,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n560_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n403,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n561_8);
\rgb2dvi_inst/TMDS8b10b_inst_r/n559_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n559,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n559_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n402,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n560_3);
\rgb2dvi_inst/TMDS8b10b_inst_r/n558_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n558,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n558_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n401,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n559_3);
\rgb2dvi_inst/TMDS8b10b_inst_r/n561_s1\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n561,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n561_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n561_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n560_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n560_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n560_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n560,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n561_6);
\rgb2dvi_inst/TMDS8b10b_inst_r/n559_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n559_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n559_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n559,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n560_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/n558_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n558_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n558_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n558,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n559_5);
\rgb2dvi_inst/TMDS8b10b_inst_g/n135_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n135,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n135_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n134_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n134,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n134_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n135_3);
\rgb2dvi_inst/TMDS8b10b_inst_g/n133_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n133,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n133_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n134_3);
\rgb2dvi_inst/TMDS8b10b_inst_g/n132_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n132,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n132_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n133_3);
\rgb2dvi_inst/TMDS8b10b_inst_g/n560_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n560,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n560_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n403,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n561_8);
\rgb2dvi_inst/TMDS8b10b_inst_g/n559_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n559,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n559_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n402,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n560_3);
\rgb2dvi_inst/TMDS8b10b_inst_g/n558_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n558,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n558_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n401,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n559_3);
\rgb2dvi_inst/TMDS8b10b_inst_g/n561_s1\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n561,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n561_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n561_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n560_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n560_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n560_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n560,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n561_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/n559_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n559_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n559_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n559,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n560_5);
\rgb2dvi_inst/TMDS8b10b_inst_b/n135_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n135,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n135_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n134_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n134,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n134_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n135_3);
\rgb2dvi_inst/TMDS8b10b_inst_b/n133_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n133,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n133_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n134_3);
\rgb2dvi_inst/TMDS8b10b_inst_b/n132_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n132,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n132_3,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n133_3);
\rgb2dvi_inst/TMDS8b10b_inst_b/n560_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n560,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n560_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n403,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n561_8);
\rgb2dvi_inst/TMDS8b10b_inst_b/n559_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n559,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n559_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n402,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n560_3);
\rgb2dvi_inst/TMDS8b10b_inst_b/n558_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n558,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n558_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n401,
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n559_3);
\rgb2dvi_inst/TMDS8b10b_inst_b/n561_s1\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n561,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n561_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n561_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n560_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n560_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n560_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n560,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n561_6);
\rgb2dvi_inst/TMDS8b10b_inst_b/n559_s0\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n559_4,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n559_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n559,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n560_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/n366_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n366,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n366_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n367_12);
\rgb2dvi_inst/TMDS8b10b_inst_r/n365_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n365,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n365_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n366_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n364_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n364,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n364_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n365_4);
\rgb2dvi_inst/TMDS8b10b_inst_g/n366_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n366,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n366_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n367_12);
\rgb2dvi_inst/TMDS8b10b_inst_g/n365_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n365,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n365_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n366_4);
\rgb2dvi_inst/TMDS8b10b_inst_g/n364_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n364,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n364_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n365_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n366_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n366,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n366_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n367_12);
\rgb2dvi_inst/TMDS8b10b_inst_b/n365_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n365,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n365_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n366_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n364_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n364,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n364_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4),
  I1 => GND_0,
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n365_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n561_s2\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n561_9,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n561_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n404,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n561_s2\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n561_9,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n561_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n404,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n561_s2\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n561_9,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n561_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n404,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n239_s6\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n239,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n239_14,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n238_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n238,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n238_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n239_14);
\rgb2dvi_inst/TMDS8b10b_inst_r/n237_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n237,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n237_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n238_12);
\rgb2dvi_inst/TMDS8b10b_inst_r/n236_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n236,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n236_10,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n237_12);
\rgb2dvi_inst/TMDS8b10b_inst_r/n367_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n367,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n367_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n367_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n367_16,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n367_15,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n367,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => VCC_0);
\rgb2dvi_inst/TMDS8b10b_inst_r/n366_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n366_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n366_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n366,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n367_15);
\rgb2dvi_inst/TMDS8b10b_inst_r/n365_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_r_n365_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_r_n365_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n365,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_r_n366_11);
\rgb2dvi_inst/TMDS8b10b_inst_g/n239_s6\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n239,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n239_14,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n238_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n238,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n238_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n239_14);
\rgb2dvi_inst/TMDS8b10b_inst_g/n237_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n237,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n237_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n238_12);
\rgb2dvi_inst/TMDS8b10b_inst_g/n236_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n236,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n236_10,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n237_12);
\rgb2dvi_inst/TMDS8b10b_inst_g/n367_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n367,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n367_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n367_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n367_16,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n367_15,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n367,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I3 => GND_0,
  CIN => VCC_0);
\rgb2dvi_inst/TMDS8b10b_inst_g/n366_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n366_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n366_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n366,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n367_15);
\rgb2dvi_inst/TMDS8b10b_inst_g/n365_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n365_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n365_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n365,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n366_11);
\rgb2dvi_inst/TMDS8b10b_inst_g/n364_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_g_n364_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_g_n364_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n364,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_g_n365_11);
\rgb2dvi_inst/TMDS8b10b_inst_b/n239_s6\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n239,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n239_14,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n238_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n238,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n238_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n239_14);
\rgb2dvi_inst/TMDS8b10b_inst_b/n237_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n237,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n237_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n238_12);
\rgb2dvi_inst/TMDS8b10b_inst_b/n236_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n236,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n236_10,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n237_12);
\rgb2dvi_inst/TMDS8b10b_inst_b/n367_s4\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n367,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n367_12,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I3 => GND_0,
  CIN => GND_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n367_s5\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n367_16,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n367_15,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n367,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23,
  I3 => GND_0,
  CIN => VCC_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n366_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n366_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n366_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n366,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(1),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n367_15);
\rgb2dvi_inst/TMDS8b10b_inst_b/n365_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n365_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n365_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n365,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n366_11);
\rgb2dvi_inst/TMDS8b10b_inst_b/n364_s3\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => rgb2dvi_inst_TMDS8b10b_inst_b_n364_12,
  COUT => rgb2dvi_inst_TMDS8b10b_inst_b_n364_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n364,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(3),
  I3 => GND_0,
  CIN => rgb2dvi_inst_TMDS8b10b_inst_b_n365_11);
\rgb2dvi_inst/TMDS8b10b_inst_r/n274_s0\: LUT3
generic map (
  INIT => X"3A"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n274,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n135,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n239,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n596_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n596,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n561,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n367_16,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n274_s0\: LUT3
generic map (
  INIT => X"3A"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n274,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n135,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n239,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n596_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n596,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n561,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n367_16,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n274_s0\: LUT3
generic map (
  INIT => X"3A"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n274,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n135,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n239,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_b/n596_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n596,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n561,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n367_16,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n679_s0\: MUX2_LUT5
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_r_n679,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n670,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n647,
  S0 => rgb2dvi_inst_TMDS8b10b_inst_r_n630);
\rgb2dvi_inst/TMDS8b10b_inst_g/n679_s0\: MUX2_LUT5
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_g_n679,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n670,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n647,
  S0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630);
\rgb2dvi_inst/TMDS8b10b_inst_b/n679_s0\: MUX2_LUT5
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_b_n679,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n670,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n647,
  S0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s0\: LUT4
generic map (
  INIT => X"FD80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114,
  I0 => I_rgb_r(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_5,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_7);
\rgb2dvi_inst/TMDS8b10b_inst_r/n630_s0\: LUT4
generic map (
  INIT => X"8F88"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_4,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/n653_s0\: LUT4
generic map (
  INIT => X"F001"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n653,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_4,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_5,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n653_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n681_s1\: LUT3
generic map (
  INIT => X"35"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n681,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n682_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n682,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n682_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n682_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n683_s1\: LUT4
generic map (
  INIT => X"C355"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n683,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_5,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n684_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n684,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n684_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n685_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n685,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n685_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n686_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n686,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n686_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n687_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n687,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n687_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n688_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n688,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n682_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n689_s0\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n689,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n679,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s0\: LUT4
generic map (
  INIT => X"FD80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114,
  I0 => I_rgb_g(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s0\: LUT4
generic map (
  INIT => X"1F11"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_4,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_5,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/n653_s0\: LUT4
generic map (
  INIT => X"F004"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n653,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_5,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_4,
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n681_s1\: LUT3
generic map (
  INIT => X"53"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n681,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n682_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n682,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n682_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n682_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n683_s1\: LUT4
generic map (
  INIT => X"C355"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n683,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_5,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n684_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n684,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n684_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n685_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n685,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n685_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n686_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n686,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n686_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n687_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n687,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n687_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n688_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n688,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n682_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n689_s0\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n689,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n679,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_c1_d,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s0\: LUT4
generic map (
  INIT => X"FD80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114,
  I0 => I_rgb_b(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_6);
\rgb2dvi_inst/TMDS8b10b_inst_b/n630_s0\: LUT3
generic map (
  INIT => X"F4"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630_4,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n630_5);
\rgb2dvi_inst/TMDS8b10b_inst_b/n653_s0\: LUT4
generic map (
  INIT => X"0530"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n653,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630_5,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n630_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n680_s0\: LUT4
generic map (
  INIT => X"55C3"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n680,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_c1_d,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n681_s1\: LUT3
generic map (
  INIT => X"35"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n681,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n682_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n682,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n682_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n682_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n683_s1\: LUT4
generic map (
  INIT => X"C355"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n683,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n684_s0\: LUT4
generic map (
  INIT => X"C3AA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n684,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n684_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n685_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n685,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n685_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n686_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n686,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n686_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n687_s1\: LUT4
generic map (
  INIT => X"3C55"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n687,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n687_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n688_s0\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n688,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n682_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n689_s0\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n689,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_c0_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n679,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_0_s13\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(5),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(7));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s15\: LUT4
generic map (
  INIT => X"D46F"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(2),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_24,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_25);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_0_s13\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(5),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(7));
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_3_s11\: LUT3
generic map (
  INIT => X"02"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(3),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s14\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(1),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_22,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_28);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_2_s15\: LUT4
generic map (
  INIT => X"71BE"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(2),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_28,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_22,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_3_s11\: LUT3
generic map (
  INIT => X"04"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(3),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_28);
\rgb2dvi_inst/TMDS8b10b_inst_b/n605_s1\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n605,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n605_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n605_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n604_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n604,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n604_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n604_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_b/n603_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n603,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n603_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n603_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n605_s1\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n605,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n605_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n605_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n604_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n604,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n604_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n604_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_g/n603_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n603,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n603_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n603_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n605_s1\: LUT4
generic map (
  INIT => X"CA00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n605,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n605_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n605_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n604_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n604,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n604_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n604_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n603_s1\: LUT4
generic map (
  INIT => X"3A00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n603,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n603_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n603_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d);
\rgb2dvi_inst/TMDS8b10b_inst_r/n403_s4\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n403,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2));
\rgb2dvi_inst/TMDS8b10b_inst_r/n402_s4\: LUT3
generic map (
  INIT => X"E1"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n402,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_g/n403_s4\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n403,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2));
\rgb2dvi_inst/TMDS8b10b_inst_g/n402_s4\: LUT3
generic map (
  INIT => X"E1"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n402,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_b/n403_s4\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n403,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2));
\rgb2dvi_inst/TMDS8b10b_inst_b/n402_s4\: LUT3
generic map (
  INIT => X"E1"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n402,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_b/n401_s3\: LUT4
generic map (
  INIT => X"FE01"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n401,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s1\: LUT3
generic map (
  INIT => X"7E"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_5,
  I0 => I_rgb_r(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_15,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_9);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s2\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_6,
  I0 => I_rgb_r(1),
  I1 => I_rgb_r(2),
  I2 => I_rgb_r(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s3\: LUT4
generic map (
  INIT => X"D4FD"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_10,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_11,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_12,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/n630_s1\: LUT4
generic map (
  INIT => X"0310"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n630_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_6,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1);
\rgb2dvi_inst/TMDS8b10b_inst_r/n630_s2\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n630_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_r/n653_s1\: LUT4
generic map (
  INIT => X"2B00"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n653_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_24,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_25);
\rgb2dvi_inst/TMDS8b10b_inst_r/n682_s1\: LUT3
generic map (
  INIT => X"14"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n682_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n682_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n682_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/n683_s2\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n683_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(6),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n688_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n683_s3\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n683_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n684_s1\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n684_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n688_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n688_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n688_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s1\: LUT3
generic map (
  INIT => X"7E"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_4,
  I0 => I_rgb_g(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_14,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_8);
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s2\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_5,
  I0 => I_rgb_g(1),
  I1 => I_rgb_g(2),
  I2 => I_rgb_g(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s3\: LUT4
generic map (
  INIT => X"D4FD"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_10,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_11,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_4);
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s1\: LUT4
generic map (
  INIT => X"C050"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s2\: LUT4
generic map (
  INIT => X"FC5F"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_5,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s3\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_g/n682_s1\: LUT3
generic map (
  INIT => X"14"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n682_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n682_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n682_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_5);
\rgb2dvi_inst/TMDS8b10b_inst_g/n683_s2\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n683_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(6),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_g/n683_s3\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n683_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n684_s1\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n684_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_g/n688_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s1\: LUT3
generic map (
  INIT => X"7E"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_4,
  I0 => I_rgb_b(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_14,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_8);
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s2\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_5,
  I0 => I_rgb_b(1),
  I1 => I_rgb_b(2),
  I2 => I_rgb_b(4));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s3\: LUT4
generic map (
  INIT => X"D4FD"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_10,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_11,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n630_s1\: LUT4
generic map (
  INIT => X"32A3"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n630_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630_8,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_b/n630_s2\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n630_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(4));
\rgb2dvi_inst/TMDS8b10b_inst_b/n680_s1\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n680_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n682_s1\: LUT3
generic map (
  INIT => X"14"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n682_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n630,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n682_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n682_5,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(7),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_b/n686_s1\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n686_4,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n688_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n688_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n688_4,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s15\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s16\: LUT4
generic map (
  INIT => X"4114"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_0,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(7),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_5);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s16\: LUT4
generic map (
  INIT => X"5CC5"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_26,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_27);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s17\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_24,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s18\: LUT3
generic map (
  INIT => X"0D"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_25,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s15\: LUT4
generic map (
  INIT => X"4114"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_0,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(7),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_5);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s16\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_7,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_23,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_24);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_3_s12\: LUT3
generic map (
  INIT => X"35"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_24,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3_16,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_23);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s15\: LUT4
generic map (
  INIT => X"1EE1"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_24,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_25);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s16\: LUT4
generic map (
  INIT => X"C355"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_22,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n685_6,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_2_s16\: LUT4
generic map (
  INIT => X"7717"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_24,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_24,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0);
\rgb2dvi_inst/TMDS8b10b_inst_b/n605_s2\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n605_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n366_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n560_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n605_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n605_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n134,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_b/n604_s2\: LUT3
generic map (
  INIT => X"53"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n604_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n365_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n559_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n604_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n604_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n133,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n237,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n604_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_b/n603_s2\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n603_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n603_13,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n364_12,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n365_12,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n603_s3\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n603_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n603_11,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n133,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n132,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n605_s2\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n605_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n366_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n560_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n605_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n605_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n134,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n604_s2\: LUT3
generic map (
  INIT => X"53"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n604_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n365_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n559_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n604_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n604_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n133,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n237,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n604_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n603_s2\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n603_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n603_14,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n364_12,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n365_12,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n603_s3\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n603_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n603_11,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n133,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n132,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n605_s2\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n605_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n366_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n560_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n605_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n605_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n134,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n604_s2\: LUT3
generic map (
  INIT => X"53"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n604_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n365_12,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n559_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n604_s3\: LUT4
generic map (
  INIT => X"3CAA"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n604_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n133,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n237,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n604_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n603_s2\: LUT4
generic map (
  INIT => X"AAC3"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n603_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n603_13,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n559_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n558_4,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n603_s3\: LUT4
generic map (
  INIT => X"AA3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n603_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n603_11,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n133,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n132,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s5\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_9,
  I0 => I_rgb_r(3),
  I1 => I_rgb_r(5),
  I2 => I_rgb_r(6),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_13);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s6\: LUT4
generic map (
  INIT => X"7117"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_10,
  I0 => I_rgb_r(6),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_13,
  I2 => I_rgb_r(3),
  I3 => I_rgb_r(5));
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s7\: LUT4
generic map (
  INIT => X"7EE8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_11,
  I0 => I_rgb_r(0),
  I1 => I_rgb_r(1),
  I2 => I_rgb_r(2),
  I3 => I_rgb_r(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s8\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_12,
  I0 => I_rgb_r(3),
  I1 => I_rgb_r(5));
\rgb2dvi_inst/TMDS8b10b_inst_r/n630_s3\: LUT4
generic map (
  INIT => X"0002"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n630_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_r/n683_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(5));
\rgb2dvi_inst/TMDS8b10b_inst_r/n683_s5\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n683_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3));
\rgb2dvi_inst/TMDS8b10b_inst_r/n685_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n685_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s5\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_8,
  I0 => I_rgb_g(3),
  I1 => I_rgb_g(5),
  I2 => I_rgb_g(6),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_12);
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s6\: LUT4
generic map (
  INIT => X"7117"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_9,
  I0 => I_rgb_g(6),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_12,
  I2 => I_rgb_g(3),
  I3 => I_rgb_g(5));
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s7\: LUT4
generic map (
  INIT => X"7EE8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_10,
  I0 => I_rgb_g(0),
  I1 => I_rgb_g(1),
  I2 => I_rgb_g(2),
  I3 => I_rgb_g(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s8\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_11,
  I0 => I_rgb_g(3),
  I1 => I_rgb_g(5));
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s4\: LUT4
generic map (
  INIT => X"5CC5"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_7,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_8,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_9);
\rgb2dvi_inst/TMDS8b10b_inst_g/n683_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n683_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3));
\rgb2dvi_inst/TMDS8b10b_inst_g/n683_s5\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(5));
\rgb2dvi_inst/TMDS8b10b_inst_g/n685_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n685_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s5\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_8,
  I0 => I_rgb_b(3),
  I1 => I_rgb_b(5),
  I2 => I_rgb_b(6),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_12);
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s6\: LUT4
generic map (
  INIT => X"7117"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_9,
  I0 => I_rgb_b(6),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_12,
  I2 => I_rgb_b(3),
  I3 => I_rgb_b(5));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s7\: LUT4
generic map (
  INIT => X"7EE8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_10,
  I0 => I_rgb_b(0),
  I1 => I_rgb_b(1),
  I2 => I_rgb_b(2),
  I3 => I_rgb_b(4));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s8\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_11,
  I0 => I_rgb_b(3),
  I1 => I_rgb_b(5));
\rgb2dvi_inst/TMDS8b10b_inst_b/n683_s3\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n683_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(4),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(5));
\rgb2dvi_inst/TMDS8b10b_inst_b/n685_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n685_6,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s17\: LUT4
generic map (
  INIT => X"DD4B"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n630_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_8,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n683_7);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s18\: LUT4
generic map (
  INIT => X"5A3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_25,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n685_6);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s19\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_26,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_2_s20\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_27,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(6));
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s17\: LUT4
generic map (
  INIT => X"DD4B"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_23,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_25,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s18\: LUT4
generic map (
  INIT => X"5A3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_24,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_26,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n685_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_3_s13\: LUT4
generic map (
  INIT => X"0096"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3_16,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_7,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n683_8);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_0_s16\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s18\: LUT4
generic map (
  INIT => X"6006"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_24,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_26,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(5),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s19\: LUT4
generic map (
  INIT => X"F563"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_25,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n685_6);
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_2_s17\: LUT4
generic map (
  INIT => X"5A3C"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_24,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_25,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n685_6);
\rgb2dvi_inst/TMDS8b10b_inst_b/n604_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n604_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n238,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n239);
\rgb2dvi_inst/TMDS8b10b_inst_g/n604_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n604_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n238,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n239);
\rgb2dvi_inst/TMDS8b10b_inst_r/n604_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n604_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n238,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n239);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s9\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_13,
  I0 => I_rgb_r(0),
  I1 => I_rgb_r(1),
  I2 => I_rgb_r(2),
  I3 => I_rgb_r(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/n630_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n630_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s9\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_12,
  I0 => I_rgb_g(0),
  I1 => I_rgb_g(1),
  I2 => I_rgb_g(2),
  I3 => I_rgb_g(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s5\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(4));
\rgb2dvi_inst/TMDS8b10b_inst_g/n630_s6\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n630_9,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(6));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s9\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_12,
  I0 => I_rgb_b(0),
  I1 => I_rgb_b(1),
  I2 => I_rgb_b(2),
  I3 => I_rgb_b(4));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s19\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_25,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2));
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s19\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_25,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s20\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_26,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s20\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_26,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_2_s18\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_2_25,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2));
\rgb2dvi_inst/TMDS8b10b_inst_b/n114_s10\: LUT4
generic map (
  INIT => X"6999"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n114_14,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n114_10,
  I2 => I_rgb_b(3),
  I3 => I_rgb_b(5));
\rgb2dvi_inst/TMDS8b10b_inst_b/n603_s6\: LUT4
generic map (
  INIT => X"EA15"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n603_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n237,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n236);
\rgb2dvi_inst/TMDS8b10b_inst_g/n114_s10\: LUT4
generic map (
  INIT => X"6999"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n114_14,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_9,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n114_10,
  I2 => I_rgb_g(3),
  I3 => I_rgb_g(5));
\rgb2dvi_inst/TMDS8b10b_inst_g/n603_s6\: LUT4
generic map (
  INIT => X"EA15"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n603_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n237,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n236);
\rgb2dvi_inst/TMDS8b10b_inst_g/n685_s4\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n685_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(4),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n687_7);
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_1_s20\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(1),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_r/n114_s10\: LUT4
generic map (
  INIT => X"6999"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n114_15,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_10,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n114_11,
  I2 => I_rgb_r(3),
  I3 => I_rgb_r(5));
\rgb2dvi_inst/TMDS8b10b_inst_r/n603_s6\: LUT4
generic map (
  INIT => X"EA15"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n603_11,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n237,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n238,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n239,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n236);
\rgb2dvi_inst/TMDS8b10b_inst_r/n685_s4\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n685_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(4),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n687_7);
\rgb2dvi_inst/TMDS8b10b_inst_b/n630_s4\: LUT4
generic map (
  INIT => X"DBBD"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n630_8,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(7));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_1_s21\: LUT4
generic map (
  INIT => X"7EE7"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_1_28,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(7));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_0_s17\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_23,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(7));
\rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit_0_s18\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_cnt_one_9bit_0_25,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(5),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n401_s4\: LUT4
generic map (
  INIT => X"AAA9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n401,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(2),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit_3_s12\: LUT4
generic map (
  INIT => X"0900"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(3),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_23,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_24,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_2_25,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_r/n401_s4\: LUT4
generic map (
  INIT => X"AAA9"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n401,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(4),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(2),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(3));
\rgb2dvi_inst/TMDS8b10b_inst_b/n685_s4\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n685_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(3),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(4),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n687_7);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_1_s21\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(1),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_7,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_23,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_24);
\rgb2dvi_inst/TMDS8b10b_inst_b/n687_s3\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n687_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_b/n684_s2\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n684_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_6);
\rgb2dvi_inst/TMDS8b10b_inst_b/n683_s4\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n683_8,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(6),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(1),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n683_6);
\rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit_2_s16\: LUT4
generic map (
  INIT => X"5551"
)
port map (
  F => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(2),
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n630_4,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_3,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_cnt_one_9bit_1_22);
\rgb2dvi_inst/TMDS8b10b_inst_g/n686_s2\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n686_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n688_4,
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2),
  I3 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(3));
\rgb2dvi_inst/TMDS8b10b_inst_r/n686_s2\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n686_6,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(3),
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n688_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n687_s3\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n687_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_g/n680_s3\: LUT4
generic map (
  INIT => X"FFD5"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n680,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n630,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n687_s3\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n687_7,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(2),
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I2 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(1));
\rgb2dvi_inst/TMDS8b10b_inst_r/n680_s3\: LUT4
generic map (
  INIT => X"FFD5"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n680,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n630,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_r/n606_s2\: LUT4
generic map (
  INIT => X"A088"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n606,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n596,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n274,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n630);
\rgb2dvi_inst/TMDS8b10b_inst_g/n606_s2\: LUT4
generic map (
  INIT => X"A088"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n606,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n596,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n274,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n630);
\rgb2dvi_inst/TMDS8b10b_inst_b/n606_s2\: LUT4
generic map (
  INIT => X"A088"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n606,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_de_d,
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n596,
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n274,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n630);
\rgb2dvi_inst/TMDS8b10b_inst_r/n679_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n647,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_r/n679_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n670,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_r/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_r_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n679_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n647,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_g/n679_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n670,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_g/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_g_n653);
\rgb2dvi_inst/TMDS8b10b_inst_b/n679_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n647,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_sel_xnor);
\rgb2dvi_inst/TMDS8b10b_inst_b/n679_s1\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n670,
  I0 => \rgb2dvi_inst/TMDS8b10b_inst_b/din_d\(0),
  I1 => rgb2dvi_inst_TMDS8b10b_inst_b_n653);
\rgb2dvi_inst/TMDS8b10b_inst_g/n603_s7\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_g_n603_14,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_g_n558,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt_one_9bit\(3),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_g_n559_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_g_n559_4);
\rgb2dvi_inst/TMDS8b10b_inst_b/n603_s7\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_b_n603_13,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_b_n558,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt_one_9bit\(3),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_b_n559_5,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_b_n559_4);
\rgb2dvi_inst/TMDS8b10b_inst_r/n603_s7\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => rgb2dvi_inst_TMDS8b10b_inst_r_n603_13,
  I0 => rgb2dvi_inst_TMDS8b10b_inst_r_n364,
  I1 => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt_one_9bit\(3),
  I2 => rgb2dvi_inst_TMDS8b10b_inst_r_n365_11,
  I3 => rgb2dvi_inst_TMDS8b10b_inst_r_n365_12);
\rgb2dvi_inst/n36_s2\: INV
port map (
  O => rgb2dvi_inst_n36,
  I => I_rst_n);
\rgb2dvi_inst/TMDS8b10b_inst_b/n404_s5\: INV
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_b_n404,
  I => \rgb2dvi_inst/TMDS8b10b_inst_b/cnt\(1));
\rgb2dvi_inst/TMDS8b10b_inst_g/n404_s5\: INV
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_g_n404,
  I => \rgb2dvi_inst/TMDS8b10b_inst_g/cnt\(1));
\rgb2dvi_inst/TMDS8b10b_inst_r/n404_s5\: INV
port map (
  O => rgb2dvi_inst_TMDS8b10b_inst_r_n404,
  I => \rgb2dvi_inst/TMDS8b10b_inst_r/cnt\(1));
GND_s3: GND
port map (
  G => GND_0);
VCC_s3: VCC
port map (
  V => VCC_0);
GSR_0: GSR
port map (
  GSRI => VCC_0);
end beh;
