module top_module;
    reg clk, j, k, clear, preset;
    wire q;

    // Instantiate the JK Flip-Flop
    jk_ff uut(q, clk, j, k, clear, preset);

    // Clock generation (50% duty cycle)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("jk_ff_test.vcd");
        $dumpvars(0, top_module);

        // Initialize inputs
        clk = 0; j = 0; k = 0; clear = 0; preset = 0;
        
        // Apply test cases
        #5 clear = 1;  preset = 0;  // Asynchronous clear
        #5 clear = 0;  preset = 1;  // Asynchronous preset
        #5 clear = 1;  preset = 1;  // Both clear & preset (invalid)
        #5 clear = 0;  preset = 0;  // Normal operation

        // Check JK functionality on negative edge of clk
        #10 j = 0; k = 0;   // Hold state
        #10 j = 0; k = 1;   // Reset
        #10 j = 1; k = 0;   // Set
        #10 j = 1; k = 1;   // Toggle
        #10 j = 1; k = 1;   // Toggle again
        #10 j = 0; k = 1;   // Reset
        #10 j = 1; k = 0;   // Set
        #10 j = 0; k = 0;   // Hold state

        #10 $finish; // End simulation
    end
endmodule

primitive jk_ff(q, clk, j, k, clear, preset);
    output q;
    reg q;
    input clk, j, k, clear, preset;

    table
    // clk  j  k  clear preset : q : q+
       ?    ?  ?   1     0     : ? : 0;  // Asynchronous Clear (clear = 1)
       ?    ?  ?   0     1     : ? : 1;  // Asynchronous Preset (preset = 1)
       ?    ?  ?   1     1     : ? : x;  // Invalid Case (both clear & preset active)
       (10) 0  0   0     0     : ? : -;  // Hold value on falling edge
       (10) 0  1   0     0     : ? : 0;  // Reset on falling edge (j=0, k=1)
       (10) 1  0   0     0     : ? : 1;  // Set on falling edge (j=1, k=0)
       (10) 1  1   0     0     : 0 : 1;  // Toggle (0 → 1) on falling edge
       (10) 1  1   0     0     : 1 : 0;  // Toggle (1 → 0) on falling edge
       (01) ?  ?   0     0     : ? : -;  // Hold value on rising edge
       (x?) ?  ?   0     0     : ? : -;  // Hold value on unknown clk transitions
    endtable
endprimitive
