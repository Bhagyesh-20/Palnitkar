module top_module;
    reg clk, reset, d;
    wire q, qbar;
    dff dff1(clk, reset, d, q, qbar);
    initial begin
        $monitor($time," clk=%b, reset=%b, d=%b, q=%b, qbar=%b", clk, reset, d, q, qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0, top_module);
        clk = 1'b0;
        reset = 1'b1;
        d = 1'b0;
        #10 reset = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
        #10 $finish;
    end
    always begin
        #5 clk = ~clk;
    end
endmodule


module dff(input clk, reset, d,output reg q, qbar);

    specify
        specparam d_q = 5, d_qbar = 5, clk_q = 6, clk_qbar = 7, reset_q = 2, reset_qbar = 3;

        (d=>q) = d_q;
        (d=>qbar) = d_qbar;
        (clk=>q) = clk_q;
        (clk=>qbar) = clk_qbar;
        (reset=>q) = reset_q;
        (reset=>qbar) = reset_qbar;

    endspecify  

    always@(negedge clk or reset)begin
        if(reset)begin
            q <= 1'b0;
            qbar <= 1'b1;
        end
        else begin
            q<=d;
            qbar<=~d;
        end
    end
endmodule   