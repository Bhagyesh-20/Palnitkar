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

module my_xor(input x,y,output result_xor);
  wire not_x,not_y,result_and1,result_and2,result_or;

  my_not not1(not_x,x);
  my_not not2(not_y,y);
  my_and and1(result_and1,not_x,y);
  my_and and2(result_and2,not_y,x);
  my_or or1(result_or,result_and1,result_and2);

endmodule
