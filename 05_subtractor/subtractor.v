module subtractor_64(
  input [63:0]in_1,in_2,
  output [63:0] diff,
  output borrow
);
  wire[63:0] not_in_2;
  wire carry_out;
 not_64 NOT1(
   .in(in_2[63:0]),
   .out(not_in_2[63:0])
 );
  rca_64 RCA1(
    .in_1(in_1[63:0]),
    .in_2(not_in_2[63:0]),
    .in_3(1'b1),
    .sum(diff[63:0]),
    .cout(carry_out)
  );
  assign borrow=~carry_out;
  endmodule

