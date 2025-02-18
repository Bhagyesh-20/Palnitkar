module stimulus;

// Set up variables
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] sum;
    wire c_out;
    
    fulladd4 FA1_4(.sum(sum), .c_out(c_out), .a(a), .b(b), .c_in(c_in));

    initial begin
        $monitor($time, " A= %b, B=%b, C_IN= %b, --- C_OUT= %b, SUM= %b\n", a, b, c_in, c_out, sum);
    end

    initial begin
        a = 4'd0; 
        b = 4'd0; 
        c_in = 1'b0;
        
        #20;
        a = 4'd3; 
        b = 4'd4;
        
        #20;
        a = 4'd2; 
        b = 4'd5;
        
        #20;
        a = 4'd9; 
        b = 4'd9;
        
        #20; 
        a = 4'd10; 
        b = 4'd15;
        
        #20;
        a = 4'd10; 
        b = 4'd5; 
        c_in = 1'b1;  // Fixed the typo here
    end

endmodule

module fulladd4(sum, c_out, a, b, c_in);

// I/O port declarations
output [3:0] sum;
output c_out;
input [3:0] a, b;
input c_in;

// Internal nets
wire c1, c2, c3;

// Corrected defparam syntax
defparam fa0.d_sum = 1, fa0.d_cout = 1, 
         fa1.d_sum = 1, fa1.d_cout = 1, 
         fa2.d_sum = 1, fa2.d_cout = 1, 
         fa3.d_sum = 1, fa3.d_cout = 1;

// Instantiate four 1-bit full adders
fulladd fa0(sum[0], c1, a[0], b[0], c_in);
fulladd fa1(sum[1], c2, a[1], b[1], c1);
fulladd fa2(sum[2], c3, a[2], b[2], c2);
fulladd fa3(sum[3], c_out, a[3], b[3], c3);

endmodule

// Define a 1-bit full adder
module fulladd(sum, c_out, a, b, c_in);
parameter d_sum = 0, d_cout = 0;

// I/O port declarations
output sum, c_out;
input a, b, c_in;

// Internal nets
wire s1, c1, c2;  // Fixed the typo from cl to c1

// Instantiate logic gate primitives
xor (s1, a, b);
and (c1, a, b);

xor #(d_sum) (sum, s1, c_in); 
and (c2, s1, c_in);

or #(d_cout) (c_out, c2, c1);

endmodule
