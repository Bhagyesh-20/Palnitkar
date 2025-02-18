module factorial_task(input [3:0] number, output reg [31:0] out);
    task automatic factorial;
        output reg [31:0] out;
        
        input reg [3:0] num;
        reg [31:0]out1;
        integer i;
        
        begin
        
            out1 =1;
            
            for (i = 1; i <= num; i = i + 1) begin
            
                  out1 = out1 * i; 
                  
                  out=out1;
            end
      
        end
    endtask

    always @(*) begin
    #10;
        factorial(out, number);  
    end
endmodule