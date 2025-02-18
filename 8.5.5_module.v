module task_parity(input [15:0] number, output reg out);

    task parity_checker;
        input [15:0] number;
        output reg out;
        integer i;
        begin
            out = 0;
            for(i = 0; i < 16; i = i + 1) begin
                out = out ^ number[i]; 
            end
        end
    endtask

    always @* begin
        parity_checker(number, out);  
    end
endmodule