module tb;
    reg clk, areset, load, ena;
    reg [3:0] data;
    wire [3:0] q;
    integer pass_count = 0, fail_count = 0; // Track test results

    top_module uut (.clk(clk), .areset(areset), .load(load), .ena(ena), .data(data), .q(q));

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        $display("Starting Self-Checking Testbench...");
        
        // Test Case 1: Reset
        areset = 1;
        @(posedge clk); #0 check_results();

        // Test Case 2: Load
        areset = 0;
        load = 1;
        data = 4'b1010;
        @(posedge clk); #0 check_results();

        // Test Case 3: Shift
        load = 0;
        ena = 1;
        data = 4'b1010;
        @(posedge clk); #0 check_results();

        // Test Case 4: Another random set
        data = 4'b0101;
        @(posedge clk); #0 check_results();

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
            if (q === data) begin
                pass_count = pass_count + 1;
                $display(" PASS: data=%d, q=%d", data, q);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: data=%d, q=%d (Expected: %d)", data, q, data);
            end
        end
    endtask
endmodule

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 


    always@(posedge clk or posedge areset)begin
        if(areset) begin
            q<=4'b0000;
        end
        else if(load) begin
            q<=data;
        end
        else if(ena) begin
            q<={1'b0,q[3:1]};
        end
    end

endmodule
