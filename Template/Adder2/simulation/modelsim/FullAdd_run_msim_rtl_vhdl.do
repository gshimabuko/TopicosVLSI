transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/src/adder_pkg.vhd}
vcom -93 -work work {/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/src/adder.vhd}

do "/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim.tcl"
