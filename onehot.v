module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    localparam [9:0] S0 = 10'b0000000001, S1 = 10'b0000000010, S2 = 10'b0000000100, S3 = 10'b0000001000,
    S4 = 10'b0000010000, S5 = 10'b0000100000, S6 = 10'b0001000000, S7 = 10'b0010000000, S8 = 10'b0100000000,
    S9 = 10'b1000000000;


    always@(*)begin
        case(state)
            S0: next_state = in?S1:S0; // correct
            S1: next_state = in?S2:S0; // correct
            S2: next_state = in?S3:S0; // correct 
            S3: next_state = in?S4:S0; // correct
            S4: next_state = in?S5:S0;
            S5: next_state = in?S6:S8;
            S6: next_state = in?S7:S9;
            S7: next_state = in?S7:S0;
            S8: next_state = in?S1:S0;
            S9: next_state = in?S1:S0;
        endcase
    end

    assign out1 = state[9]|state[8];
    assign out2 = state[9]|state[7];











endmodule
