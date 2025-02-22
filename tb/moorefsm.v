module tb;
    reg in, clk, reset;
    wire q;
    integer pass_count = 0, fail_count = 0; // Track test results
    reg expected_q;
    
    top_module uut (.in(in), .clk(clk), .reset(reset), .q(q));

    // Clock generation
    always #1 clk = ~clk; // 2 time unit clock period

    initial begin
        $display("Starting Self-Checking Testbench...");
        
        clk = 0; // Initialize clock
        reset = 1;
        in = 0;
        expected_q = 0;
        
        @(posedge clk); #1 reset = 0; // Release reset after one cycle
        // Sequence to test: 1011
        in = 1; @(posedge clk); #0 check_results();
        
        in = 0; @(posedge clk); #0 check_results();
        in = 1; @(posedge clk); #0 check_results();
        in = 1; @(posedge clk); #0 check_results(); // Should output 1 here
        in = 0; @(posedge clk); #0 check_results(); // Should return to 0
        
        // Test random transitions
        in = 1; @(posedge clk); #0 check_results();
        in = 1; @(posedge clk); #0 check_results();
        in = 0; @(posedge clk); #0 check_results();
        in = 1; @(posedge clk); #0 check_results();
        in = 1; @(posedge clk); #0 check_results();
        in = 0; @(posedge clk); #0 check_results();

        // Summary of results
        $display("==================================================");
        $display("Test Summary: Passed = %0d, Failed = %0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED ✅");
        else
            $display("SOME TESTS FAILED ❌");

        $finish;
    end

    // Task to check results
    task check_results;
    begin
        expected_q = (uut.state == uut.S1011);

        // Expected q should be HIGH only when in S1011
        if (q === expected_q) begin
            pass_count = pass_count + 1;
            $display(" PASS: in=%b, q=%b (Expected: %b)", in, q, expected_q);
        end else begin
            fail_count = fail_count + 1;
            $display(" FAIL: in=%b, q=%b (Expected: %b)", in, q, expected_q);
        end
    end
    endtask
endmodule

module top_module(input reset, input clk, input in, output reg q);
    parameter [2:0] IDLE = 3'b000, S1 = 3'b001, S10 = 3'b010, S101 = 3'b011, S1011 = 3'b100;
    reg [2:0] state, next_state;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE:  next_state = in ? S1 : IDLE;
            S1:    next_state = in ? S1 : S10;
            S10:   next_state = in ? S101 : IDLE;
            S101:  next_state = in ? S1011 : IDLE;
            S1011: next_state = in ? S1011 : IDLE; // Ensure it properly resets when `in=0`
            default: next_state = IDLE;
        endcase
    end

    // Moore Output Logic (Updated to avoid timing mismatch)
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= (state == S1011);
    end

endmodule
