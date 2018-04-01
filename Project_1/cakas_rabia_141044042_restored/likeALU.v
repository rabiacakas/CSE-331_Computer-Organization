module likeALU(out,inp_A, inp_B, select);
input [4:0]inp_A;
input [4:0]inp_B;
input [1:0]select;
wire carry;
wire carry0=0;
wire [4:0]resAndOutput;
wire [4:0]resAddOutput;
wire [4:0]resOrOutput;
wire [4:0]resXorOutput;

wire [4:0]result1;
wire [4:0]result2;
wire [4:0]result3;
wire [4:0]result4;
output [4:0]out;
wire not0;
wire not1;
//selectBits=00 olma durumu icin and resAndOutput
and(resAndOutput[0], inp_A[0], inp_B[0]);
and(resAndOutput[1], inp_A[1], inp_B[1]);
and(resAndOutput[2], inp_A[2], inp_B[2]);
and(resAndOutput[3], inp_A[3], inp_B[3]);
and(resAndOutput[4], inp_A[4], inp_B[4]);

//selectBits=01 olma durumu icin resAddOutput
_5bit_adder add5bits(resAddOutput, carry, inp_A, inp_B, carry0);

//selectBits=10 olma durumu icin and resOrOutput
or(resOrOutput[0], inp_A[0], inp_B[0]);
or(resOrOutput[1], inp_A[1], inp_B[1]);
or(resOrOutput[2], inp_A[2], inp_B[2]);
or(resOrOutput[3], inp_A[3], inp_B[3]);
or(resOrOutput[4], inp_A[4], inp_B[4]);


//selectBits=11 olma durumu icin and resXorOutput
xor(resXorOutput[0], inp_A[0], inp_B[0]);
xor(resXorOutput[1], inp_A[1], inp_B[1]);
xor(resXorOutput[2], inp_A[2], inp_B[2]);
xor(resXorOutput[3], inp_A[3], inp_B[3]);
xor(resXorOutput[4], inp_A[4], inp_B[4]);

//mux icerisinde kullanılmak uzere ilk bit not0, ikincisi not1
not(not0, select[0]);
not(not1, select[1]);

and(result1[0], not0, not1, resAndOutput[0]);
and(result1[1], not0, not1, resAndOutput[1]);
and(result1[2], not0, not1, resAndOutput[2]);
and(result1[3], not0, not1, resAndOutput[3]);
and(result1[4], not0, not1, resAndOutput[4]);

and(result2[0], select[0], not1, resAddOutput[0]);
and(result2[1], select[0], not1, resAddOutput[1]);
and(result2[2], select[0], not1, resAddOutput[2]);
and(result2[3], select[0], not1, resAddOutput[3]);
and(result2[4], select[0], not1, resAddOutput[4]);

and(result3[0], not0, select[1], resOrOutput[0]);
and(result3[1], not0, select[1], resOrOutput[1]);
and(result3[2], not0, select[1], resOrOutput[2]);
and(result3[3], not0, select[1], resOrOutput[3]);
and(result3[4], not0, select[1], resOrOutput[4]);

and(result4[0], select[0], select[1], resXorOutput[0]);
and(result4[1], select[0], select[1], resXorOutput[1]);
and(result4[2], select[0], select[1], resXorOutput[2]);
and(result4[3], select[0], select[1], resXorOutput[3]);
and(result4[4], select[0], select[1], resXorOutput[4]);

or(out[0], result1[0], result2[0], result3[0], result4[0]);
or(out[1], result1[1], result2[1], result3[1], result4[1]);
or(out[2], result1[2], result2[2], result3[2], result4[2]);
or(out[3], result1[3], result2[3], result3[3], result4[3]);
or(out[4], result1[4], result2[4], result3[4], result4[4]);

endmodule