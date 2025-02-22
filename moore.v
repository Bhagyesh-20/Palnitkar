module moore_fsm (
    input clk, reset, in,
    output reg out
);
    typedef enum logic [2:0] { S0, S1, S2, S3, S4 } state_t;
    state_t state, next_state;

    // State Transition Logic (Always Block 1)
    always @(posedge clk or posedge reset)
        state <= reset ? S0 : next_state;

    // Next State Logic (Using Case + Ternary Operator)
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S1 : S2;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S2;
            S4: next_state = in ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    // Output Logic (Always Block 2, Depends Only on State)
    always @(posedge clk)
        out <= (state == S4) ? 1'b1 : 1'b0;  // Output only updates on clock edge
endmodule
