//14:30   18-06-2021 FRI
//a decade counter that counts from 0 through 9, inclusive, with a period of 10
//We want to be able to pause the counter rather than always incrementing every clock cycle
// so the slowena input indicates when the counter should increment.
// The reset input is synchronous, and should reset the counter to 0.

`timescale 1ns / 1ps
module top_module (
    input               clk,
    input               slowena,
    input               reset, //synchronous
    output reg [3:0]    q=4'b0000);

    always @(posedge clk) begin
        if(reset) q <= 4'b0000;
        else begin
            #10 if(slowena)  begin
                        if(q == 4'b1001)   q = 4'b0000;
                        else    q <= q + 1'b1;
                end
                else q <= q ;
            end       
         end       
endmodule
