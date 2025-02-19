module top_module;
    reg m,n,p,q;
    wire out;

    y dut(.m(m),.n(n),.p(p),.q(q),.out(out));

    initial begin
      $monitor($time," ",m,n,n,q,out);
        #10;
        repeat(20) begin
            m = $random;
            n = $random;
            p = $random;
            q = $random;
        end
    end
endmodule

module y(input m,n,p,q, output reg out);
    reg e,f;
	
  always@(*) begin
     e = m|n;
     f = p&q;
    #15 out = e|f;
  end
endmodule


