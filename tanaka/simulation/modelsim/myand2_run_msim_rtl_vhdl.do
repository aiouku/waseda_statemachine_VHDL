transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mynot_test.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mynot.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myand2.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myand2_test.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myor2.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/myor2_test.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mydiff.vhd}
vcom -93 -work work {C:/Users/jkrta/OneDrive/Documents/HardWare/tanaka/mydiff_test.vhd}

