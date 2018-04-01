module mips_testbench ();
reg clock;
wire result;

mips_core test(clock);

initial begin clock = 1'b0;
end
//intruction.mem content will change. Its just start point for you. 
//Please change it and try other instructions
initial begin
	#50 clock=~clock; #50 clock=~clock;
	//depend instruciton number 
end
//End of the test stage, you have to save register & data contents 
//to res_registers.mem , res_data.mem (create new files)
endmodule