create_clock -name oscClock27 -period 37.037 -waveform {0 18.518} [get_ports {oscClock27}] -add 
create_clock -name extPllClock25 -period 40.0 -waveform {0 20.0} [get_ports {extPllClock25}] -add 
create_clock -name extPllClock12 -period 83.3333 -waveform {0 41.6666} [get_ports {extPllClock12}] -add   
