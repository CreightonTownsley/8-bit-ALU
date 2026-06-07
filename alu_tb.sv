/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Description: Testbench to validate all 8-bit ALU operations including
 * loading registers, executing opcodes, and checking enable/reset.
 * Sources: ECE 204 course materials
 * Date: June 2026
 */

`timescale 1ns/1ps

module alu_tb();

    // Inputs
    logic MAX10_CLK1_50;
    logic [9:0] SW;
    logic [1:0] KEY;

    // Outputs
    logic [9:0] LEDR;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

   
    alu_top uut (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .SW(SW),
        .KEY(KEY),
        .LEDR(LEDR),
        .HEX5(HEX5), .HEX4(HEX4),
        .HEX3(HEX3), .HEX2(HEX2),
        .HEX1(HEX1), .HEX0(HEX0)
    );

  
    always #10 MAX10_CLK1_50 = ~MAX10_CLK1_50;

    initial begin

        MAX10_CLK1_50 = 0;
        SW = 10'b0;
        KEY = 2'b11; 

        // Reset the system 
        $display("Applying reset...");
        SW[8] = 1'b0;
        #40;
        SW[8] = 1'b1; // Release reset
        #20;

        // Load Operand A 
        // SW[9]=0 for input mode. SW[7:0] for value. KEY[1] loads A.
        $display("Loading Operand A...");
        SW[9] = 1'b0;
        SW[7:0] = 8'hA5; // 10100101
        #20;
        KEY[1] = 1'b0;   // Press KEY[1]
        #20;
        KEY[1] = 1'b1;   // Release KEY[1]
        #40;

        // Load Operand B 
        $display("Loading Operand B...");
        SW[7:0] = 8'h3C; // 00111100 
        #20;
        KEY[0] = 1'b0;   // Press KEY[0]
        #20;
        KEY[0] = 1'b1;   // Release KEY[0]
        #40;

        //Switch to Opcode Mode & Enable Display
        // SW[9]=1 for opcode mode. SW[3]=1 for display enable.
        $display("Switching to Opcode mode...");
        SW[9] = 1'b1;
        SW[3] = 1'b1;
        #40;

        // Test All Operations
        
        // 000 = Addition (A5 + 3C = E1)
        $display("Testing Addition:");
        SW[2:0] = 3'b000;
        #40;

        // 001 = Subtraction (A5 - 3C = 69)
        $display("Testing Subtraction:");
        SW[2:0] = 3'b001;
        #40;

        // 010 = Bitwise AND (A5 & 3C = 24)
        $display("Testing AND:");
        SW[2:0] = 3'b010;
        #40;

        // 011 = Output A (Should be A5)
        $display("Testing Output A:");
        SW[2:0] = 3'b011;
        #40;

        // 100 = Output B (Should be 3C)
        $display("Testing Output B:");
        SW[2:0] = 3'b100;
        #40;

        // 101 = Bitwise XOR (A5 ^ 3C = 99)
        $display("Testing XOR:");
        SW[2:0] = 3'b101;
        #40;

        // 110 = Bitwise OR (A5 | 3C = BD)
        $display("Testing OR:");
        SW[2:0] = 3'b110;
        #40;

        // SW[3]=0 should blank/zero the result output
        $display("Testing Enable Low:");
        SW[3] = 1'b0;
        #40;

        $display("Simulation Complete.");
        $stop; 
    end

endmodule
