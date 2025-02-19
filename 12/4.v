module top_module;
endmodule


// Primitive definition
primitive edge_dff(q,d,clk,clear);
    output q;
    reg q;
    input d,clk,clear;
    table 
        // d clk clear : q : q+
        ? ?   0  : ? : 0; // Hold value when clk = x
        ? ? (01) : ? : 0; // Clear active, q = 0
        ? ? (10) : ? : -; // Clear inactive, hold value
        0 (01)   0  : ? : 0; // Transparent when clk = 1, latch d=0 
        1 (01)   0  : ? : 1; // Transparent when clk = 1, latch d=1
        ?  0x   0  : ? : -; // Hold value when clk = 0
        ?  1x   0  : ? : -; // Hold value when clk = 1
            
    endtable
endprimitive