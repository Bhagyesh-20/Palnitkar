module tb;
  
  reg x,y;
  wire result_or,result_and,result_not;
  
  my_xor(.x(x),.y(y),.result_xor(result_xor));
  
  initial begin
    #0 x = 0; y = 0;
    #5 x = 0; y = 1;
    #5 x = 1; y = 0;
    #5 x = 1; y = 1;
  end
  
  initial begin
    
    $monitor($time, " x=%b y=%b | result_or=%b result_and=%b result_notx=%b", x, y, result_or, result_and, result_not);

  end
  
endmodule