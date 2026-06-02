module output_handler (
    input  logic [2:0] Opcode,
    input  logic       Enable,
    input  logic [7:0] add_sub_res,
    input  logic [7:0] and_res,
    input  logic [7:0] or_res,
    input  logic [7:0] xor_res,
    input  logic [7:0] outA_res,
    input  logic [7:0] outB_res,
   
    output logic [7:0] Result
);

   
    always_comb begin
        
        if (Enable == 1'b0) begin
            
            Result = 8'b00000000;
        end 
        else begin
            
            case (Opcode)
                3'b000: Result = add_sub_res; // Add
                3'b001: Result = add_sub_res; // Sub
                3'b010: Result = and_res;  
                3'b011: Result = or_res;      
                3'b100: Result = xor_res;     
                3'b101: Result = outA_res;    
                3'b110: Result = outB_res; 
                default: Result = 8'b00000000; 
            endcase
        end
    end

endmodule
