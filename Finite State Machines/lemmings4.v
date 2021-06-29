/* Problem statements : 
Although Lemmings can walk, fall, and dig, Lemmings aren't invulnerable. If a Lemming falls for too long then hits the ground, it can splatter. 
In particular, if a Lemming falls for more than 20 clock cycles then hits the ground, it will splatter and cease walking, falling, or digging (all 4 outputs become 0), 
forever (Or until the FSM gets reset). There is no upper limit on how far a Lemming can fall before hitting the ground. 
Lemmings only splatter when hitting the ground; they do not splatter in mid-air. */



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
    
    parameter LEFT = 3'd0, RIGHT = 3'd1, FALL_L = 3'd2, FALL_R = 3'd3, LEFTDIG = 3'd4, RIGHTDIG = 3'd5, SPLAT = 3'd6;
    reg [63:0] counter;
    reg [2:0] state, next_state;
    
    //state-transition
    always @(*) begin
        case(state)
            LEFT:  begin
                if(~ground) next_state = FALL_L;
                else if (dig) next_state = LEFTDIG;
                else if(bump_left) next_state = RIGHT;
                else next_state = LEFT;
                
            end
            
                
                
            RIGHT: begin
                if(~ground) next_state = FALL_R;
                else if (dig) next_state = RIGHTDIG;
                else if(bump_right) next_state = LEFT;
                else next_state = RIGHT;
                
                  end
           
                
           FALL_L:   if(ground) begin
                        if(counter>19)
                              next_state = SPLAT;
                        else
                            next_state = LEFT;
                      end
                    else 
                        next_state = FALL_L;
                        
            
                
           FALL_R: if(ground) begin
                        if(counter>19)  next_state = SPLAT;
                        else next_state = RIGHT;
                        end
                    else 
                        next_state = FALL_R;
                
            LEFTDIG:  if(ground) 
                          next_state = LEFTDIG;
                      else
                          next_state = FALL_L;
                
            RIGHTDIG: if(ground) 
                          next_state = RIGHTDIG;
                
                      else
                          next_state = FALL_R;
                
                
            SPLAT:   
                         next_state = SPLAT;
                endcase
    end
    
    
    //state flip-flops
    always @(posedge clk, posedge areset) begin
          if(areset)
            state <= LEFT;
        else if(state == FALL_L || state == FALL_R) begin
            state <= next_state;
            counter <= counter + 1;
        end
        else begin
            state <= next_state;
            counter <= 0;
        end
    end
    
    
    //output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALL_L) || (state == FALL_R);
    assign digging    = (state == LEFTDIG) || (state == RIGHTDIG);

endmodule


