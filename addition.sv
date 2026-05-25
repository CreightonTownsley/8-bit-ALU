module addition(
	input logic [7:0] a,
	input logic [7:0] b,
	output logic [7:0] y,
	output logic cout
);
	logic [8:0] temp;
	assign temp = a + b;
	assign y = temp[7:0];
	assign cout = temp[8];

endmodule