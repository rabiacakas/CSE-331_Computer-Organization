module mips_control(InstructionOPCode[5:0],RegDest,Branch,MemRead,MemtoReg,ALUOp[1:0],MemWrite,
							ALUSrc,RegWrite,Jump,Lbu,Lhu,Lui,Sb,Sh);
	
	input [5:0] InstructionOPCode;
	output RegDest,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	output Jump,Lbu,Lhu,Lui,Sb,Sh;
	output [1:0] ALUOp;
	
	wire NOTofInstr5,NOTofInstr4,NOTofInstr3,NOTofInstr2,NOTofInstr1,NOTofInstr0;
	wire lw,addi,addiu,andi,jal,Bneq,JumpTemp,Ori,Slti,Sltiu;
	
	//r type icin opcode u nandlendi
	not(NOTofInstr0,InstructionOPCode[0]);
	not(NOTofInstr1,InstructionOPCode[1]);
	not(NOTofInstr2,InstructionOPCode[2]);
	not(NOTofInstr3,InstructionOPCode[3]);
	not(NOTofInstr4,InstructionOPCode[4]);
	not(NOTofInstr5,InstructionOPCode[5]);
	
	// ALUOp 'lar üretildi
	and(ALUOp[1],NOTofInstr0,NOTofInstr1,NOTofInstr2,NOTofInstr3,NOTofInstr4,NOTofInstr5);
	and(ALUOp[0],NOTofInstr0,NOTofInstr1,InstructionOPCode[2],NOTofInstr3,NOTofInstr4,NOTofInstr5);
	
	//lbu
	and(Lbu,InstructionOPCode[5],NOTofInstr4,NOTofInstr3,InstructionOPCode[2],NOTofInstr1,NOTofInstr0);
	//lhu
	and(Lhu,InstructionOPCode[5],NOTofInstr4,NOTofInstr3,InstructionOPCode[2],NOTofInstr1,InstructionOPCode[0]); 
	//lui
	and(Lui,NOTofInstr5,InstructionOPCode[4],NOTofInstr3,InstructionOPCode[2],NOTofInstr1,InstructionOPCode[0]); 
	//slti
	and(Slti,NOTofInstr5,InstructionOPCode[4],NOTofInstr3,NOTofInstr2,NOTofInstr1,NOTofInstr0); 
	//sltiu
	and(Sltiu,NOTofInstr5,InstructionOPCode[4],NOTofInstr3,NOTofInstr2,NOTofInstr1,InstructionOPCode[0]); 
	//sb
	and(Sb,InstructionOPCode[5],NOTofInstr4,InstructionOPCode[3],NOTofInstr2,NOTofInstr1,NOTofInstr0); 
	//sh
	and(Sh,InstructionOPCode[5],NOTofInstr4,InstructionOPCode[3],NOTofInstr2,NOTofInstr1,InstructionOPCode[0]); 
	//Jump ve Jal
	and(JumpTemp,NOTofInstr5,NOTofInstr4,NOTofInstr3,NOTofInstr2,InstructionOPCode[1],NOTofInstr0); 
	
	//Jump and Link için RegWrite  
	and(jal,NOTofInstr5,NOTofInstr4,NOTofInstr3,NOTofInstr2,InstructionOPCode[1],InstructionOPCode[0]); 
	//ori için regwrite
	and(Ori,NOTofInstr5,InstructionOPCode[4],NOTofInstr3,NOTofInstr2,InstructionOPCode[1],InstructionOPCode[0]); 
	
	or(Jump,jal,JumpTemp);
	
	//addi
	and(addi,NOTofInstr0,NOTofInstr1,NOTofInstr2,InstructionOPCode[3],NOTofInstr4,NOTofInstr5);
	
	//addiu
	and(addiu,InstructionOPCode[0],NOTofInstr1,NOTofInstr2,InstructionOPCode[3],NOTofInstr4,NOTofInstr5);
	//andi
	and(andi,NOTofInstr0,InstructionOPCode[1],NOTofInstr2,NOTofInstr3,InstructionOPCode[4],NOTofInstr5);
	
	//Mem-Read
	and(MemRead,InstructionOPCode[0],InstructionOPCode[1],NOTofInstr2,NOTofInstr3,NOTofInstr4,InstructionOPCode[5]);
	
	//Reg - Dest
	assign RegDest = ALUOp[1];
	
	//MemtoReg
	or(MemtoReg,MemRead,Lbu);
	
	//Mem-Write sinyali ,sw ile
	and(MemWrite,InstructionOPCode[0],InstructionOPCode[1],NOTofInstr2,InstructionOPCode[3],NOTofInstr4,InstructionOPCode[5]);
	// Mew-Write sinyali , Sb ve Sh
	or(MewWrite,MewWrite,Sb,Sh);  
	
	//Branch ve Bneq
	and(Bneq,InstructionOPCode[0],NOTofInstr1,InstructionOPCode[2],NOTofInstr3,NOTofInstr4,NOTofInstr5);	
	or(Branch,Bneq,ALUOp[0]);  
	
	//Reg-Write
	or(RegWrite,RegDest,MemRead,addi,addiu,andi,jal,Lbu,Ori,Slti,Sltiu);
	
	//ALUSrc
	or(ALUSrc,RegDest,MemWrite,addi,addiu,andi,Lbu,Ori,Slti,Sltiu); 
		
endmodule