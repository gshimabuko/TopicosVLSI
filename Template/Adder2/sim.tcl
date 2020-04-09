vlib rtl_work
vmap work rtl_work
vmap work rtl_work
vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/src/adder_pkg.vhd
#vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/src/adder.vhd
vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/simulation/modelsim/FullAdd.vho

vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim/adder_tb_pkg.vhd 
vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim/Input_ROM.vhd 
vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim/Output_ROM.vhd 

vcom -reportprogress 300 -93 -work work /home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim/adder_tb.vhd 

vsim rtl_work.adder_tb




