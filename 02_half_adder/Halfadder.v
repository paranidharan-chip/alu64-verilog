
module half_adder_1(
  input in_1,in_2,
  output sum,carry
);
  xor_1 XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
  and_1 AND1(.in_1(in_1),.in_2(in_2),.out(carry));
  endmodule
module half_adder_4(
  input[3:0] in_1,in_2,
  output [3:0]sum,carry
);
  xor_4 XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
  and_4 AND1(.in_1(in_1),.in_2(in_2),.out(carry));
  endmodule
module half_adder_8(
  input[7:0]in_1,in_2,
  output[7:0] sum,carry
);
 xor_8  XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
 and_8  AND1(.in_1(in_1),.in_2(in_2),.out(carry));
 endmodule
 module half_adder_16(
   input[15:0]in_1,in_2,
   output[15:0]sum,carry
 );
   xor_16   XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
   and_16 AND1(.in_1(in_1),.in_2(in_2),.out(carry));

 endmodule

 module half_adder_32(
   input [31:0]in_1,in_2,
   output [31:0]sum,carry
 );
   xor_32 XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
   and_32 AND1(.in_1(in_1),.in_2(in_2),.out(carry));

 endmodule

 module half_adder_64(
   input[63:0]in_1,in_2,
   output[63:0]sum,carry
 );
   xor_64 XOR1(.in_1(in_1),.in_2(in_2),.out(sum));
   and_64 AND1(.in_1(in_1),.in_2(in_2),.out(carry));
   endmodule

