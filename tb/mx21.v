module tb;
    reg [99:0] a, b;
    reg sel;
    wire [99:0] out;
    integer pass_count = 0, fail_count = 0; // Track test results

    top_module uut (.a(a), .b(b), .sel(sel), .out(out));

    wire [99:0] expected_out;
    assign expected_out = sel ? b : a;

    initial begin
        $display("Starting Self-Checking Testbench...");
        
        // Test Case 1: Both inputs are zero
        a = 100'b0;
        b = 100'b0;
        sel = 1'b0;
        #10 check_results();

        // Test Case 2: Both inputs are one
        a = 100'b1;
        b = 100'b1;
        sel = 1'b1;
        #10 check_results();

        // Test Case 3: Random values
        a = {$random, $random}; 
        b = {$random, $random}; 
        sel = $random % 2; // Ensure sel is 0 or 1
        #10 check_results();

        // Test Case 4: Another random set
        a = {$random, $random}; 
        b = {$random, $random}; 
        sel = $random % 2;
        #10 check_results();

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
            if (out === expected_out) begin
                pass_count = pass_count + 1;
                $display(" PASS: a=%d, b=%d, sel=%b, out=%d", a, b, sel, out);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: a=%d, b=%d, sel=%b, out=%d (Expected: %d)", a, b, sel, out, expected_out);
            end
        end
    endtask
endmodule

module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out 
);
    assign out = sel ? b : a;
endmodule
