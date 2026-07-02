module lsr_64(
  input[63:0]in,
  input[5:0] amt,
  output[63:0]out
); 
 wire[63:0] s0,s1,s2,s3,s4;

  mux2X1_64 MUX1(
    .in_0(in),
    .in_1({1'b0,in[63:1]}),
    .sel(amt[0]),
    .out(s0)
  );
  mux2X1_64 MUX2(
    .in_0(s0),
    .in_1({2'b0,s0[63:2]}),
    .sel(amt[1]),
    .out(s1)
  );
  mux2X1_64 MUX3(
    .in_0(s1),
    .in_1({4'b0,s1[63:4]}),
    .sel(amt[2]),
    .out(s2)
  );
  mux2X1_64 MUX4(
    .in_0(s2),
    .in_1({8'b0,s2[63:8]}),
    .sel(amt[3]),
    .out(s3)
  );
  mux2X1_64 MUX5(
    .in_0(s3),
    .in_1({16'b0,s3[63:16]}),
    .sel(amt[4]),
    .out(s4)
  );
  mux2X1_64 MUX6(
    .in_0(s4),
    .in_1({32'b0,s4[63:32]}),
    .sel(amt[5]),
    .out(out)
  );
  endmodule


