/* 28-06-2021 MON

Problem statement : 
In addition to walking and falling, Lemmings can sometimes be told to do useful things, like dig (it starts digging when dig=1). 
A Lemming can dig if it is currently walking on ground (ground=1 and not falling), and will continue digging until it reaches the other side (ground=0). 
At that point, since there is no ground, it will fall (aaah!), then continue walking in its original direction once it hits ground again.
As with falling, being bumped while digging has no effect, and being told to dig when falling or when there is no ground is ignored.

(In other words, a walking Lemming can fall, dig, or switch directions.
If more than one of these conditions are satisfied, fall has higher precedence than dig, which has higher precedence than switching directions.)

Extend your finite state machine to model this behaviour.

bump ignored   */


module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT = 0, RIGHT = 1, LEFTAH=2, RIGHTAH=3,LEFTDIG=4,RIGHTDIG=5;
    reg [2:0] state, next_state;
    
    //state-transitions
    
    always @(*) begin
        case(state)
                LEFT:   begin
                            if(ground) begin
                                if(dig) begin
                                    next_state = LEFTDIG;
                                end
                                else
                                    next_state = (bump_left) ? RIGHT : LEFT;
                            end
                         else
                             next_state = LEFTAH;
                         end
            
                RIGHT:   begin
                             if(ground) begin
                                 if(dig) begin
                                     next_state = RIGHTDIG;
                                 end
                                 else next_state = (bump_right) ? LEFT : RIGHT;
                             end
                             else next_state = RIGHTAH;
                         end
                        
          
                LEFTAH:  begin
                             if(ground) begin
                                   next_state = LEFT;
                                 end
                          else
                                 next_state = LEFTAH;
                         end
               
                RIGHTAH:  begin
                             if(ground) begin
                                   next_state = RIGHT;
                                 end
                          else
                                 next_state = RIGHTAH;
                         end
                
                LEFTDIG:  begin
                             if(ground)
                                 next_state = LEFTDIG;
                          else next_state = LEFTAH;
                end
               
                RIGHTDIG:   begin
                             if(ground)
                                 next_state = RIGHTDIG;
                          else next_state = RIGHTAH;
                               end
        endcase
                
        
    end
    
    //state flip-flops
    always @(posedge clk, posedge areset) begin
        if(areset) state <= LEFT;
         else state <= next_state;
    end
    
    //output  logic
            assign walk_left = (state == LEFT);
            assign walk_right = (state == RIGHT);
            assign aaah = (state == LEFTAH) || (state == RIGHTAH);
            assign digging = (state == LEFTDIG) || (state == RIGHTDIG);
endmodule

