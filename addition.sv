/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Add/Subtract module for 8-bit ALU.
 *              Performs addition when op=0, subtraction when op=1.
 *              Uses two's complement method for subtraction.
 *              Outputs 8-bit result and 1-bit overflow/carry signal.
 * Sources: ECE 204 course materials
 * Date: May 2026
 */
 
module add_sub(
	input logic [7:0] a,
	input logic [7:0] b,
	input logic op,
	output logic [7:0] result,
	output logic overflow
);
	
	logic [7:0] b_mod; // Internal signal to handle 2's complement inversion for subtraction
	logic [8:0] full_result; // 9-bit Internal signal to hold overflow number
	
	// If op is 0 (addition), b_mod becomes b
	// If op is 1 (subtraction), b_mod becomes ~b (converting to two's complement)
	assign b_mod = op ? ~b : b; 
	
	// 9 bit addition, captures carry out in bit 8, curly braces are concatenation
	assign full_result = {1'b0, a} + {1'b0, b_mod} + op;
	
	assign result = full_result[7:0]; // 8 bit result
	assign overflow = full_result[8]; // Extra 9th bit is overflow
	
endmodule

