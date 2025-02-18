module top_module;
    reg c_in,
    reg [3:0] a,b;
    wire [3:0] sum; 
    wire c_out;
    reg [31:0] ran_gen;

    fulladd4 fa0(.sum(sum),.c_out(c_out),.a(a),.b(b),.c_in(c_in));

    initial begin
        repeat(20) begin
            ran_gen = $random;
            a = ran_gen[3:0];
            b = ran_gen[7:4];
            c_in = ran_gen[8];
        end
    end
endmodule

module fulladd4(sum, c_out, a, b, c_in) ;

output [3:0] sum;
output c_out;
input [3:0] a, b;
input c_in;

assign {c_out, sum} = a + b + c_in;

endmodule