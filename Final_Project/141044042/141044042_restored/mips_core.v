module mips_core(clock);
input clock;

wire [31:0] instruction;
wire RegDest,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
wire Jump,Lbu,Lhu,Lui,Slti,Sltiu,Sb,Sh;
wire oldContentRt,newContentRt;
wire JandRegW;

wire [1:0] ALUOp;				
wire [2:0] ALUcontrol;
wire [5:0] opcode;
wire [4:0] rs; 
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [5:0] functionfield;

wire [15:0] signImmediate;		
wire [25:0] targetadress;

wire [7:0] pc_temp;
wire [7:0]temp_PC1;			
wire [7:0]temp_PC2;
wire [31:0] write_temp;
wire [31:0] write_regy;
wire [31:0] write_data_y2;
wire [31:0] write_data_y;
wire [31:0] write_data_y1;

wire [5:0] NOTofOpcode;
wire [5:0] NOTFunctionCode;
wire [2:0] opandfunc;
wire [1:0] opandfunc2;

wire [31:0] signextend32Bit;
wire [31:0] shiftLeftLogical; 
wire [31:0] notaludata;
wire [1:0]  alubranch;
wire [31:0] contentOfRS;
wire [31:0] ContentRT;
wire [31:0] ALU_data;
wire [31:0] read_data;
wire [31:0] mem_data;
wire [31:0] write_data;

wire [31:0] AluSecondContent;
wire [31:0] AluFirstContent;

reg [7:0] program_counter;	
reg [15:0]a;
reg [15:0]b;
initial begin
	
	a=16'b0000000000000000;
	b=16'b1111111111111111;
end
mips_instr_mem x(instruction, program_counter);
mips_control y(instruction[31:26],RegDest,Branch,MemRead,MemtoReg,ALUOp[1:0],MemWrite,ALUSrc,RegWrite,Jump,Lbu,Lhu,Lui,Sb,Sh);

assign opcode = instruction[31:26];
assign rs = instruction[25:21];				
assign rt= instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign functionfield = instruction[5:0];

assign signImmediate = instruction[15:0];
assign targetadress = instruction[25:0];

assign signextend32Bit = (signImmediate[15]== 1'b0)?{a,signImmediate}:{b,signImmediate};

assign shiftLeftLogical = signextend32Bit << 2;

//Sonraki instruction PC counter ini temp_PC1
assign temp_PC1 = program_counter + 4 ;    

//temp_PC2 = ProgramCounter*4 + 4   
assign temp_PC2 = temp_PC1+ shiftLeftLogical[7:0];

// Rs ve Rd register
assign write_reg = (RegDest == 1'b1) ? rd : rt;

//RegWrite
mips_registers z(contentOfRS, Cont,32'b00000000000000000000000000000000,rs, rt, write_reg,0, clk);

//32 Bit Sign Extend ile Rt contentinin secimi
assign AluSecondContent = (ALUSrc == 1'b1) ? signextend32Bit : ContentRT;

// !Opcode 
not(NOTofOpcode[0],opcode[0]);
not(NOTofOpcode[1],opcode[1]);
not(NOTofOpcode[2],opcode[2]);
not(NOTofOpcode[3],opcode[3]);
not(NOTofOpcode[4],opcode[4]);
not(NOTofOpcode[5],opcode[5]);

// !Functionfield
not(NOTFunctionCode[0],functionfield[0]);
not(NOTFunctionCode[1],functionfield[1]);
not(NOTFunctionCode[2],functionfield[2]);
not(NOTFunctionCode[3],functionfield[3]);
not(NOTFunctionCode[4],functionfield[4]);
not(NOTFunctionCode[5],functionfield[5]);

// Functionfield & Opcode
and(opandfunc[0],NOTFunctionCode[0],NOTFunctionCode[1],NOTFunctionCode[2],NOTFunctionCode[3],NOTFunctionCode[4],NOTFunctionCode[5]);
and(opandfunc[1],NOTofOpcode[0],NOTofOpcode[1],NOTofOpcode[2],NOTofOpcode[3],NOTofOpcode[4],NOTofOpcode[5]);
and(opandfunc[2],opandfunc[0],opandfunc[1]);

and(opandfunc2[0],NOTFunctionCode[0],functionfield[1],NOTFunctionCode[2],NOTFunctionCode[3],NOTFunctionCode[4],NOTFunctionCode[5]);
and(opandfunc2[1],opandfunc2[0],opandfunc[1]);

//ALU baslangic contenti
assign AluFirstContent = 
(opandfunc[2] == 1'b1) ? {27'b000000000000000000000000000,shamt}:(
(opandfunc2[1] == 1'b1) ? {27'b000000000000000000000000000,shamt}:contentOfRS);

ALU_control t(ALUcontrol,opcode,functionfield,ALUOp);
ALU p(ALUcontrol,AluFirstContent,AluSecondContent,ALU_data);

wire tempBranch;
wire res1=ALU_data==32'b0;
wire res2=~res1;
wire res3,res4;

and(res3,res1,Branch);
and(res4,res2,Branch);

or(tempBranch,res3,res4);

//Branch Equal , Branch Not Equal ve Jump instructionları
assign pc_temp = (tempBranch == 1'b1) ? temp_PC2 :(
(Jump==1'b1)? {targetadress[5:0],2'b00} :temp_PC1);

//Program Counter== $rs 
initial program_counter = (opcode==6'b0)?((functionfield == 6'b001000)? contentOfRS:pc_temp):pc_temp;

assign oldContentRt = (Sb == 1)? {24'b0,ContentRT[7:0]} : ContentRT;
assign newContentRt = (Sh == 1)? {16'b0,ContentRT[15:0]}:oldContentRt;

mips_data_mem k(read_data, ALU_data, newContentRt, MemRead, MemWrite);

//instruction JumpAndLink control
and(JandRegW,Jump,RegWrite);

//instruction JumpAndLink ise PC + 4
assign write_temp = (MemtoReg)? read_data:ALU_data ;
assign write_data = (JandRegW)? {24'b0,temp_PC1}:write_temp ;

assign write_regy = (JandRegW)? {27'b0,5'b11111}:write_reg ;
assign write_data_y = (Lbu==1)?{24'b0,write_data[7:0]}:write_data;
assign write_data_y1 = (Lhu==1)?{16'b0,write_data[15:0]}:write_data_y;  
assign write_data_y2 = (Lui == 1)?{signImmediate,16'b0}:write_data_y1;
		
mips_registers f(contentOfRS, ContentRT,write_data_y2,rs, rt, write_regy,RegWrite,clock);

//pc counter bir sonraki instruction icin 4 arttırıldı.
initial program_counter = program_counter + 4;

endmodule