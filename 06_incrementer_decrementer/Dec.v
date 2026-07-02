module dec_64(
  input[63:0]in_1,
  output[63:0]out
  
);
  wire dec_borrow;
 subtractor_64 SUB(
   .in_1(in_1),
   .in_2(64'b1),
   .diff(out),
   .borrow(dec_borrow)
 );
 endmodule


