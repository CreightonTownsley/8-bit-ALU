/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Pass B module for 8-bit ALU.
 *              Uses combinational logic to pass B input through to output.
 * Sources: ECE 204 course materials
 * Date: May 2026
 */

module outputB(
	input logic [7:0] b,
	output logic [7:0] result
);
	assign result = b;

endmodule
