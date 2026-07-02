# 64-bit ALU (Verilog, Gate-Level Hierarchical Design)

A 64-bit Arithmetic Logic Unit built entirely **from scratch**, gate by gate, in Verilog.
No built-in operators (`+`, `-`, `&`, `|`, `^`, ...) are used at the arithmetic/logic level --
every operation is composed from 1-bit primitive gates that are scaled up through a strict
power-of-two hierarchy (1 -> 4 -> 8 -> 16 -> 32 -> 64 bits) using structural module instantiation.

## Toolchain

- **Simulation:** [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog` + `vvp`)
- **Synthesis / Visualization:** [Yosys](https://github.com/YosysHQ/yosys) -- synthesized netlists exported as `.dot` / `.svg` schematics

## Design Hierarchy

```
Level 0 -- 1-bit primitive gates
  and_1, or_1, not_1, xor_1, xnor_1, nand_1, nor_1

Level 1 -- N-bit gate arrays (built by instantiating Level 0, doubling width each step)
  and_4/8/16/32/64, or_4/8/16/32/64, not_4/8/16/32/64,
  xor_4/8/16/32/64, xnor_4/8/16/32/64, nand_4/8/16/32/64, nor_4/8/16/32/64

Level 2 -- Arithmetic building blocks
  half_adder_1/4/8/16/32/64   (xor_N + and_N)
  full_adder_1/4/8/16/32/64   (2x half_adder_N + or_N)
  rca_4/8/16/32/64            (ripple-carry adder, built from full_adder_1, cascaded)

Level 3 -- Arithmetic units
  adder_64        (rca_64 with carry_in = 0)
  subtractor_64   (not_64 on in_2, rca_64 with carry_in = 1 -> two's complement add)
  inc_64          (adder_64, in_2 = 1)
  dec_64          (subtractor_64, in_2 = 1)
  comparator_64   (gt / eq / lt flags)

Level 4 -- Shifters & Mux
  mux2X1_64 -> mux4X1_64 -> mux8X1_64 -> mux16X1_64   (built purely from mux2X1_64)
  lsl_64   -- logical shift left,  built from 6 stages of mux2X1_64 (barrel shifter)
  lsr_64   -- logical shift right, built from 6 stages of mux2X1_64 (barrel shifter)
  asr_64   -- arithmetic shift right (sign-extending), built from 6 stages of mux2X1_64

Level 5 -- Top level
  alu_64  -- combines every block above, opcode-selects the result via mux16X1_64
```

## Repository Structure

```
ALU/
├── 01_basic_gates/               # and_1..64, or_1..64, not_1..64, xor_1..64,
│                                    xnor_1..64, nand_1..64, nor_1..64
├── 02_half_adder/                # half_adder_1..64
├── 03_full_adder/                 # full_adder_1..64
├── 04_rca_adder/                   # rca_4..64 (ripple carry adder), adder_64
├── 05_subtractor/                   # subtractor_64
├── 06_incrementer_decrementer/       # inc_64, dec_64
├── 07_comparator/                     # comparator_64 (gt/eq/lt)
├── 08_mux/                             # mux2X1_64, mux4X1_64, mux8X1_64, mux16X1_64
├── 09_shifters/                         # lsl_64, lsr_64, asr_64
├── 10_alu/                                # top-level alu_64
│   └── doc/                                 # Yosys-generated .dot and .svg schematics
├── .gitignore
└── README.md
```

Each numbered folder corresponds to one level of the design hierarchy, built and tested
in order before being wired into the next stage -- ending in `10_alu/`, which contains
the top-level `alu_64` module plus its synthesized schematic (`.dot` / `.svg`) in `doc/`.

## Top-Level Interface

```verilog
module alu_64(
  input  [63:0] in_1, in_2,
  input  [3:0]  opcode,
  input  [5:0]  shamt,
  output [63:0] result,
  output zero, carry, overflow, negative, gt, eq, lt
);
```

## Opcode Map

Result selection is done structurally via `mux16X1_64` (not a behavioral `case`):

| Opcode | Operation |
|--------|-----------|
| 0000   | ADD |
| 0001   | SUB |
| 0010   | AND |
| 0011   | OR |
| 0100   | NAND |
| 0101   | NOR |
| 0110   | XOR |
| 0111   | XNOR |
| 1000   | NOT (of `in_1`) |
| 1001   | INC (`in_1 + 1`) |
| 1010   | DEC (`in_1 - 1`) |
| 1011   | LSL -- logical shift left by `shamt` |
| 1100   | LSR -- logical shift right by `shamt` |
| 1101   | ASR -- arithmetic (sign-extending) shift right by `shamt` |
| 1110   | PASS (`in_1`) |
| 1111   | Reserved -- currently outputs `0` (intended for CMP) |

## Status Flags

- **zero** -- `result == 0`
- **negative** -- `result[63]`
- **carry** -- adder's carry-out (ADD) or subtractor's borrow (SUB), depending on opcode
- **overflow** -- derived from operand/result sign bits, valid for ADD/SUB
- **gt / eq / lt** -- driven by `comparator_64`

## Simulation (Icarus Verilog)

```bash
iverilog -o alu_sim \
  01_basic_gates/*.v \
  02_half_adder/*.v \
  03_full_adder/*.v \
  04_rca_adder/*.v \
  05_subtractor/*.v \
  06_incrementer_decrementer/*.v \
  07_comparator/*.v \
  08_mux/*.v \
  09_shifters/*.v \
  10_alu/*.v \
  tb/tb_alu64.v
vvp alu_sim
```

## Synthesis & Schematic (Yosys -> DOT / SVG)

```bash
yosys -p "
  read_verilog 01_basic_gates/*.v 02_half_adder/*.v 03_full_adder/*.v \
               04_rca_adder/*.v 05_subtractor/*.v 06_incrementer_decrementer/*.v \
               07_comparator/*.v 08_mux/*.v 09_shifters/*.v 10_alu/*.v;
  hierarchy -top alu_64;
  proc; opt; memory; opt;
  synth -top alu_64;
  show -format dot -prefix 10_alu/doc/alu64;
  show -format svg -prefix 10_alu/doc/alu64
"
```

This produces `10_alu/doc/alu64.dot` and `10_alu/doc/alu64.svg` -- the synthesized
gate-level schematic of the ALU. (Requires Graphviz installed for the `show` command
to render.)

## Status

- [x] Gate-level primitives (AND, OR, NOT, XOR, XNOR, NAND, NOR)
- [x] Half adder / full adder / ripple-carry adder
- [x] Adder / Subtractor / Increment / Decrement
- [x] Comparator (gt/eq/lt)
- [x] Barrel shifters (LSL, LSR, ASR)
- [x] 2:1 -> 16:1 mux tree
- [x] Top-level ALU integration + flags
- [x] Yosys synthesis + schematic (`.dot` / `.svg`)
- [ ] Testbench / verification

## License

This project is licensed under the MIT License.

```
MIT License

Copyright (c) 2026 Paranidharan R

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Author

**Paranidharan R**
