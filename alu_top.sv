/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Top-level module for 8-bit ALU.
 *              Interfaces with DE10-Lite FPGA board.
 *              Handles sequential input latching for operands A and B.
 *              Instantiates all operation modules, opcode decoder,
 *              and output handler.
 * Sources: ECE 204 course materials
 * Date: June 2026
 */

module alu_top (
    input  logic        MAX10_CLK1_50, // 50 MHz Clock input
    input  logic [9:0]  SW,            // Switches [9:0]
    input  logic [1:0]  KEY,           // Pushbuttons [1:0]
    output logic [9:0]  LEDR,          // LEDs [9:0]
    output logic [6:0]  HEX5, HEX4,   // Operand A displays
    output logic [6:0]  HEX3, HEX2,   // Operand B displays
    output logic [6:0]  HEX1, HEX0    // Result displays
);

    // Internal registers and wires
    logic [7:0] reg_A, reg_B;
    logic       reset_n;

    assign reset_n = SW[8];

    // Control & Latch Logic (Sequential Block)
    // Runs on the 50MHz clock. Latches operands only when SW[9] == 0 (Input mode)
    always_ff @(posedge MAX10_CLK1_50 or negedge reset_n) begin
        if (!reset_n) begin
            reg_A <= 8'b0;
            reg_B <= 8'b0;
        end else if (SW[9] == 1'b0) begin
            if (!KEY[1]) reg_A <= SW[7:0];
            if (!KEY[0]) reg_B <= SW[7:0];
        end
    end

    // Opcode is only valid in opcode mode (SW[9] == 1)
    logic [2:0] current_opcode;
    assign current_opcode = (SW[9] == 1'b1) ? SW[2:0] : 3'b000;

    // Output enable — only active in opcode mode with enable switch high
    logic display_enable;
    assign display_enable = (SW[9] == 1'b1) && (SW[3] == 1'b1);

    // Internal result wires from each operation module
    logic [7:0] add_result, sub_result, and_result;
    logic [7:0] or_result, xor_result, a_result, b_result;
    logic       add_overflow, sub_overflow, selected_overflow;
    logic [7:0] alu_out;

    // Instantiate all operation modules
    add_sub add_inst (
        .a(reg_A),
        .b(reg_B),
        .op(1'b0),              // op=0 for addition
        .result(add_result),
        .overflow(add_overflow)
    );

    add_sub sub_inst (
        .a(reg_A),
        .b(reg_B),
        .op(1'b1),              // op=1 for subtraction
        .result(sub_result),
        .overflow(sub_overflow)
    );

    bitwise_and and_inst (
        .a(reg_A),
        .b(reg_B),
        .result(and_result)
    );

    bitwise_or or_inst (
        .a(reg_A),
        .b(reg_B),
        .result(or_result)
    );

    bitwise_xor xor_inst (
        .a(reg_A),
        .b(reg_B),
        .result(xor_result)
    );

    outputA outA_inst (
        .a(reg_A),
        .result(a_result)
    );

    outputB outB_inst (
        .b(reg_B),
        .result(b_result)
    );

    // Opcode decoder selects one result based on current_opcode
    opcode_decoder decoder_inst (
        .add_result(add_result),
        .sub_result(sub_result),
        .and_result(and_result),
        .or_result(or_result),
        .xor_result(xor_result),
        .a_result(a_result),
        .b_result(b_result),
        .add_overflow(add_overflow),
        .sub_overflow(sub_overflow),
        .opcode(current_opcode),
        .result(alu_out),
        .overflow(selected_overflow)
    );

    // Output handler drives all displays and LEDs
    output_handler display_inst (
        .result(alu_out),
        .reg_A(reg_A),
        .reg_B(reg_B),
        .overflow(selected_overflow),
        .enable(display_enable),
        .reset_n(reset_n),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5),
        .LEDR(LEDR)
    );

endmodule
