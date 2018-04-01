`define DELAY 10
module mips_registers_testbench();

	wire [31:0] read_data_1, read_data_2;
	reg [31:0] write_data;
	reg [4:0] read_reg_1, read_reg_2, write_reg;
	reg signal_reg_write, clk;
	
	mips_registers testForRegisters(read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg,signal_reg_write, clk);
initial begin
	read_reg_1 = 10000;
	read_reg_2 = 10001;
	write_reg = 00001;
	clk = 1;
	signal_reg_write = 0;
	#`DELAY;
	$monitor("read_data_1= %32b read_data_2=%32b",read_data_1, read_data_2);
end

endmodule