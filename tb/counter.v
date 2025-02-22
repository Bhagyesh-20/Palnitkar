module tb;
    reg clk, reset;
    wire [3:0] q;
    integer pass_count = 0, fail_count = 0;

    // Instantiate the Counter Module
    top_module uut (.clk(clk), .reset(reset), .q(q));

    // Clock Generation: Toggle every 5 time units
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $display("Starting Self-Checking Testbench...");

        // Test Case 1: Assert Reset and Wait
        reset = 1;
        repeat (2) @(posedge clk); // Hold reset for 2 clock cycles
        #0 check_results(4'b0000); // Check after a small delay
        reset = 0;

        // Test Case 2: Count up to 15
        for (integer i = 0; i < 16; i = i + 1) begin
          @(posedge clk); #0 check_results(i[3:0]); // Expect q to match the count
        end

        // Test Case 3: Overflow Back to 0
      @(posedge clk); #0 check_results(4'b0000); // Expect wrap-around to 0

        // Summary of results   
        $display("==================================================");
        $display("Test Summary: Passed = %0d, Failed = %0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED ✅");
        else
            $display("SOME TESTS FAILED ❌");

        $finish;
    end

    // Self-checking function
    task check_results(input [3:0] expected_q);
        begin
            if (q === expected_q) begin
                pass_count = pass_count + 1;
                $display(" PASS: q=%b (Expected: %b)", q, expected_q);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: q=%b (Expected: %b)", q, expected_q);
            end
        end
    endtask
    
endmodule


module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output reg [3:0] q
);

    // Initialize q to zero
    initial q = 4'b0000;

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end else if (q == 4'b1111) begin
            q <= 4'b0000;  // Wrap around to 0
        end else begin
            q <= q + 1;    // Increment counter
        end
    end

endmodule
