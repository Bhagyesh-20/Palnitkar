module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    always@(posedge clk or negedge aresetn)begin
        if(aresetn)begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    

    always@(*)begin
        case(state)
            S0: next_state = x?S1:S0;
            S1: next_state = x?S1:S2;
            S2: next_state = x?S1:S0;
        endcase
    end

    assign out = (state == S2)&x;
endmodule
