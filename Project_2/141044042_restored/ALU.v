module ALU(read_data_1, read_data_2, functionField, aluResult);

input [5:0] functionField;
input [31:0] read_data_1;
input [31:0] read_data_2;

output [31:0] aluResult;

assign aluResult = (functionField ==6'b100000)? read_data_1 + read_data_2://functionField add oldugunda rs+rt yi output a atar.
						 (functionField ==6'b100001)? read_data_1 + read_data_2://functionField addu oldugunda rs+rt yi output a atar.
						 (functionField ==6'b100010)? read_data_1 - read_data_2://functionField sub oldugunda rs-rt yi output a atar.
						 (functionField ==6'b100100)? read_data_1 & read_data_2://functionField and oldugunda rs&rt yi output a atar.
						 (functionField ==6'b100101)? read_data_1 | read_data_2://functionField or oldugunda rs|rt yi output a atar.
						 (functionField ==6'b000011)? read_data_1 >>> read_data_2://functionField sra oldugunda rs shift eder, output a atar.
						 (functionField ==6'b000010)? read_data_1 >> read_data_2://functionField srl oldugunda rs shift eder, output a atar.
						 (functionField ==6'b000000)? read_data_1 << read_data_2://functionField sll oldugunda rs shift eder, output a atar.
						 (functionField ==6'b101011)? (read_data_1 < read_data_2 ?
						 32'b0000000000000000000000000000001:
						 32'b0000000000000000000000000000000):0;//set on less than

				
endmodule