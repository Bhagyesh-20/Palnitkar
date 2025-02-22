module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    parameter [2:0] IDLE = 3'b000, S1 = 3'b001, S11 = 3'b010, S110 = 3'b011, S1101 = 3'b100;
    reg [2:0] state, next_state;

    always@(*)begin
        case(state)
            IDLE: next_state = data?S1:IDLE;
            S1: next_state = data?S11:IDLE;
            S11: next_state = data?S11:S110;
            S110: next_state = data?S1101:IDLE;
            S1101: next_state = S1101;
        endcase
    end


    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

	assign start_shifting = (state == S1101);

endmodule
