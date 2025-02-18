module init;
    reg [3:0] cache_var[1023:0];  
    integer i;
    initial begin

      
        for (i = 0; i < 1024; i = i + 1) begin
            cache_var[i] = 4'b0000;  
        end
        $monitor("cache_var[0] = %b, cache_var[1] = %b, ...", cache_var[0], cache_var[1]); 
    end
    
endmodule
