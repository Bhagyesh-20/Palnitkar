module ms_jk_ff(input clk, clear, j, k, output q, output qbar);

    wire master_q, master_qbar;
    wire slave_q, slave_qbar;
    wire clkbar;

    // Invert Clock for Slave FF
    assign clkbar = ~clk;

    // Master Flip-Flop (Level-Sensitive Latch)
    assign master_q = (~(j & clk & master_qbar) & ~(k & clk & master_q)) & ~clear;
    assign master_qbar = ~master_q;

    // Slave Flip-Flop (Level-Sensitive Latch)
    assign slave_q = (~(master_q & clkbar & slave_qbar) & ~(master_qbar & clkbar & slave_q)) & ~clear;
    assign slave_qbar = ~slave_q;

    // Final Outputs
    assign q = slave_q;
    assign qbar = slave_qbar;

endmodule
