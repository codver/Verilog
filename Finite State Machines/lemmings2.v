/*  Problem statement :
   In addition to walking left and right, Lemmings will fall (and presumably go "aaah!") if the ground disappears underneath them.

In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!".
When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. 
Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling),
or when the ground reappears while still falling, also does not affect the walking direction.  */

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    //declaring the states
    parameter LEFT = 0, RIGHT = 1, LEFTaah = 2, RIGHTaah = 3;
    reg [1:0] state, next_state;
    
    
    //state-transitions
    always @(*) begin
        case(state)
            LEFT:   begin if(ground)
                                  next_state  = (bump_left)  ? RIGHT : LEFT;
                          else    next_state  = LEFTaah; end
            
            RIGHT:  begin if(ground)
                                  next_state = (bump_right) ? LEFT  : RIGHT;
                else    next_state = RIGHTaah; end
            
            LEFTaah : begin   if(ground)
                               next_state = LEFT;
                else   next_state = LEFTaah; end
            RIGHTaah : begin if(ground)
                                  next_state = RIGHT;
                       else   next_state  = RIGHTaah;
            end
        endcase
        
    end
            
    
    //state flip-flops
   always @(posedge clk, posedge areset) begin
       if(areset) state <= LEFT;
       else       state <= next_state;
   end
    
    //output - logic
    assign walk_left  =  (state == LEFT) ;
    assign walk_right =  (state == RIGHT);
    assign aaah        =  (state == LEFTaah) || (state == RIGHTaah);
   
        

endmodule
