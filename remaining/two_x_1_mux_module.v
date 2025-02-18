module twox1mux (input in0,in1, select, 
    output out
    );
    
    wire and1,and2,select_bar;
    not(select_bar,select);
    and(and1,select_bar,in0);
    and(and2,select,in1);
    or(out,and1,and2);

endmodule