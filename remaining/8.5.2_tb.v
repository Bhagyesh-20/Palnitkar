module tb;
    reg [3:0] a;
    reg [3:0] b;
  	wire [7:0] out;
    multiply m(.a(a), .b(b), .out(out));

    initial begin
        $monitor("Time = %0t | a = %d | b = %d | out = %d", $time, a, b, out);
        a = 0; b=0; #10;                
        a = 0; b=1; #10;
        a = 1; b=1; #10;
        a = 1; b=2; #10;
        a = 1; b=3; #10;
        a = 2; b=2; #10;
        a = 15; b=15; #10;
        a = 10; b=10; #10;
        a = 1; b=10; #10;
        a = 9; b=8; #10;
        a = 10; b=2; #10;
    end
    
endmodule