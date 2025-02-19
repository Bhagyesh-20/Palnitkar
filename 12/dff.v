module dff(clk,Reset, D, Q);
    input clk, Reset, D;
    output Q;
    reg Q;
    always @(posedge clk or posedge Reset)
    begin
        if(Reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule


module top_module;
    reg clk, Reset, D;
    wire Q;
    dff uut(clk, Reset, D, Q);
    initial begin
        clk = 0;
        Reset = 0;
        D = 0;
        #10 Reset = 1;
        #10 Reset = 0;
        #10 D = 1;  
        #10 D = 0;
endmodule