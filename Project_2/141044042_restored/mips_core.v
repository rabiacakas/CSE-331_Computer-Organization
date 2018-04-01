module mips_core(instruction, result);

input [31:0] instruction;
output [31:0] result;

wire [5:0] functionField;
wire [5:0] opcode;
wire [4:0] rsContent;
wire [4:0] rtContent;
wire [4:0] rdContent;
wire [31:0] read_data_1;
wire [31:0] read_data_2;
wire [31:0] write_data;

wire sig_read;
wire clk;

assign clk=1;
assign sig_read=0;
assign functionField = instruction[5:0];
assign rsContent = instruction[25:21];
assign rtContent = instruction[20:16];
assign rdContent = instruction[15:11];
assign opcode = instruction[31:26];

mips_registers readData(read_data_1, read_data_2, write_data, rsContent, rtContent, rdContent,sig_read, clk);

ALU calculateData(read_data_1, read_data_2, functionField, result);

endmodule