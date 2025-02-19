module top_module;
    reg clk, preset, d;
    wire q;

    // Instantiate the latch
    lsl lsl_inst(q, clk, preset, d);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top_module);

        // Initialize signals
        clk = 0;
        preset = 0;
        d = 0;
    end

    // Generate clock signal
    always #5 clk = ~clk;  

    // Apply all possible test cases
    initial begin
        // Test latch transparency when clk = 0
        #10 d = 1;               // Expect q = 1
        #10 d = 0;               // Expect q = 0
        #10 preset = 1;          // Expect q = 1 (preset forces q = 1)
        #10 preset = 0;          // Expect q holds value

        // Test clock edge effects
        #10 clk = 1; d = 1;      // q should hold previous value
        #10 clk = 1; d = 0;      // q should still hold previous value
        #10 clk = 0; d = 1;      // q should now follow d = 1
        #10 clk = 0; d = 0;      // q should now follow d = 0

        // Test unknown values
        #10 preset = 1;          // Expect q = 1
        #10 preset = 0;          // Expect q holds value
        #10 preset = 1; clk = 1; // Expect q = 1 (preset has priority)
        #10 preset = 0; clk = 1; // Expect q holds value
        #10 preset = 'bx;        // Expect q = x (unknown preset)

        #10 $finish;  // End simulation
    end
endmodule

// Corrected primitive definition
primitive lsl(q, clk, preset, d);
    output q;
    input clk, preset, d;
    
    reg q; // Internal state storage

    table
    // clk preset d : q : q+
        0   0     0 : ? : 0;  // Transparent when clk = 0, latch d=0
        0   0     1 : ? : 1;  // Transparent when clk = 0, latch d=1
        1   0     ? : ? : -;  // Hold value when clk = 1
        x   0     ? : ? : -;  // Hold value when clk = x
        ?   1     ? : ? : 1;  // Preset active, q = 1
        ?   x     ? : ? : x;  // Unknown preset leads to unknown state
    endtable
endprimitive
