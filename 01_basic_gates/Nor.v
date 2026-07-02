module nor_1(
  input in_1,in_2,
  output out
);
 assign out=~(in_1|in_2);
 endmodule
 module nor_4(
   input[3:0]in_1,in_2,
   output [3:0]out
 );
  nor_1 NOR1(
    .in_1(in_1[0]),
    .in_2(in_2[0]),
    .out(out[0])
  );
   nor_1 NOR2(
    .in_1(in_1[1]),
    .in_2(in_2[1]),
    .out(out[1])
  );
    nor_1 NOR3(
    .in_1(in_1[2]),
    .in_2(in_2[2]),
    .out(out[2])
  );
     nor_1 NOR4(
    .in_1(in_1[3]),
    .in_2(in_2[3]),
    .out(out[3])
  );
  endmodule
  module nor_8(
    input[7:0]in_1,in_2,
    output[7:0]out
  );
   nor_4 NOR1(
     .in_1(in_1[3:0]),
     .in_2(in_2[3:0]),
     .out(out[3:0])
   );
   nor_4 NOR2(
     .in_1(in_1[7:4]),
     .in_2(in_2[7:4]),
     .out(out[7:4])
   );
   endmodule
   module nor_16(
     input[15:0]in_1,in_2,
     output[15:0]out
   );
     nor_8 NOR1(
       .in_1(in_1[7:0]),
       .in_2(in_2[7:0]),
       .out(out[7:0])
     );

     nor_8 NOR2(
       .in_1(in_1[15:8]),
       .in_2(in_2[15:8]),
       .out(out[15:8])
     );
    endmodule
    module nor_32(
      input[31:0]in_1,in_2,
      output[31:0]out
    );
     nor_16 NOR1(
       .in_1(in_1[15:0]),
       .in_2(in_2[15:0]),
       .out(out[15:0])
     );
      nor_16 NOR2(
       .in_1(in_1[31:16]),
       .in_2(in_2[31:16]),
       .out(out[31:16])
     );
     endmodule
     module nor_64(
       input[63:0]in_1,in_2,
       output[63:0]out
     );
      nor_32 NOR1(
        .in_1(in_1[31:0]),
        .in_2(in_2[31:0]),
        .out(out[31:0])
      );
       
      nor_32 NOR2(
         .in_1(in_1[63:32]),
         .in_2(in_2[63:32]),
         .out(out[63:32])
      );
     endmodule




