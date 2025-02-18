module tb;
    reg [15:0] number;
    wire out;
    task_parity tp(.number(number), .out(out));

    initial begin
        $monitor($time, " number = ", number, " out = ", out);
        number = 16'b0000_0001_0000_0000;  // Test case 1
        #10 number = 16'b0000_0001_0001_0000;  // Test case 2
        #10 $finish;
    end
endmodule