module alu(input [3:0]a, input [3:0] b, input [2:0] select, output reg [4:0] out);

    always@(*)begin
        case(select)
            3'b000: out = (a)& 5'b11111;
            3'b001: out = (a+b)& 5'b11111;
            3'b010: out = (a-b)& 5'b11111;
            3'b011: out = (a/b)& 5'b11111;
            3'b100: out = (a%b)& 5'b11111;
            3'b101: out = (a<<1)& 5'b11111;
            3'b110: out = (a>>1)& 5'b11111;
            3'b111: out = (a>b)& 5'b11111;
        endcase
    end
endmodule

module tb;
    reg [3:0]a; reg [3:0] b; reg [2:0] select;
    wire [4:0] out;
    alu dut(.a(a),.b(b),.select(select),.out(out));
    
    initial begin
        $monitor($time,"a = %b b = %b select = %b out = %b",a,b,select,out);
        repeat(100) begin
            a = $random;
            b = $random;
            select= $random;
        end
    end

endmodule