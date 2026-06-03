/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Output handler for 8-bit ALU.
 *              Controls enable and reset signals.
 *              Splits 8-bit inputs into 2 4-bit nibbles to go into seven-segment displays.
 *              HEX5-4 always shows input A.
 *              HEX3-2 always shows input B.
 *              HEX1-0 shows result when enabled and blank when disabled.
 *              LEDR[0] indicates overflow, LEDR[3] shows enable status.
 * Sources: ECE 204 course materials
 * Date: June 2026
 */

module output_handler(
    input  logic [7:0] result,
    input  logic [7:0] reg_A,
    input  logic [7:0] reg_B,
    input  logic       overflow,
    input  logic       enable,
    input  logic       reset_n,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic [6:0] HEX2,
    output logic [6:0] HEX3,
    output logic [6:0] HEX4,
    output logic [6:0] HEX5,
    output logic [9:0] LEDR
);

    // Internal signals for values being displayed
    logic [7:0] result_display; // Goes to HEX1-0
    logic [3:0] a_high, a_low;  // Upper and lower nibbles of A
    logic [3:0] b_high, b_low;  // Upper and lower nibbles of B
    logic [3:0] r_high, r_low;  // Upper and lower nibbles of result

    // Split each 8-bit value into two 4-bit nibbles
    assign a_high = reg_A[7:4];
    assign a_low  = reg_A[3:0];
    assign b_high = reg_B[7:4];
    assign b_low  = reg_B[3:0];
    assign r_high = result_display[7:4];
    assign r_low  = result_display[3:0];

    // Result display logic (blank if reset asserted or enable off)
    always_comb begin
        if (reset_n == 1'b0)
            result_display = 8'b0;
        else if (enable == 1'b0)
            result_display = 8'b0;
        else
            result_display = result;
    end

    // LED display logic for enable and overflow
    assign LEDR[0]   = (reset_n & enable) ? overflow : 1'b0;
    assign LEDR[3]   = enable;
    assign LEDR[9:4] = 6'b0; // unused LEDs off
    assign LEDR[2:1] = 2'b0; // unused LEDs off

    // Instantiate seven_seg for each display
    seven_seg hex5_inst (.num(a_high), .segments(HEX5));
    seven_seg hex4_inst (.num(a_low),  .segments(HEX4));

    seven_seg hex3_inst (.num(b_high), .segments(HEX3));
    seven_seg hex2_inst (.num(b_low),  .segments(HEX2));

    seven_seg hex1_inst (.num(r_high), .segments(HEX1));
    seven_seg hex0_inst (.num(r_low),  .segments(HEX0));

endmodule
