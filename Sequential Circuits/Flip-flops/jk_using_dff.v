//jk flip-flop using d flip-flops  10:34  18-06-2021 FRI
`timescale 1ns / 1ps
module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    
    always @(posedge clk) begin
        case(j)
            1'b0: case(k)
                        1'b0:  Q <= Q;
                        1'b1:  Q <= 0;
            endcase 
            1'b1: case(k)
                       1'b0:  Q <= 1'b1;
                       1'b1:  Q <= ~Q;
            endcase
        endcase
    end
                

endmodule
