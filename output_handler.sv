module output_handler (
    input  logic [2:0] Opcode,
    input  logic       Enable,
    input  logic [7:0] add_sub_result,
    input  logic [7:0] and_result,
    input  logic [7:0] or_result,
    input  logic [7:0] xor_result,
    input  logic [7:0] outA_result,
    input  logic [7:0] outB_result,
   
    output logic [7:0] Result
);

   
    always_comb begin
        
        if (Enable == 1'b0) begin
            
            Result = 8'b00000000;
        end 
        else begin
            
            case (Opcode)
                3'b000: Result = add_sub_result; // Add
                3'b001: Result = add_sub_result; // Sub
                3'b010: Result = and_result;  
                3'b011: Result = or_result;      
                3'b100: Result = xor_result;     
                3'b101: Result = outA_result;    
                3'b110: Result = outB_result; 
                default: Result = 8'b00000000; 
            endcase
        end
    end

endmodule
