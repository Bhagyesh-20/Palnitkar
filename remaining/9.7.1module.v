module dff(input clk, clear, preset,d,output reg q, reg qbar);
    always@(posedge clk)begin
        q<=d;
    end
    always@(clear or preset)begin
        if(clear)begin
            assign q = 1'b0;
            assign qbar = 1'b1;
        end
        else if(preset)begin
            assign q = 1'b1;
            assign qbar = 1'b0;
        end
        else begin
            deassign q;
            deassign qbar;
        end
    end
endmodule