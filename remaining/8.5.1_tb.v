module tb;
    reg [3:0] number;        
    wire [31:0] out;         

    factorial fac(.number(number), .out(out)); 

    initial begin
        $monitor("Time = %0t | number = %d | factorial = %d", $time, number, out);
        
        number = 0; #10;
        number = 1; #10;
        number = 2; #10;
        number = 3; #10;
        number = 4; #10;
        number = 5; #10;
        number = 6; #10;
        
        #10 $finish; 
    end
endmodule
