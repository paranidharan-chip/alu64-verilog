module inc_64(
  input[63:0]in_1,
  output[63:0]out
  
);
  wire inc_carry;
 adder_64 ADD(
   .in_1(in_1),
   .in_2(64'b1),
   .sum(out),
   .carry(inc_carry)
 );
 endmodule

