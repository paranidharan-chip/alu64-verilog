module xnor_1(
  input in_1,in_2,
  output out
);

 assign out=~(in_1^in_2);
 endmodule

 module xnor_4(
   input[3:0] in_1,in_2,
   output [3:0] out
 );
   xnor_1 XNOR1(.in_1(in_1[0]),.in_2(in_2[0]),.out(out[0]));
   xnor_1 XNOR2(.in_1(in_1[1]),.in_2(in_2[1]),.out(out[1]));
   xnor_1 XNOR3(.in_1(in_1[2]),.in_2(in_2[2]),.out(out[2]));
   xnor_1 XNOR4(.in_1(in_1[3]),.in_2(in_2[3]),.out(out[3]));

 endmodule

 module xnor_8(
   input [7:0]in_1,in_2,
   output [7:0] out
 );
   xnor_4 XNOR1(.in_1(in_1[3:0]),.in_2(in_2[3:0]),.out(out[3:0]));
   xnor_4 XNOR2(.in_1(in_1[7:4]),.in_2(in_2[7:4]),.out(out[7:4]));

 endmodule

 module xnor_16(
   input [15:0] in_1,in_2,
   output [15:0] out
 );
   xnor_8 XNOR1(.in_1(in_1[7:0]),.in_2(in_2[7:0]),.out(out[7:0]));
   xnor_8 XNOR2(.in_1(in_1[15:8]),.in_2(in_2[15:8]),.out(out[15:8]));
 endmodule

 module xnor_32(
   input [31:0] in_1,in_2,
   output [31:0] out
 );
   xnor_16 XNOR1(.in_1(in_1[15:0]),.in_2(in_2[15:0]),.out(out[15:0]));
   xnor_16 XNOR2(.in_1(in_1[31:16]),.in_2(in_2[31:16]),.out(out[31:16]));

 endmodule

 module xnor_64(
   input [63:0]in_1,in_2,
   output [63:0] out
 );
   xnor_32  XNOR1(.in_1(in_1[31:0]),.in_2(in_2[31:0]),.out(out[31:0]));
   xnor_32  XNOR2(.in_1(in_1[63:32]),.in_2(in_2[63:32]),.out(out[63:32]));

 endmodule


