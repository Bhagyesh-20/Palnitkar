module sr_nor(input s, r,output q,qbar); 

wire nor1,nor2;

nor(q,qbar,r);
nor(qbar,q,s);

endmodule