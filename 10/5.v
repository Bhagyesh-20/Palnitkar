module top_module;
    reg clk, reset, d;
    wire q, qbar;
    dff dff1(clk, reset, d, q, qbar);
    initial begin
        $monitor($time," clk=%b, reset=%b, d=%b, q=%b, qbar=%b", clk, reset, d, q, qbar);
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


module dff(input clk, reset, d, output reg q, qbar);

    specify
        specparam tpd_full = 5;  
        
        (clk, reset, d *> q) = tpd_full;    
        (clk, reset, d *> qbar) = tpd_full;
    endspecify  

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
            qbar <= 1'b1;
        end
        else begin
            q <= d;
            qbar <= ~d;
        end
    end

endmodule
