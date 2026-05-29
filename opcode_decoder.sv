/*
 * Project: 8-bit ALU
 * Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
 * Contact: townslcr@oregonstate.edu
 * Description: Opcode decoder for 8-bit ALU.
 *              Acts as a MUX, selecting one of seven operation (six modules)
 *              results based on the 3-bit opcode input.
 *              Opcode table:
 *                000 = Addition
 *                001 = Subtraction
 *                010 = Bitwise AND
 *                011 = Output A
 *                100 = Output B
 *                101 = Bitwise XOR
 *                110 = Bitwise OR
 *                111 = Reserved (extra credit)
 * Sources: ECE 204 course materials
 * Date: May 2026
 */

module opcode_decoder(
    input  logic [7:0] add_result,
    input  logic [7:0] sub_result,
    input  logic [7:0] and_result,
    input  logic [7:0] or_result,
    input  logic [7:0] xor_result,
    input  logic [7:0] a_result,
    input  logic [7:0] b_result,
    input  logic [7:0] add_overflow,  // overflow from add_sub
    input  logic [7:0] sub_overflow,  // overflow from add_sub
    input  logic [2:0] opcode,
    output logic [7:0] result,
    output logic overflow
);

    always_comb begin
        case (opcode)
            3'b000: begin result = add_result; overflow = add_overflow; end // Addition
            3'b001: begin result = sub_result; overflow = sub_overflow; end // Subtraction
            3'b010: begin result = and_result; overflow = 1'b0;         end // AND
            3'b011: begin result = a_result;   overflow = 1'b0;         end // Output A
            3'b100: begin result = b_result;   overflow = 1'b0;         end // Output B
            3'b101: begin result = xor_result; overflow = 1'b0;         end // XOR
            3'b110: begin result = or_result;  overflow = 1'b0;         end // OR
            default: begin result = 8'b0;      overflow = 1'b0;         end // Reserved
        endcase
    end

endmodule