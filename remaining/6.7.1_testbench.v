module tb;

reg x,y,z;
wire difference,borrow;

full_subtractor fs1(.x(x),.y(y),.z(z),.difference(difference),.borrow(borrow));

    initial begin
    $monitor("x = %b | y = %b | z = %b | difference = %b | borrow = %b",x,y,z,difference,borrow);
        x=0;y=0;z=0;
    #5  x=0;y=0;z=1;
    #5  x=0;y=1;z=0;
    #5  x=0;y=1;z=1;
    #5  x=1;y=0;z=0;
    #5  x=1;y=0;z=1;
    #5  x=1;y=1;z=0;
    #5  x=1;y=1;z=1;

    end

endmodule