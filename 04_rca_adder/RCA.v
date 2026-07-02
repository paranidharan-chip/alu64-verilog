module rca_4(
  input[3:0] in_1,in_2,
  input in_3,
  output[3:0] sum,
  output cout
);
  full_adder_1 FUA1(
    .in_1(in_1[0]),
    .in_2(in_2[0]),
    .in_3(in_3),
    .sum(sum[0]),
    .carry(c1)
  );
  full_adder_1 FUA2(
    .in_1(in_1[1]),
    .in_2(in_2[1]),
    .in_3(c1),
    .sum(sum[1]),
    .carry(c2)
  );
  full_adder_1 FUA3(
    .in_1(in_1[2]),
    .in_2(in_2[2]),
    .in_3(c2),
    .sum(sum[2]),
    .carry(c3)
  );
  full_adder_1 FUA4(
    .in_1(in_1[3]),
    .in_2(in_2[3]),
    .in_3(c3),
    .sum(sum[3]),
    .carry(cout)
  );
endmodule

module rca_8(
  input[7:0] in_1,in_2,
  input in_3,
  output[7:0] sum,
  output cout
);

 rca_4 RCA1(
   .in_1(in_1[3:0]),
   .in_2(in_2[3:0]),
   .in_3(in_3),
   .sum(sum[3:0]),
   .cout(c1)
 );

 rca_4 RCA2(
     .in_1(in_1[7:4]),
     .in_2(in_2[7:4]),
     .in_3(c1),
     .sum(sum[7:4]),
     .cout(cout)
 );
 endmodule

 module rca_16(
   input[15:0]in_1,in_2,
   input in_3,
   output [15:0] sum,
   output cout
 );
  rca_8 RCA1(
    .in_1(in_1[7:0]),
    .in_2(in_2[7:0]),
    .in_3(in_3),
    .sum(sum[7:0]),
    .cout(c1)
  );
  rca_8 RCA2(
    .in_1(in_1[15:8]),
    .in_2(in_2[15:8]),
    .in_3(c1),
    .sum(sum[15:8]),
    .cout(cout)
   );
 endmodule
 module rca_32(
   input[31:0]in_1,in_2,
   input in_3,
   output [31:0] sum,
   output cout 
 );
  rca_16 RCA1(
    .in_1(in_1[15:0]),
    .in_2(in_2[15:0]),
    .in_3(in_3),
    .sum(sum[15:0]),
    .cout(c1)
  );
  rca_16 RCA2(
    .in_1(in_1[31:16]),
    .in_2(in_2[31:16]),
    .in_3(c1),
    .sum(sum[31:16]),
    .cout(cout)
   );
 endmodule
 module rca_64(
   input[63:0]in_1,in_2,
   input in_3,
   output[63:0] sum,
   output cout
 );
  rca_32 RCA1(
    .in_1(in_1[31:0]),
    .in_2(in_2[31:0]),
    .in_3(in_3),
    .sum(sum[31:0]),
    .cout(c1)
  );
  rca_32 RCA2(
    .in_1(in_1[63:32]),
    .in_2(in_2[63:32]),
    .in_3(c1),
    .sum(sum[63:32]),
    .cout(cout)
   );
 endmodule






