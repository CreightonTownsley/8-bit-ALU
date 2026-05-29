/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Bitwise XOR module for 8-bit ALU.
 *              Uses combinational logic to perform bitwise XOR operation for two 8-bit numbers.
 * Sources: ECE 204 course materials
 * Date: May 2026
 */

module bitwise_XOR(
	input logic [7:0] a,
	input logic [7:0] b,
	output logic [7:0] result
);
	assign result = a ^ b;

endmodule
