module tb;
    reg [3:0] data;
    wire [1:0] q;
    integer pass_count = 0, fail_count = 0; // Track test results
    reg [1:0] expected_q;

    top_module uut (.data(data), .q(q));

    initial begin
        $display("Starting Self-Checking Testbench...");

        // Test specific values
        data = 4'b0000; expected_q = 2'b00; #10 check_results();
        data = 4'b0001; expected_q = 2'b00; #10 check_results();
        data = 4'b0010; expected_q = 2'b01; #10 check_results();
        data = 4'b0100; expected_q = 2'b10; #10 check_results();
        data = 4'b1000; expected_q = 2'b11; #10 check_results();

        // Test all possible values
        for (int i = 0; i < 16; i = i + 1) begin
            data = i;
            case (data)
                4'b0001: expected_q = 2'b00;
                4'b0010: expected_q = 2'b01;
                4'b0100: expected_q = 2'b10;
                4'b1000: expected_q = 2'b11;
                default: expected_q = 2'b00;
            endcase
            #10 check_results();
        end
        
        $display("==================================================");
        $display("Test Summary: Passed = %0d, Failed = %0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED ✅");
        else
            $display("SOME TESTS FAILED ❌");
    end

    // Self-checking function
    task check_results;
    begin
        if (q === expected_q) begin
            pass_count = pass_count + 1;
            $display(" PASS: data=%b, q=%b (Expected: %b)", data, q, expected_q);
        end else begin
            fail_count = fail_count + 1;
            $display(" FAIL: data=%b, q=%b (Expected: %b)", data, q, expected_q);
        end
    end
    endtask

endmodule


module top_module(input [3:0] data, output reg [1:0] q);
    always @(*) begin
        case (data)
            4'b0001: q = 2'b00;
            4'b0010: q = 2'b01;
            4'b0100: q = 2'b10;
            4'b1000: q = 2'b11;
            default: q = 2'b00;
        endcase
    end
endmodule
