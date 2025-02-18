module tb;
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] select;
    wire [4:0] out;
    
    alu alu21(.a(a), .b(b), .select(select), .out(out));

    initial begin
        $monitor("Time=%d a=%d b=%d sel=%d out=%d", $time, a, b, select, out);
        
        a = 15; b = 0;  select = 0; #10;
        a = 15; b = 15; select = 1; #10;
        a = 15; b = 15; select = 2; #10;
        a = 15; b = 15; select = 3; #10;
        a = 15; b = 15; select = 4; #10;
        a = 15; b = 15; select = 5; #10;
        a = 15; b = 15; select = 6; #10;
        a = 15; b = 15; select = 7; #10;
    end
endmodule