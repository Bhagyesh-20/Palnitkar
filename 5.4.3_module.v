module full_adder(
    input a,b,c_in,
    output sum, c_out
);

wire and1,and2,and3,and4,and5,and6,and7;
wire not_c_in,not_a,not_b;

//For complement
not(not_c_in,c_in);
not(not_a,a);
not(not_b,b);

//                           For sum 
//And gates
and(and1,a,b,c_in);
and(and2,not_a,b,not_c_in);
and(and3,not_a,not_b,c_in);
and(and4,a,not_b,not_c_in);

//Or gates
or(sum,and1,and2,and3,and4);

//For Cout
and(and5,a,b);
and(and6,a,c_in);
and(and7,b,c_in);
or(c_out,and5,and6,and7);
    
endmodule