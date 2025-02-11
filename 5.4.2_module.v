//Or Gate using nand gates 2 inputs
module my_or(input x,y,output result_or);
  wire xbar,ybar;
  nand(xbar,x,x);
  nand(ybar,y,y);
  
  nand(result_or,xbar,ybar);
  
endmodule

//And Gate using nand gates 2 inputs
module my_and(input x,y,output result_and);
  wire abar;
  nand(abar,x,y);
  nand(result_and,abar,abar);
endmodule


//Not Gate using nand gates 2 inputs
module my_not(input x,output result_not);
  wire xbar;
  
  nand(result_not,x,x);
  
endmodule

module my_xor(input x, y, output result_xor);
  wire not_x, not_y, result_and1, result_and2;

  // Instantiating NOT gates
  my_not not1 (.x(x), .result_not(not_x));
  my_not not2 (.x(y), .result_not(not_y));

  // Instantiating AND gates
  my_and and1 (.x(not_x), .y(y), .result_and(result_and1));
  my_and and2 (.x(not_y), .y(x), .result_and(result_and2));

  // Instantiating OR gate
  my_or or1 (.x(result_and1), .y(result_and2), .result_or(result_xor));

endmodule
