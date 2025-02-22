module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg[2:0] count;
    always@(posedge clk)begin
        if(reset)begin
            count <= 0;
            shift_ena <= 1'b1;
        end
        else if(count <3)begin
            count <= count + 1;
            shift_ena <= 1;
        end
        else begin
            shift_ena <= 0;
        end
    end

endmodule
