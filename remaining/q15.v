module q15;
reg clk = 0;

    initial begin
        $monitor(clk);
        forever begin
            #4 clk = 1;
            #6 clk = 0;
        end
    end
endmodule