
module full_adder_1(
  input in_1,in_2,in_3,
  output sum,carry
);
  
 half_adder_1 HAF1(.in_1(in_1),.in_2(in_2),.sum(s1),.carry(c1));
 half_adder_1 HAF2(.in_1(s1),.in_2(in_3),.sum(sum),.carry(c2));

 or_1 OR1(.in_1(c1),.in_2(c2),.out(carry));
 endmodule
 module full_adder_4(
   input[3:0]in_1,in_2,in_3,
   output[3:0]sum,carry
 ); 
   wire[3:0]s2,w1,w2;
  half_adder_4 HAF1(.in_1(in_1),.in_2(in_2),.sum(s2),.carry(w1));
  half_adder_4 HAF2(.in_1(s2),.in_2(in_3),.sum(sum),.carry(w2));
  
  or_4 OR1(.in_1(w1),.in_2(w2),.out(carry));
endmodule
module full_adder_8(
   input[7:0]in_1,in_2,in_3,
   output[7:0] sum,carry
);
   wire [7:0] s3,w1,w2;
   half_adder_8 HAF1(.in_1(in_1),.in_2(in_2),.sum(s3),.carry(w1));
   half_adder_8 HAF2(.in_1(s3),.in_2(in_3),.sum(sum),.carry(w2));
  
   or_8 OR1(.in_1(w1),.in_2(w2),.out(carry));
 endmodule
module full_adder_16(
   input[15:0]in_1,in_2,in_3,
   output[15:0] sum,carry
);
   wire [15:0] s4,w1,w2;
   half_adder_16 HAF1(.in_1(in_1),.in_2(in_2),.sum(s4),.carry(w1));
   half_adder_16 HAF2(.in_1(s4),.in_2(in_3),.sum(sum),.carry(w2));
  
   or_16 OR1(.in_1(w1),.in_2(w2),.out(carry));
 endmodule
 module full_adder_32(
   input[31:0]in_1,in_2,in_3,
   output[31:0] sum,carry
);
   wire [31:0] s5,w1,w2;
   half_adder_32 HAF1(.in_1(in_1),.in_2(in_2),.sum(s5),.carry(w1));
   half_adder_32 HAF2(.in_1(s5),.in_2(in_3),.sum(sum),.carry(w2));
  
   or_32 OR1(.in_1(w1),.in_2(w2),.out(carry));
 endmodule
 module full_adder_64(
   input[63:0]in_1,in_2,in_3,
   output[63:0] sum,carry
);
   wire [63:0] s6,w1,w2;
   half_adder_64 HAF1(.in_1(in_1),.in_2(in_2),.sum(s6),.carry(w1));
   half_adder_64 HAF2(.in_1(s6),.in_2(in_3),.sum(sum),.carry(w2));
  
   or_64 OR1(.in_1(w1),.in_2(w2),.out(carry));
 endmodule

 





 
