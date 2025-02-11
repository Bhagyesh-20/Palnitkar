module two1mux(input in0,in1,s,output out);

    bufif0 #(1:2:3,3:4:5,5:6:7) b1(out,in1,s);
    bufif1 #(1:2:3,3:4:5,5:6:7) b2(out,in0,s);

endmodule