module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 2'b01,B = 2'b10;
    reg [1:0] state, next_state;
   
    always@(posedge clk or posedge areset)begin
        if(areset)begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always@(*)begin
        case(state)
            A: next_state = x?B:A;
            B: next_state = B;
        endcase
    end

    assign z = (state == B);
    

endmodule
