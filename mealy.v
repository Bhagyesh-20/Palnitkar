module mealy_fsm (
    input clk, reset, in,
    output reg out
);
    typedef enum logic [2:0] { S0, S1, S2, S3 } state_t;
    state_t state, next_state;

    // State Transition Logic (Always Block 1)
    always @(posedge clk or posedge reset)
        state <= reset ? S0 : next_state;

    // Next State & Output Logic (Using Case + Ternary Operator)
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S1 : S2;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S1 : S2;
            default: next_state = S0;
        endcase

        // Mealy Output (Depends on State and Input)
        out = (state == S3 && in) ? 1'b1 : 1'b0; // Output can change immediately with input
    end
endmodule
