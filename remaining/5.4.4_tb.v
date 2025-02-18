module tb;
reg s,r;
wire q,qbar;

sr_nor dut(.s(s),.r(r),.q(q),.qbar(qbar));

initial begin
    #5 s = 0; r = 0;
    #5 s = 1; r = 0;
    #5 s = 0; r = 1;
    #5 s = 1; r = 1;

end

initial begin
    $monitor("s=%b r=%b q=%b qbar=%b",s,r,q,qbar);
    end
endmodule
