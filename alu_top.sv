module alu_top (
    input  logic MAX10_CLK1_50, // 50 MHz Clock input
    input  logic [9:0] SW, // Switches [9:0]
    input  logic [1:0] KEY, // Pushbuttons [1:0]
    output logic [9:0] LEDR, // LEDs [9:0]
    output logic [6:0] HEX5, HEX4, // Operand A displays
    output logic [6:0] HEX3, HEX2, // Operand B displays
    output logic [6:0] HEX1, HEX0  // Result displays
);

    // Internal Registers and Wires
    logic [7:0] reg_A, reg_B;
    logic [7:0] alu_out;
    logic [7:0] result;
    logic alu_carry;
    logic reset_n;
    
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

    logic [2:0] current_opcode;
    assign current_opcode = (SW[9] == 1'b1) ? SW[2:0] : 3'b000;

    alu_core alu_inst (
        .a(reg_A),
        .b(reg_B),
        .opcode(current_opcode),
        .alu_out(alu_out),
        .carry_out(alu_carry)
    );

    // Output Enable Control Logic
    // Results display only if SW[9] == 1 (Op Mode) AND SW[3] == 1 (Enable)
    logic display_enable;
    assign display_enable = (SW[9] == 1'b1) && (SW[3] == 1'b1);
    assign result = display_enable ? alu_out : 8'b0;

    // Status LED assignments
    assign LEDR[0] = display_enable ? alu_carry : 1'b0; // Overflow indicator
    assign LEDR[3] = SW[3]; // Enable Status
    assign LEDR[8:4] = 8'b0; // Turn off unused LEDs
	 assign LEDR[2:1] = 8'b0; // Turn off unused LEDs

    // Operand A Displays (HEX5 = 16's place, HEX4 = 1's place)
    seven_seg hex5_inst (.num(reg_A[7:4]), .segments(HEX5));
    seven_seg hex4_inst (.num(reg_A[3:0]), .segments(HEX4));

    // Operand B Displays (HEX3 = 16's place, HEX2 = 1's place)
    seven_seg hex3_inst (.num(reg_B[7:4]), .segments(HEX3));
    seven_seg hex2_inst (.num(reg_B[3:0]), .segments(HEX2));

    // Final Result Displays (HEX1 = 16's place, HEX0 = 1's place)
    seven_seg hex1_inst (.num(result[7:4]), .segments(HEX1));
    seven_seg hex0_inst (.num(result[3:0]), .segments(HEX0));

endmodule