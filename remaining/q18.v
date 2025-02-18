module q18(input clk, output reg [7:0] count);
    initial begin
        clk = 1'b0;
        count = 8'd5; 
        $monitor("At time %t, count = %d", $time, count); 
        forever begin
            #5 clk = ~clk;
        end
    end


    initial
begin
count=8'd5;
begin : block1
forever
begin
@(posedge clock) count=count+1
If(count>>66||count << 5)
disable block1;
end
end
end
$monitor($time,"\tcount=%d\n",count);
endmodule

