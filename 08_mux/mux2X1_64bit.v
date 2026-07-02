module mux2X1_64(
  input[63:0] in_0,in_1,
  input sel,
  output [63:0] out
); 
  assign out=sel?in_1:in_0;
  endmodule
  module mux4X1_64(
    input [63:0] in_0,in_1,in_2,in_3,
    input[1:0] sel,
    output [63:0] out
  );
    wire [63:0] s0,s1;
   mux2X1_64 MUX1(
     .in_0(in_0[63:0]),
     .in_1(in_1[63:0]),
     .sel(sel[0]),
     .out(s0[63:0])
   );
     mux2X1_64 MUX2(
     .in_0(in_2[63:0]),
     .in_1(in_3[63:0]),
     .sel(sel[0]),
     .out(s1[63:0])
   );
     mux2X1_64 MUX3(
     .in_0(s0[63:0]),
     .in_1(s1[63:0]),
     .sel(sel[1]),
     .out(out[63:0])
   );
 endmodule
 module mux8X1_64(
   input[63:0]in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,
   input[2:0] sel,
   output[63:0] out
 );
   wire[63:0] s0,s1;
   mux4X1_64 MUX1(
     .in_0(in_0[63:0]),
     .in_1(in_1[63:0]),
     .in_2(in_2[63:0]),
     .in_3(in_3[63:0]),
     .sel(sel[1:0]),
     .out(s0[63:0])
   );
     mux4X1_64 MUX2(
     .in_0(in_4[63:0]),
     .in_1(in_5[63:0]),
     .in_2(in_6[63:0]),
     .in_3(in_7[63:0]),
     .sel(sel[1:0]),
     .out(s1[63:0])
   );
     mux2X1_64 MUX3(
     .in_0(s0[63:0]),
     .in_1(s1[63:0]),
     .sel(sel[2]),
     .out(out[63:0])
   );
 endmodule
 module mux16X1_64(
   input[63:0]in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,in_9,in_10,in_11,in_12,in_13,in_14,in_15,
   input[3:0] sel,
   output[63:0] out
 );
   wire[63:0] s0,s1;
   mux8X1_64 MUX1(
     .in_0(in_0),
     .in_1(in_1),
     .in_2(in_2),
     .in_3(in_3),
     .in_4(in_4),
     .in_5(in_5),
     .in_6(in_6),
     .in_7(in_7),
     .sel(sel[2:0]),
     .out(s0)
   );
     mux8X1_64 MUX2(
     .in_0(in_8),
     .in_1(in_9),
     .in_2(in_10),
     .in_3(in_11),
     .in_4(in_12),
     .in_5(in_13),
     .in_6(in_14),
     .in_7(in_15),
     .sel(sel[2:0]),
     .out(s1)
   );
     mux2X1_64 MUX3(
     .in_0(s0),
     .in_1(s1),
     .sel(sel[3]),
     .out(out)
   );
 endmodule




    
    
 
 
