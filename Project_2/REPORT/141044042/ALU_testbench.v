`define DELAY 10
module ALU_testbench();
	reg [5:0] functionField;
	reg [31:0] read_data_1;
	reg [31:0] read_data_2;

	wire [31:0] aluResult;
	
	ALU testForALU(read_data_1, read_data_2, functionField, aluResult);
initial begin
	read_data_1 = 32'b00000000010000110101000000100000;
	read_data_2 = 32'b00000000011001110101000000100001;
	functionField = 100000;
	#`DELAY;
	$monitor("read_data_1= %32b read_data_2=%32b, functionField = %6b, result",read_data_1, read_data_2, functionField, aluResult);
end

endmodule