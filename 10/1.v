module top_module;
    reg m,n,p,q;
    wire out;

    y(.m(m),.n(n),.p(p),.q(q),.out(out));

    initial begin
        $monitor($time,m,n,n,q,out);
        #10;
        repeat(20) begin
            m = $random;
            n = $random;
            p = $random;
            q = $random;
        end
    end
endmodule

module y(input m,n,p,q, output out);

    specify
        (m => e) = 11;
        (n => e) = 11;
        (p => f) = 8;
        (q => f) = 8;
        (e => out) = 4;
        (f => out) = 4;
    endspecify

    wire e,g;

    assign e = m|n;
    assign g = p|q;
    assign out = e|g;

endmodule