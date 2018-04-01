module ALU_control
(
	output wire [2:0] ALUcontrol,
	input [5:0] Op,Function,
	input [1:0] ALUop
);
assign ALUcontrol =
(Op == 6'b100011) ? 3'b010 :(	
(Op == 6'b101011) ? 3'b010 :( 
(Op == 6'b001000) ? 3'b010 :( 
(Op == 6'b001001) ? 3'b010 :( 
(Op == 6'b000100) ? 3'b110 :(	
(Op == 6'b010010) ? 3'b000 :( 
(Op == 6'b000101) ? 3'b110 :( 
(Op == 6'b100100) ? 3'b010 :( 
(Op == 6'b100101) ? 3'b010 :( 
(Op == 6'b010011) ? 3'b001 :( 
(Op == 6'b001010) ? 3'b111 :( 
(Op == 6'b001011) ? 3'b111 :( 
(Op == 6'b101000) ? 3'b010 :( 
(Op == 6'b101001) ? 3'b010 :( 
(Op == 6'b000000) ? (			
(Function == 6'b100000) ? 3'b010 :( 
(Function == 6'b100010) ? 3'b110 :( 
(Function == 6'b100011) ? 3'b110 :( 
(Function == 6'b100100) ? 3'b000 :( 
(Function == 6'b100101) ? 3'b001 :( 
(Function == 6'b101010) ? 3'b111 :( 
(Function == 6'b101011) ? 3'b111 :( 
(Function == 6'b100111) ? 3'b011 :( 
(Function == 6'b000000) ? 3'b101 :( 
(Function == 6'b000010) ? 3'b100 :  
3'b111
)))))))))) :3'b111))))))))))))));

endmodule