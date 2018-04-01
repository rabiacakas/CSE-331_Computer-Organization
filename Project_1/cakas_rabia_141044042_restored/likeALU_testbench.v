`define DELAY 20
module likeALU_testbench();
reg [4:0]in_A, in_B;
reg [1:0] selectBit;
wire [4:0] outputFinal;

likeALU testing(outputFinal,in_A, in_B, selectBit);

initial begin
in_A= 5'b11110; in_B = 5'b10111; selectBit = 2'b00;
#`DELAY;
in_A= 5'b11111; in_B = 5'b11111; selectBit = 2'b01;
#`DELAY;
in_A= 5'b11010; in_B = 5'b11010; selectBit = 2'b10;
#`DELAY;
in_A= 5'b11111; in_B = 5'b11110; selectBit = 2'b11;
#`DELAY;
end
 
 
initial
begin
$monitor("time = %2d, in_A=%5b, in_B=%5b, selectBit=%2b, out=%5b", $time, in_A, in_B, selectBit, outputFinal);
end
 
endmodule