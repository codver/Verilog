//A binary counter from 0-15  11:05 18-06-2021 FRI
`timescale 1ns / 1ps

module top_module (
    input                clk,
    input                reset,      // Synchronous active-high reset
    output reg [3:0]     q=4'b0000);
    
    always @(posedge clk) begin
        if(reset)  q <= 4'b0;
        else       q <= q + 1'b1;
    end

endmodule
