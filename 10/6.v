module top_module;
endmodule


module dff(input clk,reset,d,output reg q ,qbar);
    specify
        specparam t_01 = 4, t_10 = 5, t_0z = 7, t_z1 = 2, t_1z = 3, t_z0 = 8;

        (clk => q) = (t_01, t_10, t_0z, t_z1, t_1z, t_z0);
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