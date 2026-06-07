/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Description: Testbench to validate all 8-bit ALU operations including
 *              loading registers, executing opcodes, and checking enable/reset.
 * Sources: ECE 204 course materials
 * Date: June 2026
 */

module alu_tb();

    // Inputs
    logic        MAX10_CLK1_50;
    logic [9:0]  SW;
    logic [1:0]  KEY;

    // Outputs
    logic [9:0]  LEDR;
    logic [6:0]  HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    // Instantiate DUT
    alu_top uut (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .SW(SW),
        .KEY(KEY),
        .LEDR(LEDR),
        .HEX5(HEX5), .HEX4(HEX4),
        .HEX3(HEX3), .HEX2(HEX2),
        .HEX1(HEX1), .HEX0(HEX0)
    );

    // 50 MHz clock, toggle every 10ns
    always #10 MAX10_CLK1_50 = ~MAX10_CLK1_50;

    initial begin
        MAX10_CLK1_50 = 0;
        SW  = 10'b0;
        KEY = 2'b11; // (active low)

        // Reset
        $display("Applying reset...");
        SW[8] = 1'b0; #40;
        SW[8] = 1'b1; // Release reset
        #20;

        // Load Operand A = 0xA5
        $display("Loading Operand A = 0xA5...");
        SW[9]   = 1'b0;
        SW[7:0] = 8'hA5;
        #20;
        KEY[1] = 1'b0; #20;  // Press KEY[1]
        KEY[1] = 1'b1; #40;  // Release KEY[1]

        // Load Operand B = 0x3C
        $display("Loading Operand B = 0x3C...");
        SW[7:0] = 8'h3C;
        #20;
        KEY[0] = 1'b0; #20;  // Press KEY[0]
        KEY[0] = 1'b1; #40;  // Release KEY[0]

        // Switch to opcode mode, enable on
        $display("Switching to opcode mode, enable on...");
        SW[9] = 1'b1;
        SW[3] = 1'b1;
        #40;

        // Test all operations

        // 000 = Addition (A5 + 3C = E1, overflow = 0)
        SW[2:0] = 3'b000; #40;
        $display("Addition    A5+3C: HEX=%h%h (expect E1), Overflow=%b (expect 0)",
            HEX1, HEX0, LEDR[0]);

        // 001 = Subtraction (A5 - 3C = 69, overflow = 0)
        SW[2:0] = 3'b001; #40;
        $display("Subtraction A5-3C: HEX=%h%h (expect 69), Overflow=%b (expect 0)",
            HEX1, HEX0, LEDR[0]);

        // 010 = Bitwise AND (A5 & 3C = 24)
        SW[2:0] = 3'b010; #40;
        $display("AND         A5&3C: HEX=%h%h (expect 24)", HEX1, HEX0);

        // 011 = Output A (should be A5)
        SW[2:0] = 3'b011; #40;
        $display("Output A:          HEX=%h%h (expect A5)", HEX1, HEX0);

        // 100 = Output B (should be 3C)
        SW[2:0] = 3'b100; #40;
        $display("Output B:          HEX=%h%h (expect 3C)", HEX1, HEX0);

        // 101 = Bitwise XOR (A5 ^ 3C = 99)
        SW[2:0] = 3'b101; #40;
        $display("XOR         A5^3C: HEX=%h%h (expect 99)", HEX1, HEX0);

        // 110 = Bitwise OR (A5 | 3C = BD)
        SW[2:0] = 3'b110; #40;
        $display("OR          A5|3C: HEX=%h%h (expect BD)", HEX1, HEX0);

        // Test overflow: FF + 01 = 00, overflow = 1
        $display("Testing overflow condition...");
        SW[9]   = 1'b0;
        SW[7:0] = 8'hFF;
        KEY[1]  = 1'b0; #20; KEY[1] = 1'b1; #20;
        SW[7:0] = 8'h01;
        KEY[0]  = 1'b0; #20; KEY[0] = 1'b1; #40;
        SW[9]   = 1'b1;
        SW[3]   = 1'b1;
        SW[2:0] = 3'b000; #40;
        $display("Overflow FF+01:    HEX=%h%h (expect 00), Overflow=%b (expect 1)",
            HEX1, HEX0, LEDR[0]);

        // Test enable low
        $display("Testing enable low...");
        SW[3] = 1'b0; #40;
        $display("Enable low:        LEDR[3]=%b (expect 0)", LEDR[3]);

        // Test reset mid-operation
        $display("Testing reset mid-operation...");
        SW[3] = 1'b1;
        SW[8] = 1'b0; #40;
        $display("After reset:       LEDR=%b (expect all 0)", LEDR);
        SW[8] = 1'b1;
        #20;

        $display("Simulation complete.");
        $stop;
    end

endmodule
