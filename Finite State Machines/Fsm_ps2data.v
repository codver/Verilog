/*
  Problem Statement : Now that you have a state machine that will identify three-byte messages in a PS/2 byte stream, 
  add a datapath that will also output the 24-bit (3 byte) message whenever a packet is received (out_bytes[23:16] is the first byte, out_bytes[15:8] is the second byte, etc.).

out_bytes needs to be valid whenever the done signal is asserted. You may output anything at other times (i.e., don't-care). */

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    reg [3:0] state, next_state;
    reg [23:0] data;
    parameter BYTE1 = 0, BYTE2 = 1, BYTE3 = 2, DONE = 3;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            BYTE1:   next_state = (in[3] == 0) ? BYTE1 : BYTE2;
                
            BYTE2:   next_state = BYTE3;
                                 
            BYTE3: next_state = DONE;
               
            DONE:   next_state = (in[3] == 0) ? BYTE1 : BYTE2;
        endcase
    end
    

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) state <= BYTE1;
        else      state <= next_state;
    end
    
    assign done  = (state == DONE);

    // New: Datapath to store incoming bytes.
    
    always  @(posedge clk) begin
        if(reset) data <= 24'b0;
        else begin
            data[23:16] <= data[15:8];
            data[15:8] <= data[7:0];
            data[7:0] <= in;
        end
    end
    
    assign out_bytes = (done == 1) ? data : 24'bx;
        
endmodule
