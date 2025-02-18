module factorial(input [3:0] number, output reg [31:0] out);

  function automatic [31:0] factorial;
    input [3:0] num;
    begin
        if (num <= 1)
            factorial = 1;
        else
            factorial = num * factorial(num - 1);
    end
endfunction

  always@(*)begin
        out = factorial(number);
    end
    

endmodule