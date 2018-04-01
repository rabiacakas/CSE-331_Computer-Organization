transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored {C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored/likeALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored {C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored/_5bit_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored {C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored {C:/Users/rabia/Desktop/141044042/PART2/cakas_rabia_141044042_restored/half_adder.v}

