module tb;
    reg a, b, cin;
    wire cout, sum;
    integer pass_count = 0, fail_count = 0; // Track test results

    top_module uut (.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));
    
    initial begin
        $display("Starting Self-Checking Testbench...");
        
       for(int i = 0;i<8;i=i+1)begin
        {a,b,cin} = i;

        #10 check_results();
        end

        // Summary of results
        $display("==================================================");
        $display("Test Summary: Passed = %0d, Failed = %0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED ✅");
        else
            $display("SOME TESTS FAILED ❌");
    end
    task check_results;
        begin
            if (sum === a^b^cin && cout === (a&b)|(a&cin)|(b&cin)) begin
                pass_count = pass_count + 1;
                $display(" PASS: a=%d, b=%d, cin=%d, sum=%d, cout=%d", a, b, cin, sum, cout);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: a=%d, b=%d, cin=%d, sum=%d, cout=%d (Expected: %d, %d)", a, b, cin, sum, cout, a^b^cin, (a&b)|(a&cin)|(b&cin));
            end
        end
    endtask
endmodule


module top_module( 
    input a, b, cin,
    output reg cout, sum );

    always@(*)begin
        cout<= (a&b)|(a&cin)|(b&cin);
        sum<= a^b^cin;
    end
endmodule
