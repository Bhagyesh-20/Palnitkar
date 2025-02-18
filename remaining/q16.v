module q16;
    reg a = 0;
    initial begin
        monitor($time,a);
    repeat(20)begin 
    end
    a = a+1;
    end
endmodule