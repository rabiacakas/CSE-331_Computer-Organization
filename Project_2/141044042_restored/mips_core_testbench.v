`define DELAY 10
module mips_core_testbench();

reg [31:0] instruction_set;
wire [31:0] result;

mips_core testing(instruction_set,result);
initial begin
instruction_set = 32'b00000000010000110101000000100000; #10; //ADD
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000000011001110101000000100001; #10; //ADDU
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000000101001000101000000100010; #10; //SUB
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b , Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000000011001110101000000100100; #10; //AND
#`DELAY;
$monitor("Instruction_set= %32b, Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000000011001110101000000100101; #10; //OR
#`DELAY;
$monitor("Instruction_set= %32b, Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000000111000010000100001000011; #10; //SRA
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000010111000010101000001000010; #10; //SRL
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000001111000110101000001000000; #10; //SLL
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result->Integer=%d",instruction_set, result, result);

instruction_set = 32'b00000001011001110101000000101011; #10; //SLTU
#`DELAY;
$monitor("Instruction_set= %32b Result->Binary=%32b, Result=%d",instruction_set, result, result);

end


endmodule