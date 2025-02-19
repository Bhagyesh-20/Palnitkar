module top_module;
    reg a, b, c, d;
    wire out, expected_out;

    y y1(out, a, b, c, d);

    assign expected_out = (a & b) | (c ^ d);

    initial begin
        $monitor("Time=%0t | a=%b, b=%b, c=%b, d=%b | out=%b | Expected=%b | %s", 
                 $time, a, b, c, d, out, expected_out, 
                 (out == expected_out) ? "PASS" : "FAIL");

        a = 0; b = 0; c = 0; d = 0; #10;
        a = 0; b = 0; c = 0; d = 1; #10;
        a = 0; b = 0; c = 1; d = 0; #10;
        a = 0; b = 0; c = 1; d = 1; #10;
        a = 0; b = 1; c = 0; d = 0; #10;
        a = 0; b = 1; c = 0; d = 1; #10;
        a = 0; b = 1; c = 1; d = 0; #10;
        a = 0; b = 1; c = 1; d = 1; #10;
        a = 1; b = 0; c = 0; d = 0; #10;
        a = 1; b = 0; c = 0; d = 1; #10;
        a = 1; b = 0; c = 1; d = 0; #10;
        a = 1; b = 0; c = 1; d = 1; #10;
        a = 1; b = 1; c = 0; d = 0; #10;
        a = 1; b = 1; c = 0; d = 1; #10;
        a = 1; b = 1; c = 1; d = 0; #10;
        a = 1; b = 1; c = 1; d = 1; #10;

        $finish;
    end
endmodule

primitive y(out, a, b, c, d);
    output out;
    input a, b, c, d;

    table
        // a  b  c  d : out
         0  0  0  0  : 0;
         0  0  0  1  : 1;
         0  0  1  0  : 1;
         0  0  1  1  : 0;
         0  1  0  0  : 0;
         0  1  0  1  : 1;
         0  1  1  0  : 1;
         0  1  1  1  : 0;
         1  0  0  0  : 0;
         1  0  0  1  : 1;
         1  0  1  0  : 1;
         1  0  1  1  : 0;
         1  1  0  0  : 1;
         1  1  0  1  : 1;
         1  1  1  0  : 1;
         1  1  1  1  : 1;
    endtable
endprimitive
