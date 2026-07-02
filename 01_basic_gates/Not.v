module not_1(
  input  in,
  output  out
);
 assign out =~(in);
 endmodule

 module not_4(
   input [3:0] in,
   output [3:0] out
 );
  not_1 NOT1(.in(in[0]),.out(out[0]));
  not_1 NOT2(.in(in[1]),.out(out[1]));
  not_1 NOT3(.in(in[2]),.out(out[2]));
  not_1 NOT4(.in(in[3]),.out(out[3]));
endmodule

module not_8(
  input [7:0]in,
  output [7:0] out
);
 not_4 NOT1(.in(in[3:0]),.out(out[3:0]));
 not_4 NOT2(.in(in[7:4]),.out(out[7:4]));

 endmodule

 module not_16(
   input [15:0] in,
   output [15:0] out
 );
   not_8 NOT1(.in(in[7:0]),.out(out[7:0]));
   not_8 NOT2(.in(in[15:8]),.out(out[15:8]));

 endmodule

 module not_32(
   input [31:0] in,
   output [31:0] out
 );
   not_16 NOT1(.in(in[15:0]),.out(out[15:0]));
   not_16 NOT2(.in(in[31:16]),.out(out[31:16]));
   
 endmodule

 module not_64(
   input [63:0]in,
   output [63:0] out
 );
   not_32 NOT1(.in(in[31:0]),.out(out[31:0]));
   not_32 NOT2(.in(in[63:32]),.out(out[63:32]));

 endmodule


