

`timescale 1ns / 1ps

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    
    always @(posedge clk or posedge areset ) begin
        if(areset) q <= 0;
        else begin
            if(load)  q <= data;     
           else  if(ena) begin
               
                q[0] <= q[1];
                q[1] <= q[2];
                q[2] <= q[3];
                q[3] <= 0;
            end
        end
    end
	 
	 /*
	 
	 // The shift register has four modes:
	//   reset
	//   load
	//   enable shift
	//   idle -- preserve q (i.e., DFFs)
	 	always @(posedge clk, posedge areset) begin
		if (areset)		// reset
			q <= 0;
		else if (load)	// load
			q <= data;
		else if (ena)	// shift is enabled
			q <= q[3:1];	// Use vector part select to express a shift.
	end
	*/


endmodule
