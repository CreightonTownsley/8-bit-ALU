module seven_seg (
    input  logic [3:0] num,      // 4-bit input
    output logic [6:0] segments  // 7-segment display output
);
    always_comb begin
        case (num)
            4'h0: segments = 7'b0000001; // 0
            4'h1: segments = 7'b1001111; // 1
            4'h2: segments = 7'b0010010; // 2
            4'h3: segments = 7'b0000110; // 3
            4'h4: segments = 7'b1001100; // 4
            4'h5: segments = 7'b0100100; // 5
            4'h6: segments = 7'b0100000; // 6
            4'h7: segments = 7'b0001111; // 7
            4'h8: segments = 7'b0000000; // 8
            4'h9: segments = 7'b0000100; // 9
            4'hA: segments = 7'b0001000; // A
            4'hB: segments = 7'b1100000; // b
            4'hC: segments = 7'b0110001; // C
            4'hD: segments = 7'b1000010; // d
            4'hE: segments = 7'b0110000; // E
            4'hF: segments = 7'b0111000; // F
            default: segments = 7'b1111111; // All off
        endcase
    end
endmodule