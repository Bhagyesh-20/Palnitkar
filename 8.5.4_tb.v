module tb;
    reg [3:0] number;
    wire [31:0] out;
 reg [31:0] out1;
    factorial_task ft(.number(number), .out(out));

    initial begin
        //$monitor( $time);
        $monitor($time,number,out);
        //$monitor ($time,out);
        number <= 1; #10;
        number <= 2; #10;
        number <= 3; #10;
        number <= 4; #10;
        number <= 5; #10;
    end
endmodule