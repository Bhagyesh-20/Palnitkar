module tb;
reg [1:0] data;
wire [3:0] q;
integer pass_count = 0, fail_count = 0; // Track test results
    top_module uut (.data(data), .q(q));
  reg [3:0] expected_q;
    initial begin
        $display("Starting Self-Checking Testbench...");
        for (int i = 0; i < 16; i = i + 1) begin
            data = i;
            case (data)
            2'b00: expected_q = 4'b0001;
            2'b01: expected_q = 4'b0010;
            2'b10: expected_q = 4'b0100;
            2'b11: expected_q = 4'b1000;
              default: expected_q = 4'b0001;
            endcase
            #10 check_results();
        end
    end
    task check_results;
    begin
        if (q === expected_q) begin
            pass_count = pass_count + 1;
            $display(" PASS: data=%b, q=%b (Expected: %b)", data, q, expected_q);
        end else begin
            fail_count = fail_count + 1;
          $display(" FAIL: data=%b, q=%b (Expected: %d)", data, q, expected_q);
        end
    end
    endtask
endmodule



module top_module(input [1:0] data, output reg [3:0]q);
    always @(*) begin
        case (data)
            2'b00: q = 4'b0001;
            2'b01: q = 4'b0010;
            2'b10: q = 4'b0100;
            2'b11: q = 4'b1000;
            default: q = 4'b0001;

        endcase
    end
endmodule