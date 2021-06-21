/* 21-06-2021 MON 10:33
Problem statement :  A linear feedback shift register is a shift register usually with a few XOR gates to produce the next state of the shift register. 
                    A Galois LFSR is one particular arrangement where bit positions with a "tap" are XORed with the output bit to produce its next value,
                    while bit positions without a tap shift. If the taps positions are carefully chosen, the LFSR can be made to be "maximum-length".
                    A maximum-length LFSR of n bits cycles through 2n-1 states before repeating (the all-zero state is never reached).

*/

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
   
    always @(posedge clk) begin
        if(reset) q <= 5'h1;
        else begin
            q[4] <= 0 ^ q[0];
            q[3] <= q[4];
            q[2] <= q[3] ^ q[0];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end
    assign q = {q[4],q[3],q[2],q[1],q[0]};
            

endmodule

/* Alternate solution : module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] q_next;		// q_next is not a register

	// Convenience: Create a combinational block of logic that computes
	// what the next value should be. For shorter code, I first shift
	// all of the values and then override the two bit positions that have taps.
	// A logic synthesizer creates a circuit that behaves as if the code were
	// executed sequentially, so later assignments override earlier ones.
	// Combinational always block: Use blocking assignments.
	always @(*) begin
		q_next = q[4:1];	// Shift all the bits. This is incorrect for q_next[4] and q_next[2]
		q_next[4] = q[0];	// Give q_next[4] and q_next[2] their correct assignments
		q_next[2] = q[3] ^ q[0];
	end
	
	
	// This is just a set of DFFs. I chose to compute the connections between the
	// DFFs above in its own combinational always block, but you can combine them if you wish.
	// You'll get the same circuit either way.
	// Edge-triggered always block: Use non-blocking assignments.
	always @(posedge clk) begin
		if (reset)
			q <= 5'h1;
		else
			q <= q_next;
	end
	
endmodule
*/
