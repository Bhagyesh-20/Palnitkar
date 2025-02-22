module tb;
    reg a, b;
    wire cout, sum;
    integer pass_count = 0, fail_count = 0; // Track test results

    top_module uut (.a(a), .b(b), .cout(cout), .sum(sum));

    initial begin
        $display("Starting Self-Checking Testbench...");
        
        // Test Case 1: Both inputs are zero
        a = 0;
        b = 0;
        #10 check_results();

        // Test Case 2: Both inputs are one
        a = 1;
        b = 1;
        #10 check_results();

        // Test Case 3: Random values
        a = $random; 
        b = $random; 
        #10 check_results();

        // Test Case 4: Another random set
        a = $random; 
        b = $random; 
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

    task check_results;
        begin
            if (sum === a^b && cout === a&b) begin
                pass_count = pass_count + 1;
                $display(" PASS: a=%d, b=%d, sum=%d, cout=%d", a, b, sum, cout);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: a=%d, b=%d, sum=%d, cout=%d (Expected: %d, %d)", a, b, sum, cout, a^b, a&b);
            end
        end
    endtask

endmodule

module top_module( 
    input a, b,
    output cout, sum );

    always@(*)begin
    	sum <=a^b;
        cout<=a&b;
    end
endmodule
