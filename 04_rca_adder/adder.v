module adder_64(
  input[63:0]in_1,in_2,
  output[63:0]sum,
  output carry
);
 rca_64 RCA1(
   .in_1(in_1),
   .in_2(in_2),
   .in_3(1'b0),
   .sum(sum),
   .cout(carry)
 );
 endmodule
