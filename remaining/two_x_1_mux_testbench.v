// Code your testbench here
// or browse Examples
module tb;
reg in0,in1,select;
wire out;
twox1mux dut(.in0(in0),.in1(in1),.select(select),.out(out));


initial begin
    {in0, in1, select} <= 0;

  $monitor ("T=%0t in0=%0b in1=%0b select=%0b out=%0b", $time, in0, in1, select, out);
    for(int i=0;i<10;i=i+1)begin
    
       #1 in0 <= $random;
        in0 <= $random;
        select <= $random;
    end
    end

endmodule