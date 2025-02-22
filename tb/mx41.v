module tb;
    reg [3:0] data;
    reg [1:0]sel;
    wire q;
    integer pass_count = 0, fail_count = 0; // Track test results
    reg ex_q;

    top_module uut (.data(data), .sel(sel), .q(q));

    initial begin
        $display("Starting Self-Checking Testbench...");
        
        for(int i=0;i<64;i++)begin
            {data,sel} = i;
            case (sel)
            2'b00: ex_q = data[0];
            2'b01: ex_q = data[1];
            2'b10: ex_q = data[2];
            2'b11: ex_q = data[3];
            endcase
            #10;
            check_results();
        end
    end

    task check_results;
        begin
            if(q===ex_q)begin
                pass_count = pass_count + 1;
                $display(" PASS: data=%d, sel=%d, q=%d", data, sel, q);
            end else begin
                fail_count = fail_count + 1;
                $display(" FAIL: data=%d, sel=%d, q=%d (Expected: %d)", data, sel, q, ex_q);
            end
        end
    endtask

endmodule


module top_module(input [3:0] data, input [1:0]sel,output reg q);
    always @(*) begin
        case (sel)
            2'b00: q = data[0];
            2'b01: q = data[1];
            2'b10: q = data[2];
            2'b11: q = data[3];
        endcase
    end
endmodule