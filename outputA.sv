/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Pass A module for 8-bit ALU.
 *              Uses combinational logic to pass A input through to output.
 * Sources: ECE 204 course materials
 * Date: May 2026
 */

module outputA(
    input  logic [7:0] a,
    output logic [7:0] result
);
    assign result = a;
endmodule
