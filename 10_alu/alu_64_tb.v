module alu_64_tb();

reg  [63:0] in_1, in_2;
reg  [3:0]  opcode;
reg  [5:0]  shamt;

wire [63:0] result;
wire        carry;
wire        gt, eq, lt;
wire        zero, negative, overflow;

reg  [63:0] expected;

alu_64 uut(
  .in_1(in_1),
  .in_2(in_2),
  .opcode(opcode),
  .shamt(shamt),
  .result(result),
  .carry(carry),
  .gt(gt), .eq(eq), .lt(lt),
  .zero(zero),
  .negative(negative),
  .overflow(overflow)
);

initial begin
    $dumpfile("alu64.vcd");
    $dumpvars(0, alu_64_tb);

  // ── 0000 : ADD ───────────────────────────────────────
  $display("\n=== ADD (opcode=0000) ===");
  opcode = 4'b0000; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = in_1 + in_2;
    if (result == expected)
      $display("PASS ADD: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL ADD: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0001 : SUB ───────────────────────────────────────
  $display("\n=== SUB (opcode=0001) ===");
  opcode = 4'b0001; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = in_1 - in_2;
    if (result == expected)
      $display("PASS SUB: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL SUB: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0010 : AND ───────────────────────────────────────
  $display("\n=== AND (opcode=0010) ===");
  opcode = 4'b0010; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = in_1 & in_2;
    if (result == expected)
      $display("PASS AND: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL AND: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0011 : OR ────────────────────────────────────────
  $display("\n=== OR (opcode=0011) ===");
  opcode = 4'b0011; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = in_1 | in_2;
    if (result == expected)
      $display("PASS OR: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL OR: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0100 : NAND ───────────────────────────────────────
  $display("\n=== NAND (opcode=0100) ===");
  opcode = 4'b0100; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = ~(in_1 & in_2);
    if (result == expected)
      $display("PASS NAND: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL NAND: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0101 : NOR ──────────────────────────────────────
  $display("\n=== NOR (opcode=0101) ===");
  opcode = 4'b0101; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = ~(in_1 | in_2);
    if (result == expected)
      $display("PASS NOR: in_1=%h in_2=%h -> result=%h", in_1, in_2, result);
    else
      $display("FAIL NOR: in_1=%h in_2=%h -> result=%h exp=%h", in_1, in_2, result, expected);
  end

  // ── 0110 : X0R ───────────────────────────────────────
  $display("\n=== XOR (opcode=0110) ===");
  opcode = 4'b0110; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = in_1^in_2;
    if (result == expected)
      $display("PASS XOR: in_1=%h in_2=%h -> result=%h", in_1,in_2, result);
    else
      $display("FAIL XOR: in_1=%h in_2=%h -> result=%h exp=%h", in_1,in_2, result, expected);
  end
  // 0111-XNOR--
   $display("\n=== XNOR (opcode=0111) ===");
  opcode = 4'b0111; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    expected = ~(in_1^in_2);
    if (result == expected)
      $display("PASS XNOR: in_1=%h in_2=%h -> result=%h", in_1,in_2,result);
    else
      $display("FAIL XNOR: in_1=%h in_2=%h -> result=%h exp=%h", in_1,in_2, result, expected);
  end
  //--1000-NOT
  $display("\n=== NOT (opcode=1000) ===");
  opcode = 4'b1000; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = 64'b0;
    #1;
    expected = ~in_1;
    if (result == expected)
      $display("PASS NOT: in_1=%h -> result=%h", in_1, result);
    else
      $display("FAIL NOT: in_1=%h -> result=%h exp=%h", in_1, result, expected);
  end
  //--1001--INC
  $display("\n=== INC (opcode=1001) ===");
  opcode = 4'b1001; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = 64'b0;
    #1;
    expected = in_1 + 64'b1;
    if (result == expected)
      $display("PASS INC: in_1=%h -> result=%h", in_1, result);
    else
      $display("FAIL INC: in_1=%h -> result=%h exp=%h", in_1, result, expected);
  end
   //--1010--DEC
  $display("\n=== DEC (opcode=1010) ===");
  opcode = 4'b1010; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = 64'b0;
    #1;
    expected = in_1 - 64'b1;
    if (result == expected)
      $display("PASS DEC: in_1=%h -> result=%h", in_1, result);
    else
      $display("FAIL DEC: in_1=%h -> result=%h exp=%h", in_1, result, expected);
  end
      // ── 1011 : LSL ───────────────────────────────────────
  $display("\n=== LSL (opcode=1011) ===");
  opcode = 4'b1011; in_2 = 64'b0;
  repeat(10) begin
    in_1  = {$random,$random};
    shamt = $random % 64;
    #1;
    expected = in_1 << shamt;
    if (result == expected)
      $display("PASS LSL: in_1=%h shamt=%0d -> result=%h", in_1, shamt, result);
    else
      $display("FAIL LSL: in_1=%h shamt=%0d -> result=%h exp=%h", in_1, shamt, result, expected);
  end

  // ── 1100 : LSR ───────────────────────────────────────
  $display("\n=== LSR (opcode=1100) ===");
  opcode = 4'b1100; in_2 = 64'b0;
  repeat(10) begin
    in_1  = {$random,$random};
    shamt = $random % 64;
    #1;
    expected = in_1 >> shamt;
    if (result == expected)
      $display("PASS LSR: in_1=%h shamt=%0d -> result=%h", in_1, shamt, result);
    else
      $display("FAIL LSR: in_1=%h shamt=%0d -> result=%h exp=%h", in_1, shamt, result, expected);
  end

  // ── 1101 : ASR ───────────────────────────────────────
  $display("\n=== ASR (opcode=1101) ===");
  opcode = 4'b1101; in_2 = 64'b0;
  repeat(10) begin
    in_1  = {$random,$random};
    shamt = $random % 64;
    #1;
    expected = $signed(in_1) >>> shamt;
    if (result == expected)
      $display("PASS ASR: in_1=%h shamt=%0d -> result=%h", in_1, shamt, result);
    else
      $display("FAIL ASR: in_1=%h shamt=%0d -> result=%h exp=%h", in_1, shamt, result, expected);
  end
  //--1110-PASS-A---
   $display("\n=== PASS-A (opcode=1110) ===");
  opcode = 4'b1110; shamt = 6'b0;
  repeat(10) begin
    in_1 = {$random,$random};
    in_2 = 64'b0;
    #1;
    expected = in_1;
    if (result == expected)
      $display("PASS PASS-A: in_1=%h -> result=%h", in_1, result);
    else
      $display("FAIL PASS-A: in_1=%h -> result=%h exp=%h", in_1, result, expected);
  end
 

  // ── 1111 : COMPARE ───────────────────────────────────
  $display("\n=== COMPARE (opcode=1111) ===");
  opcode = 4'b1111; shamt = 6'b0;

  // A > B
  in_1 = 64'd100; in_2 = 64'd50; #1;
  if (gt==1 && eq==0 && lt==0)
    $display("PASS CMP: %0d > %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);
  else
    $display("FAIL CMP: %0d > %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);

  // A == B
  in_1 = 64'd77; in_2 = 64'd77; #1;
  if (gt==0 && eq==1 && lt==0)
    $display("PASS CMP: %0d == %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);
  else
    $display("FAIL CMP: %0d == %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);

  // A < B
  in_1 = 64'd10; in_2 = 64'd200; #1;
  if (gt==0 && eq==0 && lt==1)
    $display("PASS CMP: %0d < %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);
  else
    $display("FAIL CMP: %0d < %0d -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);

  // random compare
  repeat(7) begin
    in_1 = {$random,$random};
    in_2 = {$random,$random};
    #1;
    if ((in_1 > in_2 && gt && !eq && !lt) ||
        (in_1 == in_2 && !gt && eq && !lt) ||
        (in_1 < in_2 && !gt && !eq && lt))
      $display("PASS CMP: in_1=%h in_2=%h -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);
    else
      $display("FAIL CMP: in_1=%h in_2=%h -> gt=%b eq=%b lt=%b", in_1, in_2, gt, eq, lt);
  end

  // ── ZERO FLAG CHECK ──────────────────────────────────
  $display("\n=== ZERO flag check ===");
  opcode = 4'b0000; shamt = 6'b0;
  in_1 = 64'd100; in_2 = 64'd100; #1;
  if (zero == 1'b1)
    $display("PASS ZERO: 100+100 subtracted result is zero -> zero=%b (wait, ADD 100+100=200 zero=0 expected)", zero);
  in_1 = 64'hFFFFFFFFFFFFFFFF; in_2 = 64'h0000000000000001;
  opcode = 4'b0000; #1;
  if (zero == 1'b1)
    $display("PASS ZERO: MAX+1 wraps to 0 -> zero=%b", zero);
  else
    $display("INFO ZERO: MAX+1 -> result=%h zero=%b", result, zero);

  $display("\n=== ALL TESTS DONE ===\n");
  $finish;
end

endmodule
