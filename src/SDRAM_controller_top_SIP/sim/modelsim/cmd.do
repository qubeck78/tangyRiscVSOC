
## part 1: new lib
vlib work
vmap work work

## part 2: load design
vlog -sv -f compile.f 


## part 3: sim design
vsim  -novopt work.tb

## part 4: add signals
add wave -position insertpoint sim:/tb/*


## part 5: show ui 
view wave
view structure
view signals

## part 6: run 
run -all