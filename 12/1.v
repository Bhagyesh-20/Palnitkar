module top_module;
    reg in0,in1,sel;
    wire out;
    mux2_1 mux1(out,in0,in1,sel);
    initial begin
        $monitor("in0=%b, in1=%b, sel=%b, out=%b", in0, in1, sel, out);
            in0 = 0; in1 = 1; sel = 0;
        #10 in0 = 1; in1 = 0; sel = 1;
        #10 in0 = 0; in1 = 0; sel = 1;
        #10 in0 = 1; in1 = 1; sel = 0;
        #10 in0 = 0; in1 = 1; sel = 1;
        #10 in0 = 1; in1 = 0; sel = 0;
        #10 in0 = 0; in1 = 0; sel = 0;
        #10 in0 = 1; in1 = 1; sel = 1;
        #10 in0 = 0; in1 = 1; sel = 1'bx;
        #10 in0 = 1; in1 = 0; sel = 1'bx;
        #10 in0 = 0; in1 = 0; sel = 1'bx;
        #10 in0 = 1; in1 = 1; sel = 1'bx;
        #10 $finish;
    end
endmodule

primitive mux2_1(out, in0, in1, sel);
    output out;
    input in0, in1, sel;

    table
       0    ?    0  : 0;  
       1    ?    0  : 1;  
       ?    0    1  : 0;  
       ?    1    1  : 1;  
       ?    ?    x  : 0;  
    endtable
endprimitive
