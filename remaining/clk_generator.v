module clk_generator;
    reg clk = 0;
    integer count = 100;

initial begin
    while(count>0) begin
        #10 clk = ~clk;
        count = count-1;
    end 
    end

endmodule