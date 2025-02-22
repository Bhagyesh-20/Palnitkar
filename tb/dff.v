module tb;
    reg clk, d;
    wire q;
    integer pass_count = 0, fail_count = 0; // Track test results

    // Instantiate the D Flip-Flop module
    top_module uut (.clk(clk), .d(d), .q(q));

    // Clock Generation: Toggle every 5 time units (for 10-unit period)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Starting Self-Checking Testbench...");

        // Test Case 1: d = 0
        d = 0;
        @(posedge clk); #1 check_results();  // Wait for clock edge before checking

        // Test Case 2: d = 1
        d = 1;
        @(posedge clk); #1 check_results();

        // Test Case 3: Random values
        d = $random % 2;
        @(posedge clk); #1 check_results();

        // Test Case 4: Another random set
        d = $random % 2;
        @(posedge clk); #1 check_results();
        
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
    task check_results;
        begin
            if (q === d) begin
                pass_count = pass_count + 1;
                $display(" PASS: d=%b, q=%b", d, q);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: d=%b, q=%b (Expected: %b)", d, q, d);
            end
        end
    endtask
    
endmodule

module top_module (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
