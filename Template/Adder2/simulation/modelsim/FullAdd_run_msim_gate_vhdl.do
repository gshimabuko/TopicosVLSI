transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {FullAdd_6_1200mv_85c_slow.vho}

do "/home/gshimabuko/Documents/Estudo/Digital_Electronics/vhdl/Topicos/Template/Adder2/sim.tcl"
