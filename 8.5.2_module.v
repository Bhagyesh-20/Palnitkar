module multiply(input [3:0]a,input [3:0] b,output reg [7:0] out);
    function [7:0] mul;
            input [3:0] a;
            input [3:0] b;
            begin
                mul = a*b;
            end
    endfunction

    always@(*)begin
        out = mul(a,b);
    end

endmodule