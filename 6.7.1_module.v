module full_subtractor(input x,y,z,output difference,borrow);

    assign difference = x^y^z;
    assign borrow = ((~x)&y) | ((~x)&z) | y&z;

endmodule

