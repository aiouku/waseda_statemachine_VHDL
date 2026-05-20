transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myor2.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mynot.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mydiff.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myand2.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/state_machine1/state_machine1.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/state_machine1/state_machine1_test.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/state_machine1/state_machine2.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/state_machine1/state_machine2_test.vhd}

