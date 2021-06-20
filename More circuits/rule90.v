/* 21:27 20-06-2021 SUN

Problem statement : Rule 90 is a one-dimensional cellular automaton with interesting properties.

The rules are simple. There is a one-dimensional array of cells (on or off).
At each time step, the next state of each cell is the XOR of the cell's two current neighbours. 
A more verbose way of expressing this rule is the following table, where a cell's next state is a function of itself and its two neighbours.
(The name "Rule 90" comes from reading the "next state" column: 01011010 is decimal 90.)


In this circuit, create a 512-cell system (q[511:0]), and advance by one time step each clock cycle. 
The load input indicates the state of the system should be loaded with data[511:0]. 
Assume the boundaries (q[-1] and q[512]) are both zero (off). */

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    always @(posedge clk) begin
        if(load) begin
            q <= data;
            
        end
        else begin
            q[0]   <= 1'b0 ^ q[1];
            q[511] <= 1'b0 ^ q[510];
           
            for(int i=1; i<=510; i++)
                q[i] <= q[i-1] ^ q[i+1];
        end
    end
endmodule


/* ALTERNATE :
module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	always @(posedge clk) begin
		if (load)
			q <= data;	// Load the DFFs with a value.
		else begin
			// At each clock, the DFF storing each bit position becomes the XOR of its left neighbour
			// and its right neighbour. Since the operation is the same for every
			// bit position, it can be written as a single operation on vectors.
			// The shifts are accomplished using part select and concatenation operators.
			
			//     left           right
			//  neighbour       neighbour
			q <= q[511:1] ^ {q[510:0], 1'b0} ;
		end
	end
endmodule
*/
