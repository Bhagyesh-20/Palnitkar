module fx1mux(input [3:0] in,[1:0] sel,output out);

    always@(*)begin
    
        case(sel)
        2'b00: out = in[0];
        2'b01: out = in[1];
        2'b10: out = in[2];
        2'b11: out = in[3];
        endcase
    
    end
endmodule
 
module tb;
    reg [3:0] in;
    reg [1:0] sel;
    wire out;
    
    fx1mux dut(.in(in), .sel(sel), .out(out));
    
    initial begin
        $monitor("Time = %0t | in = %b | sel = %b | out = %b", $time, in, sel, out);
        
        repeat(10) begin
            in = $random;
            sel = $random;
            #10;
        end
        
        $finish;
    end
endmodule
