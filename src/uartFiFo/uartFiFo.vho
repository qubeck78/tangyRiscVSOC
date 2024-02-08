--
--Written by GowinSynthesis
--Tool Version "V1.9.9"
--Thu Feb  8 12:48:04 2024

--Source file index table:
--file0 "\C:/Users/qubec/Documents/Development/ProjektyVHDL/TangNano20K/tangyRiscVSOC/tangyRiscVSOC/src/uartFiFo/temp/FIFO_SC/fifo_sc_hs_define.v"
--file1 "\C:/Users/qubec/Documents/Development/ProjektyVHDL/TangNano20K/tangyRiscVSOC/tangyRiscVSOC/src/uartFiFo/temp/FIFO_SC/fifo_sc_hs_parameter.v"
--file2 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_SC_HS/data/fifo_sc_hs.v"
--file3 "\F:/Gowin/Gowin_V1.9.9_x64/IDE/ipcore/FIFO_SC_HS/data/fifo_sc_hs_top.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw2a;
use gw2a.components.all;

entity uartFiFo is
port(
  Data :  in std_logic_vector(7 downto 0);
  Clk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Reset :  in std_logic;
  Q :  out std_logic_vector(7 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end uartFiFo;
architecture beh of uartFiFo is
  signal fifo_sc_hs_inst_mem : std_logic ;
  signal fifo_sc_hs_inst_mem_164 : std_logic ;
  signal fifo_sc_hs_inst_mem_163 : std_logic ;
  signal fifo_sc_hs_inst_mem_162 : std_logic ;
  signal fifo_sc_hs_inst_mem_169 : std_logic ;
  signal fifo_sc_hs_inst_mem_168 : std_logic ;
  signal fifo_sc_hs_inst_mem_167 : std_logic ;
  signal fifo_sc_hs_inst_mem_166 : std_logic ;
  signal fifo_sc_hs_inst_mem_173 : std_logic ;
  signal fifo_sc_hs_inst_mem_172 : std_logic ;
  signal fifo_sc_hs_inst_mem_171 : std_logic ;
  signal fifo_sc_hs_inst_mem_170 : std_logic ;
  signal fifo_sc_hs_inst_mem_177 : std_logic ;
  signal fifo_sc_hs_inst_mem_176 : std_logic ;
  signal fifo_sc_hs_inst_mem_175 : std_logic ;
  signal fifo_sc_hs_inst_mem_174 : std_logic ;
  signal fifo_sc_hs_inst_mem_181 : std_logic ;
  signal fifo_sc_hs_inst_mem_180 : std_logic ;
  signal fifo_sc_hs_inst_mem_179 : std_logic ;
  signal fifo_sc_hs_inst_mem_178 : std_logic ;
  signal fifo_sc_hs_inst_mem_185 : std_logic ;
  signal fifo_sc_hs_inst_mem_184 : std_logic ;
  signal fifo_sc_hs_inst_mem_183 : std_logic ;
  signal fifo_sc_hs_inst_mem_182 : std_logic ;
  signal fifo_sc_hs_inst_mem_189 : std_logic ;
  signal fifo_sc_hs_inst_mem_188 : std_logic ;
  signal fifo_sc_hs_inst_mem_187 : std_logic ;
  signal fifo_sc_hs_inst_mem_186 : std_logic ;
  signal fifo_sc_hs_inst_mem_193 : std_logic ;
  signal fifo_sc_hs_inst_mem_192 : std_logic ;
  signal fifo_sc_hs_inst_mem_191 : std_logic ;
  signal fifo_sc_hs_inst_mem_190 : std_logic ;
  signal fifo_sc_hs_inst_mem_197 : std_logic ;
  signal fifo_sc_hs_inst_mem_196 : std_logic ;
  signal fifo_sc_hs_inst_mem_195 : std_logic ;
  signal fifo_sc_hs_inst_mem_194 : std_logic ;
  signal fifo_sc_hs_inst_mem_201 : std_logic ;
  signal fifo_sc_hs_inst_mem_200 : std_logic ;
  signal fifo_sc_hs_inst_mem_199 : std_logic ;
  signal fifo_sc_hs_inst_mem_198 : std_logic ;
  signal fifo_sc_hs_inst_mem_205 : std_logic ;
  signal fifo_sc_hs_inst_mem_204 : std_logic ;
  signal fifo_sc_hs_inst_mem_203 : std_logic ;
  signal fifo_sc_hs_inst_mem_202 : std_logic ;
  signal fifo_sc_hs_inst_mem_209 : std_logic ;
  signal fifo_sc_hs_inst_mem_208 : std_logic ;
  signal fifo_sc_hs_inst_mem_207 : std_logic ;
  signal fifo_sc_hs_inst_mem_206 : std_logic ;
  signal fifo_sc_hs_inst_mem_213 : std_logic ;
  signal fifo_sc_hs_inst_mem_212 : std_logic ;
  signal fifo_sc_hs_inst_mem_211 : std_logic ;
  signal fifo_sc_hs_inst_mem_210 : std_logic ;
  signal fifo_sc_hs_inst_mem_217 : std_logic ;
  signal fifo_sc_hs_inst_mem_216 : std_logic ;
  signal fifo_sc_hs_inst_mem_215 : std_logic ;
  signal fifo_sc_hs_inst_mem_214 : std_logic ;
  signal fifo_sc_hs_inst_mem_221 : std_logic ;
  signal fifo_sc_hs_inst_mem_220 : std_logic ;
  signal fifo_sc_hs_inst_mem_219 : std_logic ;
  signal fifo_sc_hs_inst_mem_218 : std_logic ;
  signal fifo_sc_hs_inst_mem_225 : std_logic ;
  signal fifo_sc_hs_inst_mem_224 : std_logic ;
  signal fifo_sc_hs_inst_mem_223 : std_logic ;
  signal fifo_sc_hs_inst_mem_222 : std_logic ;
  signal fifo_sc_hs_inst_mem_229 : std_logic ;
  signal fifo_sc_hs_inst_mem_228 : std_logic ;
  signal fifo_sc_hs_inst_mem_227 : std_logic ;
  signal fifo_sc_hs_inst_mem_226 : std_logic ;
  signal fifo_sc_hs_inst_mem_233 : std_logic ;
  signal fifo_sc_hs_inst_mem_232 : std_logic ;
  signal fifo_sc_hs_inst_mem_231 : std_logic ;
  signal fifo_sc_hs_inst_mem_230 : std_logic ;
  signal fifo_sc_hs_inst_mem_237 : std_logic ;
  signal fifo_sc_hs_inst_mem_236 : std_logic ;
  signal fifo_sc_hs_inst_mem_235 : std_logic ;
  signal fifo_sc_hs_inst_mem_234 : std_logic ;
  signal fifo_sc_hs_inst_mem_241 : std_logic ;
  signal fifo_sc_hs_inst_mem_240 : std_logic ;
  signal fifo_sc_hs_inst_mem_239 : std_logic ;
  signal fifo_sc_hs_inst_mem_238 : std_logic ;
  signal fifo_sc_hs_inst_mem_245 : std_logic ;
  signal fifo_sc_hs_inst_mem_244 : std_logic ;
  signal fifo_sc_hs_inst_mem_243 : std_logic ;
  signal fifo_sc_hs_inst_mem_242 : std_logic ;
  signal fifo_sc_hs_inst_mem_249 : std_logic ;
  signal fifo_sc_hs_inst_mem_248 : std_logic ;
  signal fifo_sc_hs_inst_mem_247 : std_logic ;
  signal fifo_sc_hs_inst_mem_246 : std_logic ;
  signal fifo_sc_hs_inst_mem_253 : std_logic ;
  signal fifo_sc_hs_inst_mem_252 : std_logic ;
  signal fifo_sc_hs_inst_mem_251 : std_logic ;
  signal fifo_sc_hs_inst_mem_250 : std_logic ;
  signal fifo_sc_hs_inst_mem_257 : std_logic ;
  signal fifo_sc_hs_inst_mem_256 : std_logic ;
  signal fifo_sc_hs_inst_mem_255 : std_logic ;
  signal fifo_sc_hs_inst_mem_254 : std_logic ;
  signal fifo_sc_hs_inst_mem_261 : std_logic ;
  signal fifo_sc_hs_inst_mem_260 : std_logic ;
  signal fifo_sc_hs_inst_mem_259 : std_logic ;
  signal fifo_sc_hs_inst_mem_258 : std_logic ;
  signal fifo_sc_hs_inst_mem_265 : std_logic ;
  signal fifo_sc_hs_inst_mem_264 : std_logic ;
  signal fifo_sc_hs_inst_mem_263 : std_logic ;
  signal fifo_sc_hs_inst_mem_262 : std_logic ;
  signal fifo_sc_hs_inst_mem_269 : std_logic ;
  signal fifo_sc_hs_inst_mem_268 : std_logic ;
  signal fifo_sc_hs_inst_mem_267 : std_logic ;
  signal fifo_sc_hs_inst_mem_266 : std_logic ;
  signal fifo_sc_hs_inst_mem_273 : std_logic ;
  signal fifo_sc_hs_inst_mem_272 : std_logic ;
  signal fifo_sc_hs_inst_mem_271 : std_logic ;
  signal fifo_sc_hs_inst_mem_270 : std_logic ;
  signal fifo_sc_hs_inst_mem_277 : std_logic ;
  signal fifo_sc_hs_inst_mem_276 : std_logic ;
  signal fifo_sc_hs_inst_mem_275 : std_logic ;
  signal fifo_sc_hs_inst_mem_274 : std_logic ;
  signal fifo_sc_hs_inst_mem_281 : std_logic ;
  signal fifo_sc_hs_inst_mem_280 : std_logic ;
  signal fifo_sc_hs_inst_mem_279 : std_logic ;
  signal fifo_sc_hs_inst_mem_278 : std_logic ;
  signal fifo_sc_hs_inst_mem_285 : std_logic ;
  signal fifo_sc_hs_inst_mem_284 : std_logic ;
  signal fifo_sc_hs_inst_mem_283 : std_logic ;
  signal fifo_sc_hs_inst_mem_282 : std_logic ;
  signal fifo_sc_hs_inst_mem_289 : std_logic ;
  signal fifo_sc_hs_inst_mem_288 : std_logic ;
  signal fifo_sc_hs_inst_mem_287 : std_logic ;
  signal fifo_sc_hs_inst_mem_286 : std_logic ;
  signal fifo_sc_hs_inst_n170 : std_logic ;
  signal fifo_sc_hs_inst_n170_1 : std_logic ;
  signal fifo_sc_hs_inst_n169 : std_logic ;
  signal fifo_sc_hs_inst_n169_1 : std_logic ;
  signal fifo_sc_hs_inst_n168 : std_logic ;
  signal fifo_sc_hs_inst_n168_1 : std_logic ;
  signal fifo_sc_hs_inst_n167 : std_logic ;
  signal fifo_sc_hs_inst_n167_1 : std_logic ;
  signal fifo_sc_hs_inst_n166 : std_logic ;
  signal fifo_sc_hs_inst_n166_1 : std_logic ;
  signal fifo_sc_hs_inst_n165 : std_logic ;
  signal fifo_sc_hs_inst_n165_1 : std_logic ;
  signal fifo_sc_hs_inst_n164 : std_logic ;
  signal fifo_sc_hs_inst_n164_1 : std_logic ;
  signal fifo_sc_hs_inst_n163 : std_logic ;
  signal fifo_sc_hs_inst_n163_1 : std_logic ;
  signal fifo_sc_hs_inst_n162 : std_logic ;
  signal fifo_sc_hs_inst_n162_1 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_0 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_1 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_2 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_3 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_4 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_5 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_6 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_7 : std_logic ;
  signal fifo_sc_hs_inst_wbin_next_8 : std_logic ;
  signal fifo_sc_hs_inst_n191 : std_logic ;
  signal fifo_sc_hs_inst_n191_3 : std_logic ;
  signal fifo_sc_hs_inst_n192 : std_logic ;
  signal fifo_sc_hs_inst_n192_3 : std_logic ;
  signal fifo_sc_hs_inst_n193 : std_logic ;
  signal fifo_sc_hs_inst_n193_3 : std_logic ;
  signal fifo_sc_hs_inst_n194 : std_logic ;
  signal fifo_sc_hs_inst_n194_3 : std_logic ;
  signal fifo_sc_hs_inst_n195 : std_logic ;
  signal fifo_sc_hs_inst_n195_3 : std_logic ;
  signal fifo_sc_hs_inst_n196 : std_logic ;
  signal fifo_sc_hs_inst_n196_3 : std_logic ;
  signal fifo_sc_hs_inst_n197 : std_logic ;
  signal fifo_sc_hs_inst_n197_3 : std_logic ;
  signal fifo_sc_hs_inst_n198 : std_logic ;
  signal fifo_sc_hs_inst_n198_3 : std_logic ;
  signal fifo_sc_hs_inst_n199 : std_logic ;
  signal fifo_sc_hs_inst_n199_3 : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_18\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_19\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_20\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_21\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_22\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_23\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_24\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_26\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_28\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_30\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_32\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_7_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_22_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_37_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_52_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_67_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_82_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_97_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_34\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_112_G[3]_36\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_0_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_15_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_30_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_45_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_60_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_75_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_90_G[0]\ : std_logic ;
  signal \fifo_sc_hs_inst_mem_DOL_105_G[0]\ : std_logic ;
  signal fifo_sc_hs_inst_n7 : std_logic ;
  signal fifo_sc_hs_inst_n13 : std_logic ;
  signal fifo_sc_hs_inst_mem_291 : std_logic ;
  signal fifo_sc_hs_inst_mem_293 : std_logic ;
  signal fifo_sc_hs_inst_mem_295 : std_logic ;
  signal fifo_sc_hs_inst_mem_297 : std_logic ;
  signal fifo_sc_hs_inst_mem_299 : std_logic ;
  signal fifo_sc_hs_inst_mem_301 : std_logic ;
  signal fifo_sc_hs_inst_mem_303 : std_logic ;
  signal fifo_sc_hs_inst_mem_305 : std_logic ;
  signal fifo_sc_hs_inst_mem_307 : std_logic ;
  signal fifo_sc_hs_inst_mem_309 : std_logic ;
  signal fifo_sc_hs_inst_mem_311 : std_logic ;
  signal fifo_sc_hs_inst_mem_313 : std_logic ;
  signal fifo_sc_hs_inst_mem_315 : std_logic ;
  signal fifo_sc_hs_inst_mem_317 : std_logic ;
  signal fifo_sc_hs_inst_mem_319 : std_logic ;
  signal fifo_sc_hs_inst_mem_321 : std_logic ;
  signal fifo_sc_hs_inst_n7_5 : std_logic ;
  signal fifo_sc_hs_inst_n7_6 : std_logic ;
  signal fifo_sc_hs_inst_mem_322 : std_logic ;
  signal fifo_sc_hs_inst_mem_323 : std_logic ;
  signal fifo_sc_hs_inst_mem_324 : std_logic ;
  signal fifo_sc_hs_inst_mem_325 : std_logic ;
  signal fifo_sc_hs_inst_mem_326 : std_logic ;
  signal fifo_sc_hs_inst_mem_327 : std_logic ;
  signal fifo_sc_hs_inst_mem_328 : std_logic ;
  signal fifo_sc_hs_inst_mem_329 : std_logic ;
  signal fifo_sc_hs_inst_rbin_next_2 : std_logic ;
  signal fifo_sc_hs_inst_rbin_next_4 : std_logic ;
  signal fifo_sc_hs_inst_rbin_next_6 : std_logic ;
  signal fifo_sc_hs_inst_Wnum_8 : std_logic ;
  signal fifo_sc_hs_inst_n112 : std_logic ;
  signal fifo_sc_hs_inst_n112_1 : std_logic ;
  signal fifo_sc_hs_inst_rempty_val : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_sc_hs_inst/rbin\ : std_logic_vector(8 downto 0);
  signal \fifo_sc_hs_inst/wbin\ : std_logic_vector(8 downto 0);
  signal \fifo_sc_hs_inst/Wnum\ : std_logic_vector(8 downto 0);
  signal \fifo_sc_hs_inst/wbin_next\ : std_logic_vector(8 downto 0);
  signal \fifo_sc_hs_inst/rbin_next\ : std_logic_vector(8 downto 0);
  signal NN : std_logic;
begin
\fifo_sc_hs_inst/Q_r2_6_s0\: DFFCE
port map (
  Q => Q(6),
  D => \fifo_sc_hs_inst_mem_DOL_90_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_5_s0\: DFFCE
port map (
  Q => Q(5),
  D => \fifo_sc_hs_inst_mem_DOL_75_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_4_s0\: DFFCE
port map (
  Q => Q(4),
  D => \fifo_sc_hs_inst_mem_DOL_60_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_3_s0\: DFFCE
port map (
  Q => Q(3),
  D => \fifo_sc_hs_inst_mem_DOL_45_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_2_s0\: DFFCE
port map (
  Q => Q(2),
  D => \fifo_sc_hs_inst_mem_DOL_30_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_1_s0\: DFFCE
port map (
  Q => Q(1),
  D => \fifo_sc_hs_inst_mem_DOL_15_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_0_s0\: DFFCE
port map (
  Q => Q(0),
  D => \fifo_sc_hs_inst_mem_DOL_0_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_8_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(8),
  D => \fifo_sc_hs_inst/rbin_next\(8),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_7_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(7),
  D => \fifo_sc_hs_inst/rbin_next\(7),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_6_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(6),
  D => \fifo_sc_hs_inst/rbin_next\(6),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_5_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(5),
  D => \fifo_sc_hs_inst/rbin_next\(5),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_4_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(4),
  D => \fifo_sc_hs_inst/rbin_next\(4),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_3_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(3),
  D => \fifo_sc_hs_inst/rbin_next\(3),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_2_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(2),
  D => \fifo_sc_hs_inst/rbin_next\(2),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_1_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(1),
  D => \fifo_sc_hs_inst/rbin_next\(1),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/rbin_0_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/rbin\(0),
  D => \fifo_sc_hs_inst/rbin_next\(0),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_8_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(8),
  D => \fifo_sc_hs_inst/wbin_next\(8),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_7_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(7),
  D => \fifo_sc_hs_inst/wbin_next\(7),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_6_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(6),
  D => \fifo_sc_hs_inst/wbin_next\(6),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_5_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(5),
  D => \fifo_sc_hs_inst/wbin_next\(5),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_4_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(4),
  D => \fifo_sc_hs_inst/wbin_next\(4),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_3_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(3),
  D => \fifo_sc_hs_inst/wbin_next\(3),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_2_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(2),
  D => \fifo_sc_hs_inst/wbin_next\(2),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_1_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(1),
  D => \fifo_sc_hs_inst/wbin_next\(1),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/wbin_0_s0\: DFFC
port map (
  Q => \fifo_sc_hs_inst/wbin\(0),
  D => \fifo_sc_hs_inst/wbin_next\(0),
  CLK => Clk,
  CLEAR => Reset);
\fifo_sc_hs_inst/Q_r2_7_s0\: DFFCE
port map (
  Q => Q(7),
  D => \fifo_sc_hs_inst_mem_DOL_105_G[0]\,
  CLK => Clk,
  CE => fifo_sc_hs_inst_n13,
  CLEAR => Reset);
\fifo_sc_hs_inst/Empty_s0\: DFFP
port map (
  Q => NN,
  D => fifo_sc_hs_inst_rempty_val,
  CLK => Clk,
  PRESET => Reset);
\fifo_sc_hs_inst/Wnum_8_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(8),
  D => fifo_sc_hs_inst_n162,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_7_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(7),
  D => fifo_sc_hs_inst_n163,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_6_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(6),
  D => fifo_sc_hs_inst_n164,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_5_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(5),
  D => fifo_sc_hs_inst_n165,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_4_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(4),
  D => fifo_sc_hs_inst_n166,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_3_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(3),
  D => fifo_sc_hs_inst_n167,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_2_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(2),
  D => fifo_sc_hs_inst_n168,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_1_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(1),
  D => fifo_sc_hs_inst_n169,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/Wnum_0_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => \fifo_sc_hs_inst/Wnum\(0),
  D => fifo_sc_hs_inst_n170,
  CLK => Clk,
  CE => fifo_sc_hs_inst_Wnum_8,
  CLEAR => Reset);
\fifo_sc_hs_inst/mem_mem_0_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem,
  DO(2) => fifo_sc_hs_inst_mem_164,
  DO(1) => fifo_sc_hs_inst_mem_163,
  DO(0) => fifo_sc_hs_inst_mem_162,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_291,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_0_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_169,
  DO(2) => fifo_sc_hs_inst_mem_168,
  DO(1) => fifo_sc_hs_inst_mem_167,
  DO(0) => fifo_sc_hs_inst_mem_166,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_291,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_1_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_173,
  DO(2) => fifo_sc_hs_inst_mem_172,
  DO(1) => fifo_sc_hs_inst_mem_171,
  DO(0) => fifo_sc_hs_inst_mem_170,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_293,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_1_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_177,
  DO(2) => fifo_sc_hs_inst_mem_176,
  DO(1) => fifo_sc_hs_inst_mem_175,
  DO(0) => fifo_sc_hs_inst_mem_174,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_293,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_2_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_181,
  DO(2) => fifo_sc_hs_inst_mem_180,
  DO(1) => fifo_sc_hs_inst_mem_179,
  DO(0) => fifo_sc_hs_inst_mem_178,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_295,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_2_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_185,
  DO(2) => fifo_sc_hs_inst_mem_184,
  DO(1) => fifo_sc_hs_inst_mem_183,
  DO(0) => fifo_sc_hs_inst_mem_182,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_295,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_3_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_189,
  DO(2) => fifo_sc_hs_inst_mem_188,
  DO(1) => fifo_sc_hs_inst_mem_187,
  DO(0) => fifo_sc_hs_inst_mem_186,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_297,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_3_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_193,
  DO(2) => fifo_sc_hs_inst_mem_192,
  DO(1) => fifo_sc_hs_inst_mem_191,
  DO(0) => fifo_sc_hs_inst_mem_190,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_297,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_4_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_197,
  DO(2) => fifo_sc_hs_inst_mem_196,
  DO(1) => fifo_sc_hs_inst_mem_195,
  DO(0) => fifo_sc_hs_inst_mem_194,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_299,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_4_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_201,
  DO(2) => fifo_sc_hs_inst_mem_200,
  DO(1) => fifo_sc_hs_inst_mem_199,
  DO(0) => fifo_sc_hs_inst_mem_198,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_299,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_5_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_205,
  DO(2) => fifo_sc_hs_inst_mem_204,
  DO(1) => fifo_sc_hs_inst_mem_203,
  DO(0) => fifo_sc_hs_inst_mem_202,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_301,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_5_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_209,
  DO(2) => fifo_sc_hs_inst_mem_208,
  DO(1) => fifo_sc_hs_inst_mem_207,
  DO(0) => fifo_sc_hs_inst_mem_206,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_301,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_6_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_213,
  DO(2) => fifo_sc_hs_inst_mem_212,
  DO(1) => fifo_sc_hs_inst_mem_211,
  DO(0) => fifo_sc_hs_inst_mem_210,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_303,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_6_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_217,
  DO(2) => fifo_sc_hs_inst_mem_216,
  DO(1) => fifo_sc_hs_inst_mem_215,
  DO(0) => fifo_sc_hs_inst_mem_214,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_303,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_7_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_221,
  DO(2) => fifo_sc_hs_inst_mem_220,
  DO(1) => fifo_sc_hs_inst_mem_219,
  DO(0) => fifo_sc_hs_inst_mem_218,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_305,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_7_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_225,
  DO(2) => fifo_sc_hs_inst_mem_224,
  DO(1) => fifo_sc_hs_inst_mem_223,
  DO(0) => fifo_sc_hs_inst_mem_222,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_305,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_8_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_229,
  DO(2) => fifo_sc_hs_inst_mem_228,
  DO(1) => fifo_sc_hs_inst_mem_227,
  DO(0) => fifo_sc_hs_inst_mem_226,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_307,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_8_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_233,
  DO(2) => fifo_sc_hs_inst_mem_232,
  DO(1) => fifo_sc_hs_inst_mem_231,
  DO(0) => fifo_sc_hs_inst_mem_230,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_307,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_9_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_237,
  DO(2) => fifo_sc_hs_inst_mem_236,
  DO(1) => fifo_sc_hs_inst_mem_235,
  DO(0) => fifo_sc_hs_inst_mem_234,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_309,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_9_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_241,
  DO(2) => fifo_sc_hs_inst_mem_240,
  DO(1) => fifo_sc_hs_inst_mem_239,
  DO(0) => fifo_sc_hs_inst_mem_238,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_309,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_10_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_245,
  DO(2) => fifo_sc_hs_inst_mem_244,
  DO(1) => fifo_sc_hs_inst_mem_243,
  DO(0) => fifo_sc_hs_inst_mem_242,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_311,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_10_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_249,
  DO(2) => fifo_sc_hs_inst_mem_248,
  DO(1) => fifo_sc_hs_inst_mem_247,
  DO(0) => fifo_sc_hs_inst_mem_246,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_311,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_11_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_253,
  DO(2) => fifo_sc_hs_inst_mem_252,
  DO(1) => fifo_sc_hs_inst_mem_251,
  DO(0) => fifo_sc_hs_inst_mem_250,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_313,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_11_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_257,
  DO(2) => fifo_sc_hs_inst_mem_256,
  DO(1) => fifo_sc_hs_inst_mem_255,
  DO(0) => fifo_sc_hs_inst_mem_254,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_313,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_12_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_261,
  DO(2) => fifo_sc_hs_inst_mem_260,
  DO(1) => fifo_sc_hs_inst_mem_259,
  DO(0) => fifo_sc_hs_inst_mem_258,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_315,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_12_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_265,
  DO(2) => fifo_sc_hs_inst_mem_264,
  DO(1) => fifo_sc_hs_inst_mem_263,
  DO(0) => fifo_sc_hs_inst_mem_262,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_315,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_13_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_269,
  DO(2) => fifo_sc_hs_inst_mem_268,
  DO(1) => fifo_sc_hs_inst_mem_267,
  DO(0) => fifo_sc_hs_inst_mem_266,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_317,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_13_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_273,
  DO(2) => fifo_sc_hs_inst_mem_272,
  DO(1) => fifo_sc_hs_inst_mem_271,
  DO(0) => fifo_sc_hs_inst_mem_270,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_317,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_14_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_277,
  DO(2) => fifo_sc_hs_inst_mem_276,
  DO(1) => fifo_sc_hs_inst_mem_275,
  DO(0) => fifo_sc_hs_inst_mem_274,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_319,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_14_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_281,
  DO(2) => fifo_sc_hs_inst_mem_280,
  DO(1) => fifo_sc_hs_inst_mem_279,
  DO(0) => fifo_sc_hs_inst_mem_278,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_319,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_15_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_285,
  DO(2) => fifo_sc_hs_inst_mem_284,
  DO(1) => fifo_sc_hs_inst_mem_283,
  DO(0) => fifo_sc_hs_inst_mem_282,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_321,
  CLK => Clk);
\fifo_sc_hs_inst/mem_mem_15_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_sc_hs_inst_mem_289,
  DO(2) => fifo_sc_hs_inst_mem_288,
  DO(1) => fifo_sc_hs_inst_mem_287,
  DO(0) => fifo_sc_hs_inst_mem_286,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3 downto 0) => \fifo_sc_hs_inst/wbin\(3 downto 0),
  RAD(3 downto 0) => \fifo_sc_hs_inst/rbin_next\(3 downto 0),
  WRE => fifo_sc_hs_inst_mem_321,
  CLK => Clk);
\fifo_sc_hs_inst/n170_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n170,
  COUT => fifo_sc_hs_inst_n170_1,
  I0 => \fifo_sc_hs_inst/Wnum\(0),
  I1 => VCC_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n112_1);
\fifo_sc_hs_inst/n169_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n169,
  COUT => fifo_sc_hs_inst_n169_1,
  I0 => \fifo_sc_hs_inst/Wnum\(1),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n170_1);
\fifo_sc_hs_inst/n168_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n168,
  COUT => fifo_sc_hs_inst_n168_1,
  I0 => \fifo_sc_hs_inst/Wnum\(2),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n169_1);
\fifo_sc_hs_inst/n167_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n167,
  COUT => fifo_sc_hs_inst_n167_1,
  I0 => \fifo_sc_hs_inst/Wnum\(3),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n168_1);
\fifo_sc_hs_inst/n166_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n166,
  COUT => fifo_sc_hs_inst_n166_1,
  I0 => \fifo_sc_hs_inst/Wnum\(4),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n167_1);
\fifo_sc_hs_inst/n165_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n165,
  COUT => fifo_sc_hs_inst_n165_1,
  I0 => \fifo_sc_hs_inst/Wnum\(5),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n166_1);
\fifo_sc_hs_inst/n164_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n164,
  COUT => fifo_sc_hs_inst_n164_1,
  I0 => \fifo_sc_hs_inst/Wnum\(6),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n165_1);
\fifo_sc_hs_inst/n163_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n163,
  COUT => fifo_sc_hs_inst_n163_1,
  I0 => \fifo_sc_hs_inst/Wnum\(7),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n164_1);
\fifo_sc_hs_inst/n162_1_s\: ALU
generic map (
  ALU_MODE => 2
)
port map (
  SUM => fifo_sc_hs_inst_n162,
  COUT => fifo_sc_hs_inst_n162_1,
  I0 => \fifo_sc_hs_inst/Wnum\(8),
  I1 => GND_0,
  I3 => fifo_sc_hs_inst_n112,
  CIN => fifo_sc_hs_inst_n163_1);
\fifo_sc_hs_inst/wbin_next_0_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(0),
  COUT => fifo_sc_hs_inst_wbin_next_0,
  I0 => \fifo_sc_hs_inst/wbin\(0),
  I1 => fifo_sc_hs_inst_n7,
  I3 => GND_0,
  CIN => GND_0);
\fifo_sc_hs_inst/wbin_next_1_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(1),
  COUT => fifo_sc_hs_inst_wbin_next_1,
  I0 => \fifo_sc_hs_inst/wbin\(1),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_0);
\fifo_sc_hs_inst/wbin_next_2_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(2),
  COUT => fifo_sc_hs_inst_wbin_next_2,
  I0 => \fifo_sc_hs_inst/wbin\(2),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_1);
\fifo_sc_hs_inst/wbin_next_3_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(3),
  COUT => fifo_sc_hs_inst_wbin_next_3,
  I0 => \fifo_sc_hs_inst/wbin\(3),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_2);
\fifo_sc_hs_inst/wbin_next_4_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(4),
  COUT => fifo_sc_hs_inst_wbin_next_4,
  I0 => \fifo_sc_hs_inst/wbin\(4),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_3);
\fifo_sc_hs_inst/wbin_next_5_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(5),
  COUT => fifo_sc_hs_inst_wbin_next_5,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_4);
\fifo_sc_hs_inst/wbin_next_6_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(6),
  COUT => fifo_sc_hs_inst_wbin_next_6,
  I0 => \fifo_sc_hs_inst/wbin\(6),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_5);
\fifo_sc_hs_inst/wbin_next_7_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(7),
  COUT => fifo_sc_hs_inst_wbin_next_7,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_6);
\fifo_sc_hs_inst/wbin_next_8_s\: ALU
generic map (
  ALU_MODE => 0
)
port map (
  SUM => \fifo_sc_hs_inst/wbin_next\(8),
  COUT => fifo_sc_hs_inst_wbin_next_8,
  I0 => \fifo_sc_hs_inst/wbin\(8),
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_wbin_next_7);
\fifo_sc_hs_inst/n191_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n191,
  COUT => fifo_sc_hs_inst_n191_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(0),
  I1 => \fifo_sc_hs_inst/wbin\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_sc_hs_inst/n192_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n192,
  COUT => fifo_sc_hs_inst_n192_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(1),
  I1 => \fifo_sc_hs_inst/wbin\(1),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n191_3);
\fifo_sc_hs_inst/n193_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n193,
  COUT => fifo_sc_hs_inst_n193_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(2),
  I1 => \fifo_sc_hs_inst/wbin\(2),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n192_3);
\fifo_sc_hs_inst/n194_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n194,
  COUT => fifo_sc_hs_inst_n194_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(3),
  I1 => \fifo_sc_hs_inst/wbin\(3),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n193_3);
\fifo_sc_hs_inst/n195_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n195,
  COUT => fifo_sc_hs_inst_n195_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(4),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n194_3);
\fifo_sc_hs_inst/n196_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n196,
  COUT => fifo_sc_hs_inst_n196_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(5),
  I1 => \fifo_sc_hs_inst/wbin\(5),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n195_3);
\fifo_sc_hs_inst/n197_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n197,
  COUT => fifo_sc_hs_inst_n197_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(6),
  I1 => \fifo_sc_hs_inst/wbin\(6),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n196_3);
\fifo_sc_hs_inst/n198_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n198,
  COUT => fifo_sc_hs_inst_n198_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(7),
  I1 => \fifo_sc_hs_inst/wbin\(7),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n197_3);
\fifo_sc_hs_inst/n199_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_sc_hs_inst_n199,
  COUT => fifo_sc_hs_inst_n199_3,
  I0 => \fifo_sc_hs_inst/rbin_next\(8),
  I1 => \fifo_sc_hs_inst/wbin\(8),
  I3 => GND_0,
  CIN => fifo_sc_hs_inst_n198_3);
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]\,
  I0 => fifo_sc_hs_inst_mem_162,
  I1 => fifo_sc_hs_inst_mem_226,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_194,
  I1 => fifo_sc_hs_inst_mem_258,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_178,
  I1 => fifo_sc_hs_inst_mem_242,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_210,
  I1 => fifo_sc_hs_inst_mem_274,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_170,
  I1 => fifo_sc_hs_inst_mem_234,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_202,
  I1 => fifo_sc_hs_inst_mem_266,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_186,
  I1 => fifo_sc_hs_inst_mem_250,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_7_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_218,
  I1 => fifo_sc_hs_inst_mem_282,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]\,
  I0 => fifo_sc_hs_inst_mem_163,
  I1 => fifo_sc_hs_inst_mem_227,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_195,
  I1 => fifo_sc_hs_inst_mem_259,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_179,
  I1 => fifo_sc_hs_inst_mem_243,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_211,
  I1 => fifo_sc_hs_inst_mem_275,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_171,
  I1 => fifo_sc_hs_inst_mem_235,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_203,
  I1 => fifo_sc_hs_inst_mem_267,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_187,
  I1 => fifo_sc_hs_inst_mem_251,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_22_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_219,
  I1 => fifo_sc_hs_inst_mem_283,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]\,
  I0 => fifo_sc_hs_inst_mem_164,
  I1 => fifo_sc_hs_inst_mem_228,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_196,
  I1 => fifo_sc_hs_inst_mem_260,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_180,
  I1 => fifo_sc_hs_inst_mem_244,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_212,
  I1 => fifo_sc_hs_inst_mem_276,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_172,
  I1 => fifo_sc_hs_inst_mem_236,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_204,
  I1 => fifo_sc_hs_inst_mem_268,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_188,
  I1 => fifo_sc_hs_inst_mem_252,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_37_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_220,
  I1 => fifo_sc_hs_inst_mem_284,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]\,
  I0 => fifo_sc_hs_inst_mem,
  I1 => fifo_sc_hs_inst_mem_229,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_197,
  I1 => fifo_sc_hs_inst_mem_261,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_181,
  I1 => fifo_sc_hs_inst_mem_245,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_213,
  I1 => fifo_sc_hs_inst_mem_277,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_173,
  I1 => fifo_sc_hs_inst_mem_237,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_205,
  I1 => fifo_sc_hs_inst_mem_269,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_189,
  I1 => fifo_sc_hs_inst_mem_253,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_52_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_221,
  I1 => fifo_sc_hs_inst_mem_285,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]\,
  I0 => fifo_sc_hs_inst_mem_166,
  I1 => fifo_sc_hs_inst_mem_230,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_198,
  I1 => fifo_sc_hs_inst_mem_262,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_182,
  I1 => fifo_sc_hs_inst_mem_246,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_214,
  I1 => fifo_sc_hs_inst_mem_278,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_174,
  I1 => fifo_sc_hs_inst_mem_238,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_206,
  I1 => fifo_sc_hs_inst_mem_270,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_190,
  I1 => fifo_sc_hs_inst_mem_254,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_67_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_222,
  I1 => fifo_sc_hs_inst_mem_286,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]\,
  I0 => fifo_sc_hs_inst_mem_167,
  I1 => fifo_sc_hs_inst_mem_231,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_199,
  I1 => fifo_sc_hs_inst_mem_263,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_183,
  I1 => fifo_sc_hs_inst_mem_247,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_215,
  I1 => fifo_sc_hs_inst_mem_279,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_175,
  I1 => fifo_sc_hs_inst_mem_239,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_207,
  I1 => fifo_sc_hs_inst_mem_271,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_191,
  I1 => fifo_sc_hs_inst_mem_255,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_82_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_223,
  I1 => fifo_sc_hs_inst_mem_287,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]\,
  I0 => fifo_sc_hs_inst_mem_168,
  I1 => fifo_sc_hs_inst_mem_232,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_200,
  I1 => fifo_sc_hs_inst_mem_264,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_184,
  I1 => fifo_sc_hs_inst_mem_248,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_216,
  I1 => fifo_sc_hs_inst_mem_280,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_176,
  I1 => fifo_sc_hs_inst_mem_240,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_208,
  I1 => fifo_sc_hs_inst_mem_272,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_192,
  I1 => fifo_sc_hs_inst_mem_256,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_97_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_224,
  I1 => fifo_sc_hs_inst_mem_288,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s7\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]\,
  I0 => fifo_sc_hs_inst_mem_169,
  I1 => fifo_sc_hs_inst_mem_233,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s8\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_18\,
  I0 => fifo_sc_hs_inst_mem_201,
  I1 => fifo_sc_hs_inst_mem_265,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s9\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_19\,
  I0 => fifo_sc_hs_inst_mem_185,
  I1 => fifo_sc_hs_inst_mem_249,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s10\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_20\,
  I0 => fifo_sc_hs_inst_mem_217,
  I1 => fifo_sc_hs_inst_mem_281,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s11\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_21\,
  I0 => fifo_sc_hs_inst_mem_177,
  I1 => fifo_sc_hs_inst_mem_241,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s12\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_22\,
  I0 => fifo_sc_hs_inst_mem_209,
  I1 => fifo_sc_hs_inst_mem_273,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s13\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_23\,
  I0 => fifo_sc_hs_inst_mem_193,
  I1 => fifo_sc_hs_inst_mem_257,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s14\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => \fifo_sc_hs_inst_mem_DOL_112_G[3]_24\,
  I0 => fifo_sc_hs_inst_mem_225,
  I1 => fifo_sc_hs_inst_mem_289,
  I2 => \fifo_sc_hs_inst/rbin_next\(7));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s3\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_26\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_18\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s4\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_28\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_19\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_20\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s5\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_30\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_21\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_22\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s6\: MUX2_LUT5
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_32\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_23\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_24\,
  S0 => \fifo_sc_hs_inst/rbin_next\(6));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_7_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_22_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_37_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_52_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_67_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_82_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_97_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s1\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_34\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_26\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_28\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s2\: MUX2_LUT6
port map (
  O => \fifo_sc_hs_inst_mem_DOL_112_G[3]_36\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_30\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_32\,
  S0 => \fifo_sc_hs_inst/rbin_next\(5));
\fifo_sc_hs_inst/mem_DOL_0_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_0_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_7_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_15_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_15_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_22_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_30_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_30_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_37_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_45_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_45_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_52_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_60_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_60_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_67_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_75_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_75_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_82_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_90_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_90_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_97_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/mem_DOL_105_G[0]_s0\: MUX2_LUT7
port map (
  O => \fifo_sc_hs_inst_mem_DOL_105_G[0]\,
  I0 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_34\,
  I1 => \fifo_sc_hs_inst_mem_DOL_112_G[3]_36\,
  S0 => \fifo_sc_hs_inst/rbin_next\(4));
\fifo_sc_hs_inst/n7_s0\: LUT4
generic map (
  INIT => X"BF00"
)
port map (
  F => fifo_sc_hs_inst_n7,
  I0 => \fifo_sc_hs_inst/Wnum\(0),
  I1 => fifo_sc_hs_inst_n7_5,
  I2 => fifo_sc_hs_inst_n7_6,
  I3 => WrEn);
\fifo_sc_hs_inst/n13_s1\: LUT3
generic map (
  INIT => X"E0"
)
port map (
  F => fifo_sc_hs_inst_n13,
  I0 => RdEn,
  I1 => NN,
  I2 => fifo_sc_hs_inst_n199_3);
\fifo_sc_hs_inst/Full_d_s\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => Full,
  I0 => \fifo_sc_hs_inst/Wnum\(0),
  I1 => fifo_sc_hs_inst_n7_5,
  I2 => fifo_sc_hs_inst_n7_6);
\fifo_sc_hs_inst/mem_s161\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_291,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_322);
\fifo_sc_hs_inst/mem_s162\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_293,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_323);
\fifo_sc_hs_inst/mem_s163\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_295,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_324);
\fifo_sc_hs_inst/mem_s164\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_297,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_325);
\fifo_sc_hs_inst/mem_s165\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_299,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_326);
\fifo_sc_hs_inst/mem_s166\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_301,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_327);
\fifo_sc_hs_inst/mem_s167\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_303,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_328);
\fifo_sc_hs_inst/mem_s168\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_305,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_329);
\fifo_sc_hs_inst/mem_s169\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_307,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_322);
\fifo_sc_hs_inst/mem_s170\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_309,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_323);
\fifo_sc_hs_inst/mem_s171\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_311,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_324);
\fifo_sc_hs_inst/mem_s172\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_313,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_325);
\fifo_sc_hs_inst/mem_s173\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_315,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_326);
\fifo_sc_hs_inst/mem_s174\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_317,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_327);
\fifo_sc_hs_inst/mem_s175\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_319,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_328);
\fifo_sc_hs_inst/mem_s176\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_321,
  I0 => \fifo_sc_hs_inst/wbin\(7),
  I1 => fifo_sc_hs_inst_n7,
  I2 => fifo_sc_hs_inst_mem_329);
\fifo_sc_hs_inst/rbin_next_2_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(2),
  I0 => \fifo_sc_hs_inst/rbin\(2),
  I1 => fifo_sc_hs_inst_rbin_next_2);
\fifo_sc_hs_inst/rbin_next_3_s4\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(3),
  I0 => \fifo_sc_hs_inst/rbin\(2),
  I1 => fifo_sc_hs_inst_rbin_next_2,
  I2 => \fifo_sc_hs_inst/rbin\(3));
\fifo_sc_hs_inst/rbin_next_5_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(5),
  I0 => \fifo_sc_hs_inst/rbin\(4),
  I1 => fifo_sc_hs_inst_rbin_next_2,
  I2 => fifo_sc_hs_inst_rbin_next_4,
  I3 => \fifo_sc_hs_inst/rbin\(5));
\fifo_sc_hs_inst/rbin_next_6_s4\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(6),
  I0 => \fifo_sc_hs_inst/rbin\(6),
  I1 => fifo_sc_hs_inst_rbin_next_6);
\fifo_sc_hs_inst/rbin_next_7_s4\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(7),
  I0 => \fifo_sc_hs_inst/rbin\(6),
  I1 => fifo_sc_hs_inst_rbin_next_6,
  I2 => \fifo_sc_hs_inst/rbin\(7));
\fifo_sc_hs_inst/rbin_next_8_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(8),
  I0 => \fifo_sc_hs_inst/rbin\(6),
  I1 => \fifo_sc_hs_inst/rbin\(7),
  I2 => fifo_sc_hs_inst_rbin_next_6,
  I3 => \fifo_sc_hs_inst/rbin\(8));
\fifo_sc_hs_inst/n7_s1\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => fifo_sc_hs_inst_n7_5,
  I0 => \fifo_sc_hs_inst/Wnum\(1),
  I1 => \fifo_sc_hs_inst/Wnum\(6),
  I2 => \fifo_sc_hs_inst/Wnum\(7),
  I3 => \fifo_sc_hs_inst/Wnum\(8));
\fifo_sc_hs_inst/n7_s2\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => fifo_sc_hs_inst_n7_6,
  I0 => \fifo_sc_hs_inst/Wnum\(2),
  I1 => \fifo_sc_hs_inst/Wnum\(3),
  I2 => \fifo_sc_hs_inst/Wnum\(4),
  I3 => \fifo_sc_hs_inst/Wnum\(5));
\fifo_sc_hs_inst/mem_s177\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => fifo_sc_hs_inst_mem_322,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I2 => \fifo_sc_hs_inst/wbin\(6));
\fifo_sc_hs_inst/mem_s178\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => fifo_sc_hs_inst_mem_323,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => \fifo_sc_hs_inst/wbin\(6),
  I2 => \fifo_sc_hs_inst/wbin\(4));
\fifo_sc_hs_inst/mem_s179\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => fifo_sc_hs_inst_mem_324,
  I0 => \fifo_sc_hs_inst/wbin\(4),
  I1 => \fifo_sc_hs_inst/wbin\(6),
  I2 => \fifo_sc_hs_inst/wbin\(5));
\fifo_sc_hs_inst/mem_s180\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_325,
  I0 => \fifo_sc_hs_inst/wbin\(6),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I2 => \fifo_sc_hs_inst/wbin\(5));
\fifo_sc_hs_inst/mem_s181\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => fifo_sc_hs_inst_mem_326,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I2 => \fifo_sc_hs_inst/wbin\(6));
\fifo_sc_hs_inst/mem_s182\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_327,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I2 => \fifo_sc_hs_inst/wbin\(6));
\fifo_sc_hs_inst/mem_s183\: LUT3
generic map (
  INIT => X"40"
)
port map (
  F => fifo_sc_hs_inst_mem_328,
  I0 => \fifo_sc_hs_inst/wbin\(4),
  I1 => \fifo_sc_hs_inst/wbin\(5),
  I2 => \fifo_sc_hs_inst/wbin\(6));
\fifo_sc_hs_inst/mem_s184\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => fifo_sc_hs_inst_mem_329,
  I0 => \fifo_sc_hs_inst/wbin\(5),
  I1 => \fifo_sc_hs_inst/wbin\(4),
  I2 => \fifo_sc_hs_inst/wbin\(6));
\fifo_sc_hs_inst/rbin_next_2_s5\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => fifo_sc_hs_inst_rbin_next_2,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_sc_hs_inst/rbin\(0),
  I3 => \fifo_sc_hs_inst/rbin\(1));
\fifo_sc_hs_inst/rbin_next_4_s5\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => fifo_sc_hs_inst_rbin_next_4,
  I0 => \fifo_sc_hs_inst/rbin\(2),
  I1 => \fifo_sc_hs_inst/rbin\(3));
\fifo_sc_hs_inst/rbin_next_6_s5\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => fifo_sc_hs_inst_rbin_next_6,
  I0 => \fifo_sc_hs_inst/rbin\(4),
  I1 => \fifo_sc_hs_inst/rbin\(5),
  I2 => fifo_sc_hs_inst_rbin_next_2,
  I3 => fifo_sc_hs_inst_rbin_next_4);
\fifo_sc_hs_inst/rbin_next_4_s6\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(4),
  I0 => fifo_sc_hs_inst_rbin_next_2,
  I1 => \fifo_sc_hs_inst/rbin\(2),
  I2 => \fifo_sc_hs_inst/rbin\(3),
  I3 => \fifo_sc_hs_inst/rbin\(4));
\fifo_sc_hs_inst/rbin_next_1_s5\: LUT4
generic map (
  INIT => X"DF20"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(1),
  I0 => \fifo_sc_hs_inst/rbin\(0),
  I1 => NN,
  I2 => RdEn,
  I3 => \fifo_sc_hs_inst/rbin\(1));
\fifo_sc_hs_inst/rbin_next_0_s111\: LUT3
generic map (
  INIT => X"9A"
)
port map (
  F => \fifo_sc_hs_inst/rbin_next\(0),
  I0 => \fifo_sc_hs_inst/rbin\(0),
  I1 => NN,
  I2 => RdEn);
\fifo_sc_hs_inst/Wnum_8_s4\: LUT3
generic map (
  INIT => X"9A"
)
port map (
  F => fifo_sc_hs_inst_Wnum_8,
  I0 => fifo_sc_hs_inst_n7,
  I1 => NN,
  I2 => RdEn);
\fifo_sc_hs_inst/n112_s2\: LUT3
generic map (
  INIT => X"B0"
)
port map (
  F => fifo_sc_hs_inst_n112,
  I0 => NN,
  I1 => RdEn,
  I2 => fifo_sc_hs_inst_n7);
\fifo_sc_hs_inst/n112_1_s1\: LUT3
generic map (
  INIT => X"4F"
)
port map (
  F => fifo_sc_hs_inst_n112_1,
  I0 => NN,
  I1 => RdEn,
  I2 => fifo_sc_hs_inst_n7);
\fifo_sc_hs_inst/rempty_val_s1\: INV
port map (
  O => fifo_sc_hs_inst_rempty_val,
  I => fifo_sc_hs_inst_n199_3);
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
end beh;
