Note:

1. 
  Cmd.do&compile.f: Modelsim simulation script. For reference only.

2.
  Currently, we do not provide simulation models. 
  If you need to use it, please contact Micron Technology official website to obtain it(MT48LC8M16A2 (2Meg x 16 x 4 Banks)).
  After obtaining the model file, you must change its name to "sdram_sim_model_64Mb_16bit.v" and store it in "../../model/".

3.
(1) In "Cmd.do" and "compile.f",the "prim_sim.v" file and the path should be modified or added by the Users. 
(2) "prim_sim.v" is a primitive library. Users need to add appropriate primitives according to the Device which be used.
(3) The "prim_sim.v" can be obtained from the Software installation directory. Its reference path is like "Gowin_v1.*\IDE\simlib"
(4) Users can also create simulation library files of Modelsim by themselves, and connect the work to the simulation library.