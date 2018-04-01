module ALU(Op[2:0],rs[31:0],rt[31:0],result[31:0]);
input [2:0] Op;
input [31:0] rs;
input [31:0] rt;
output [31:0] result;

wire [31:0]andWire;
wire [31:0]orWire;
wire [31:0]resultofAdd;
wire [31:0]resultofSub;
wire [31:0]resultofSlt;

and(andWire[0],rs[0],rt[0]);
and(andWire[1],rs[1],rt[1]);
and(andWire[2],rs[2],rt[2]);
and(andWire[3],rs[3],rt[3]);
and(andWire[4],rs[4],rt[4]);
and(andWire[5],rs[5],rt[5]);
and(andWire[6],rs[6],rt[6]);
and(andWire[7],rs[7],rt[7]);
and(andWire[8],rs[8],rt[8]);
and(andWire[9],rs[9],rt[9]);
and(andWire[10],rs[10],rt[10]);
and(andWire[11],rs[11],rt[11]);
and(andWire[12],rs[12],rt[12]);
and(andWire[13],rs[13],rt[13]);
and(andWire[14],rs[14],rt[14]);
and(andWire[15],rs[15],rt[15]);
and(andWire[16],rs[16],rt[16]);
and(andWire[17],rs[17],rt[17]);
and(andWire[18],rs[18],rt[18]);
and(andWire[19],rs[19],rt[19]);
and(andWire[20],rs[20],rt[20]);
and(andWire[21],rs[21],rt[21]);
and(andWire[22],rs[22],rt[22]);
and(andWire[23],rs[23],rt[23]);
and(andWire[24],rs[24],rt[24]);
and(andWire[25],rs[25],rt[25]);
and(andWire[26],rs[26],rt[26]);
and(andWire[27],rs[27],rt[27]);
and(andWire[28],rs[28],rt[28]);
and(andWire[29],rs[29],rt[29]);
and(andWire[30],rs[30],rt[30]);
and(andWire[31],rs[31],rt[31]);

or(orWire[0],rs[0],rt[0]);
or(orWire[1],rs[1],rt[1]);
or(orWire[2],rs[2],rt[2]);
or(orWire[3],rs[3],rt[3]);
or(orWire[4],rs[4],rt[4]);
or(orWire[5],rs[5],rt[5]);
or(orWire[6],rs[6],rt[6]);
or(orWire[7],rs[7],rt[7]);
or(orWire[8],rs[8],rt[8]);
or(orWire[9],rs[9],rt[9]);
or(orWire[10],rs[10],rt[10]);
or(orWire[11],rs[11],rt[11]);
or(orWire[12],rs[12],rt[12]);
or(orWire[13],rs[13],rt[13]);
or(orWire[14],rs[14],rt[14]);
or(orWire[15],rs[15],rt[15]);
or(orWire[16],rs[16],rt[16]);
or(orWire[17],rs[17],rt[17]);
or(orWire[18],rs[18],rt[18]);
or(orWire[19],rs[19],rt[19]);
or(orWire[20],rs[20],rt[20]);
or(orWire[21],rs[21],rt[21]);
or(orWire[22],rs[22],rt[22]);
or(orWire[23],rs[23],rt[23]);
or(orWire[24],rs[24],rt[24]);
or(orWire[25],rs[25],rt[25]);
or(orWire[26],rs[26],rt[26]);
or(orWire[27],rs[27],rt[27]);
or(orWire[28],rs[28],rt[28]);
or(orWire[29],rs[29],rt[29]);
or(orWire[30],rs[30],rt[30]);
or(orWire[31],rs[31],rt[31]);

assign resultofAdd = rs+rt;
assign resultofSub = rs-rt;
assign resultofSlt = rs < rt ? 32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;

assign result =
(Op == 3'b000) ? andWire :
((Op == 3'b001) ? orWire :
((Op == 3'b010) ? resultofAdd :
((Op == 3'b110 ) ? resultofSub :
((Op == 3'b111 ) ? resultofSlt :
((Op == 3'b011 ) ? ~orWire :
((Op == 3'b101 ) ? rt << rs :
((Op == 3'b101 ) ? rt >> rs :
32'b00000000000000000000000000000000)))))));

endmodule