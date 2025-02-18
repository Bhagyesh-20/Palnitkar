module alu(input [3:0] a, input [3:0] b, input [2:0] select, output [4:0] out);
    
    function [4:0] alu_func;
        input [3:0] a;
        input [3:0] b;
        input [2:0] select;
        
        begin
            case(select)
                3'b000: alu_func = a & 5'h1F;       
                3'b001: alu_func = (a + b) & 5'h1F; 
                3'b010: alu_func = (a - b) & 5'h1F; 
                3'b011: alu_func = (b != 0) ? (a / b) & 5'h1F : 5'b11111; 
                3'b100: alu_func = (b != 0) ? (a % b) & 5'h1F : 5'b11111; 
                3'b101: alu_func = (a << 1) & 5'h1F; 
                3'b110: alu_func = (a >> 1) & 5'h1F; 
                3'b111: alu_func = (a > b) ? 5'h1 : 5'h0; 
                default: alu_func = 5'h0;
            endcase
        end
    endfunction

    assign out = alu_func(a, b, select);

endmodule
