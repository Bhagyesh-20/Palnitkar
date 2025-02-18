module traffic_control(input X, output reg hwy, reg cty);
`define GREEN 1'b00;
`define YELLOW 1'b01;
`define RED 1'b10;

initial begin
    hwy = GREEN;
    cty = RED;
end


endmodule
