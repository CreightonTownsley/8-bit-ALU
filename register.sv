/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Parameterized register for 8-bit ALU.
 *              Stores N-bit value on rising clock edge.
 *              Asynchronous active-low reset clears output to 0.
 *              Used to latch operands A and B from switch input.
 * Sources: ECE 204 course materials
 * Date: May 2026
 */

module Register #(parameter N = 8)(
    input  logic         clock,
    input  logic         reset_n,
    input  logic [N-1:0] d,
    output logic [N-1:0] q
);

    always_ff @(posedge clock, negedge reset_n) begin
        if (reset_n == 1'b0)
            q <= {N{1'b0}};  // clear to 0 on reset
        else
            q <= d;          // latch d on rising clock edge
    end

endmodule
