8-bit ALU

ECE 204 — Digital Logic Design | Oregon State University | Spring 2026

Creighton Townsley · Wakana Sakane · Trevor Bahm

---

Description

An 8-bit Arithmetic Logic Unit (ALU) implemented in SystemVerilog and deployed on the DE10-Lite FPGA (Intel MAX 10).

Supports 7 operations selected by a 3-bit opcode:

| Opcode | Operation    |
|--------|--------------|
| 000    | Addition     |
| 001    | Subtraction  |
| 010    | Bitwise AND  |
| 011    | Output A     |
| 100    | Output B     |
| 101    | Bitwise XOR  |
| 110    | Bitwise OR   |

Files

| File | Description |
|------|-------------|
| `alu_top.sv` | Top-level module |
| `opcode_decoder.sv` | Opcode MUX |
| `add_sub.sv` | Addition and subtraction |
| `bitwise_and.sv` | Bitwise AND |
| `bitwise_or.sv` | Bitwise OR |
| `bitwise_xor.sv` | Bitwise XOR |
| `outputA.sv` | A passthrough |
| `outputB.sv` | B passthrough |
| `output_handler.sv` | Enable, reset, 7-seg encoding |
| `testbench.sv` | Top-level testbench |
| `alu_tb.do` | ModelSim do file |

*Submitted for ECE 204, Oregon State University, due June 7, 2026.*
