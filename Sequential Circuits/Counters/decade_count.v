//A decade counter (0-9) with synchronous-actice-high reset 11:23 18-06-2021 FRI

`timescale 1ns / 1ps
module top_module (
    input              clk,
    input              reset,        // Synchronous active-high reset
    output reg[3:0]    q = 4'b0000);
    
    always @(posedge clk) begin
        if(reset)  q <= 4'b0000;
        else   begin
            if(q == 4'b1001)
                q <= 4'b0000;
            else 
                q <= q + 1'b1;
        end
    end

endmodule
