

module top_module(input a,b,cin,output sum,carry);

    fa fa0( .a(a),.b(b),.cin(cin),.sum(sum), .carry(carry));
    initial begin
        #15 force fa0.sum = a&b&cin;
        #35 release fa0.sum;
    end
endmodule


module fa(input a,b,cin,output sum, carry);
    always @(*) begin
        sum = a^b^cin;
        carry = a&b|b&cin|cin&a;
    end
endmodule