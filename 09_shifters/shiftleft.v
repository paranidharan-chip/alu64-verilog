module lsl_64(
  input[63:0]in,
  input[5:0] amt,
  output[63:0]out
); 
 wire[63:0] s0,s1,s2,s3,s4;

  mux2X1_64 MUX1(
    .in_0(in),
    .in_1({in[62:0],1'b0}),
    .sel(amt[0]),
    .out(s0)
  );
  mux2X1_64 MUX2(
    .in_0(s0),
    .in_1({s0[61:0],2'b0}),
    .sel(amt[1]),
    .out(s1)
  );
  mux2X1_64 MUX3(
    .in_0(s1),
    .in_1({s1[59:0],4'b0}),
    .sel(amt[2]),
    .out(s2)
  );
  mux2X1_64 MUX4(
    .in_0(s2),
    .in_1({s2[55:0],8'b0}),
    .sel(amt[3]),
    .out(s3)
  );
  mux2X1_64 MUX5(
    .in_0(s3),
    .in_1({s3[47:0],16'b0}),
    .sel(amt[4]),
    .out(s4)
  );
  mux2X1_64 MUX6(
    .in_0(s4),
    .in_1({s4[31:0],32'b0}),
    .sel(amt[5]),
    .out(out)
  );
  endmodule


