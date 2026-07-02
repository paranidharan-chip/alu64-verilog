module comparator_64(
  input [63:0] in_1,in_2,
  output gt,eq,lt
);
wire[63:0] d_out;
wire borrow;
  subtractor_64 SUB1(
    .in_1(in_1[63:0]),
    .in_2(in_2[63:0]),
    .diff(d_out),
    .borrow(borrow)

  );
   assign eq= (d_out==64'b0);
   assign lt=borrow;
   assign gt=~eq&~lt;
endmodule

