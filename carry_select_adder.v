module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire cout1, cout2, cout3;
wire [15:0] sum1, sum2, sum3, sum4;
wire cin1=1;
wire cin0=0;

add16 add1(.a(a[15:0]),  .b(b[15:0]),   .cin(cin0),  .sum(sum1),  .cout(cout1) ); 
add16 add2(.a(a[31:16]), .b(b[31:16]),  .cin(cin0),  .sum(sum2),  .cout(cout2) ); 
add16 add3(.a(a[31:16]), .b(b[31:16]),  .cin(cin1),  .sum(sum3),  .cout(cout3) ); 

assign sum = {(cout?sum3:sum2),sum1}


endmodule



   assign overflow = (~(a^b))|((a[7]|b[7]&(a[6]&b[6])));
