`timescale 1ns/1ps

module counter_tb;
    reg clk, cn_en, clear, preset;
    wire [3:0] q;

    counter uut (
        .clk(clk),
        .cn_en(cn_en),
        .clear(clear),
        .preset(preset),
        .q(q)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        cn_en = 0;
        clear = 0;
        preset = 0;

        #5 clear = 1; #10 clear = 0;
        $display("After Clear: q = %b", q);

        #5 preset = 1; #10 preset = 0;
        $display("After Preset: q = %b", q);

        #10 cn_en = 1;

        #100;

        #10 cn_en = 0;

        #50;

        $stop;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time = %0t | clk = %b | cn_en = %b | clear = %b | preset = %b | q = %b", 
                 $time, clk, cn_en, clear, preset, q);
    end
endmodule


module counter(input clk, cn_en, clear, preset, output reg [3:0] q);
    wire w1, w2, w3;

    assign w1 = cn_en & q[0];        
    assign w2 = w1 & q[1];
    assign w3 = w2 & q[2];

    jk_ff ff0(q[0], clk, cn_en, cn_en, clear, preset);
    jk_ff ff1(q[1], clk, w1, w1, clear, preset);
    jk_ff ff2(q[2], clk, w2, w2, clear, preset);
    jk_ff ff3(q[3], clk, w3, w3, clear, preset);
endmodule

primitive jk_ff(output q, input clk, j, k, clear, preset);
    reg q;
    table
    // clk  j  k  clear preset : q : q+
       ?    ?  ?   1     0     : ? : 0;  // Asynchronous Clear
       ?    ?  ?   0     1     : ? : 1;  // Asynchronous Preset
       ?    ?  ?   1     1     : ? : x;  // Invalid Case
       (10) 0  0   0     0     : ? : -;  // Hold value on falling edge
       (10) 0  1   0     0     : ? : 0;  // Reset
       (10) 1  0   0     0     : ? : 1;  // Set
       (10) 1  1   0     0     : 0 : 1;  // Toggle 0 → 1
       (10) 1  1   0     0     : 1 : 0;  // Toggle 1 → 0
       (01) ?  ?   0     0     : ? : -;  // Hold value on rising edge
       (x?) ?  ?   0     0     : ? : -;  // Hold value on unknown clk transitions
    endtable
endprimitive
