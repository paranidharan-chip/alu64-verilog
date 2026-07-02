module alu_64(
  input[63:0] in_1,in_2,
  input[3:0]opcode,
  input[5:0]shamt,
  output  [63:0]result,
  output zero,carry,overflow,negative,gt,eq,lt
);
 //internal wire
 wire[63:0]and_result,or_result,not_result,xor_result,xnor_result,add_result,sub_result,lsl_result,lsr_result,asr_result,inc_out,dec_out,nand_result,nor_result,
   pass_result;
 wire add_carry,sub_borrow,cmp_gt,cmp_eq,cmp_lt;
//required modules 
 assign pass_result=in_1;
 and_64 AND1(
   .in_1(in_1),
   .in_2(in_2),
   .out(and_result)
 );
  
 or_64 OR1(
   .in_1(in_1),
   .in_2(in_2),
   .out(or_result)
 );

 xor_64 XOR1(
   .in_1(in_1),
   .in_2(in_2),
   .out(xor_result)
 );

 not_64 NOT1(
   .in(in_1),
   .out(not_result)
 );

 xnor_64 XNOR1(
   .in_1(in_1),
   .in_2(in_2),
   .out(xnor_result)
 );

 adder_64 ADD(
   .in_1(in_1),
   .in_2(in_2),
   .sum(add_result),
   .carry(add_carry)
 );
 
 subtractor_64 SUB(
   .in_1(in_1),
   .in_2(in_2),
   .diff(sub_result),
   .borrow(sub_borrow)
 );

 comparator_64 CMP(
   .in_1(in_1),
   .in_2(in_2),
   .gt(cmp_gt),
   .eq(cmp_eq),
   .lt(cmp_lt)
 );
  
 lsl_64 LSL1(
   .in(in_1),
   .amt(shamt),
   .out(lsl_result)
 );
 
 lsr_64 LSR1(
   .in(in_1),
   .amt(shamt),
   .out(lsr_result)
 );
 
 asr_64 ASR1(
   .in(in_1),
   .amt(shamt),
   .out(asr_result)
 );
 inc_64 INC(
   .in_1(in_1),
   .out(inc_out)
 );
 dec_64 DEC(
   .in_1(in_1),
   .out(dec_out)
 );
 nor_64 NOR1(
    .in_1(in_1),
    .in_2(in_2),
    .out(nor_result)
 );
 nand_64 NAND1(
   .in_1(in_1),
   .in_2(in_2),
   .out(nand_result)
 );

   //opcode 4-bit
  //0000-add,0001-sub,0010-and,0011-0r,0100-not,0101-xor,0110-xnor,0111-lsl,
  //1000-lsr,1001-asr,1010-cmp 
 /*always@(*) begin 
      case(opcode)
        4'b0000:result=add_result;
        4'b0001:result=sub_result;
        4'b0010:result=and_result;
        4'b0011:result=or_result;
        4'b0100:result=not_result;
        4'b0101:result=xor_result;
        4'b0110:result=xnor_result;
        4'b0111:result=lsl_result;
        4'b1000:result=lsr_result;
        4'b1001:result=asr_result;
        4'b1010:result=inc_out;
        4'b1011:result=dec_out;
        default:result=64'b0;
      endcase
    end */

  mux16X1_64 MUX1(
    .in_0(add_result),
    .in_1(sub_result),
    .in_2(and_result),
    .in_3(or_result),
    .in_4(nand_result),
    .in_5(nor_result),
    .in_6(xor_result),
    .in_7(xnor_result),
    .in_8(not_result),
    .in_9(inc_out),
    .in_10(dec_out),
    .in_11(lsl_result),
    .in_12(lsr_result),
    .in_13(asr_result),
    .in_14(pass_result),
    .in_15(64'b0),// cmp
    .sel(opcode),
    .out(result)
  );

    //flag-output
  assign zero= (result==64'b0);
  assign negative=result[63];
  assign carry= (opcode == 4'b0000) ? add_carry:sub_borrow;
  assign overflow= (opcode==4'b0000)? (~in_1[63]&~in_2[63]&result[63])||(in_1[63]&in_2[63]&~result[63]):(in_1[63]&~in_2[63]&~result[63])||(
                    ~in_1[63]&in_2[63]&result[63]);

  assign gt=cmp_gt;
  assign eq=cmp_eq;
  assign lt=cmp_lt;

endmodule







