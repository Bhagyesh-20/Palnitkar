module top_module;
endmodule
module dff(input clk,reset,d,output reg q ,qbar);
    specify
        (d,reset *> qbar) = 5;
        (d,reset *> q) = 5;
        
      if(~d) (clk => q) = 5;
            (clk => qbar) = 4;
        
      if(d)(clk => q) = 6;
            (clk => qbar) = 7;
        
        $setup(d,posedge clk, 8);
        $hold(d,posedge clk, 4);
        $width(reset,42);

    endspecify  

    always @(negedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
            qbar <= 1'b1;
        end
        else begin
            q <= d;
            qbar <= ~d;
        end
    end
endmodule