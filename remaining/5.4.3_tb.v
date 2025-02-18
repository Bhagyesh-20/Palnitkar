module tb;
  
  reg a,b,c_in;
  wire sum, c_out;
  
  full_adder fa1(.a(a),.b(b),.c_in(c_in),.sum(sum),.c_out(c_out));
  
  initial begin
    #5 a = 0; b = 0; c_in = 0;
    #5 a = 0; b = 0; c_in = 1;
    #5 a = 0; b = 1; c_in = 0;
    #5 a = 0; b = 1; c_in = 1;
    #5 a = 1; b = 0; c_in = 0;
    #5 a = 1; b = 0; c_in = 1;
    #5 a = 1; b = 1; c_in = 0;
    #5 a = 1; b = 1; c_in = 1;

  end

  initial begin
    
    $monitor($time, " a=%b b=%b c_in=%b sum=%b cout=%b", a, b,c_in, sum,c_out);

  end
  
endmodule