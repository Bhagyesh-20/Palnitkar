module tb;

reg in0,in1,s;
wire out;

two1mux dut(.in0(in0),.in1(in1),.s(s),.out(out));

initial begin

       in0 = 0; in1 = 0; s = 0;
    #5 in0 = 0; in1 = 0; s = 1;
    #5 in0 = 0; in1 = 1; s = 0;
    #5 in0 = 0; in1 = 1; s = 1;
    #5 in0 = 1; in1 = 0; s = 0;
    #5 in0 = 1; in1 = 0; s = 1;
    #5 in0 = 1; in1 = 1; s = 0;
    #5 in0 = 1; in1 = 1; s = 1;

end

initial begin

    $monitor("in0=%b in1=%b s=%b out=%b",in0,in1,s,out);

end

endmodule