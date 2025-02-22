module tb;
    reg data;
    reg [1:0] sel;
    wire [3:0] q;
    integer pass_count = 0, fail_count = 0; // Track test results
    reg [3:0] ex_q;

    top_module uut (.data(data), .sel(sel), .q(q));

    initial begin
        $display("Starting Self-Checking Testbench...");
        
        for (int i = 0; i < 8; i++) begin
            {data, sel} = i;
            ex_q = 4'b0000; // Reset expected output before assignment
            case (sel)
                2'b00: ex_q[0] = data;
                2'b01: ex_q[1] = data;
                2'b10: ex_q[2] = data;
                2'b11: ex_q[3] = data;
            endcase
            #10 check_results();
        end

        // Test Summary
        $display("==================================================");
        $display("Test Summary: Passed = %0d, Failed = %0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED ");
        else
            $display("SOME TESTS FAILED ");

        $finish;
    end

    task check_results;
        begin
            if (q === ex_q) begin
                pass_count = pass_count + 1;
                $display("PASS : data=%b, sel=%b, q=%b (Expected: %b)", data, sel, q, ex_q);
            end else begin
                fail_count = fail_count + 1;
                $display("FAIL : data=%b, sel=%b, q=%b (Expected: %b)", data, sel, q, ex_q);
            end
        end
    endtask
endmodule


module top_module(input data, input [1:0] sel, output reg [3:0] q);
    always @(*) begin
        q = 4'b0000; // Reset output before setting a bit
        case (sel)
            2'b00: q[0] = data;
            2'b01: q[1] = data;
            2'b10: q[2] = data;
            2'b11: q[3] = data;
        endcase
    end
endmodule
