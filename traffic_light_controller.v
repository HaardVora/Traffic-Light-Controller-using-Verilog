`timescale 1ns / 1ps

module traffic_light_controller(
input clk,
input reset,
input enable,
output reg r,       // used to on - off the lights
output reg y,
output reg g,
output [3:0] state_out
    );

// parameter declaration using one - hot encoding because it is easy to understand and implement in FSMs. And it is synthesizable
// at higher clock frequencies and uses one bit comparators in combinational logic

parameter [4:0] off = 5'b00001,
                red = 5'b00010,
                yellow = 5'b00100,
                green = 5'b01000,
                yellow_2 = 5'b10000;

// state declaration
reg [4:0] current_state;
reg [4:0] next_state;

reg [5:0] timer ;        // we use 6 bit timer because we want to count till 50 clock cycles
reg  timer_clear;        // necessary because we sit in each state for different clock cycles

always@(*)
    begin
        next_state = off;
        r = 0;
        g = 0;
        y = 0;
        timer_clear = 0;
        case(current_state)
                
                off : begin
                        if (enable) next_state = red;
                      end
                
                red : begin
                        r = 1;
                        if ( timer == 6'd50 ) 
                            begin
                                timer_clear = 1;
                                next_state = yellow;
                            end
                        else 
                            begin
                                next_state = red;
                            end
                      end
                
                yellow : begin
                            y = 1;
                            if ( timer == 6'd10 )
                                begin
                                    next_state = green;
                                    timer_clear = 1;
                                end
                            else 
                                begin
                                    next_state = yellow;
                                end
                         end
                        
                green : begin
                            g = 1;
                            if ( timer == 6'd30)
                                begin
                                    next_state = yellow_2;
                                    timer_clear = 1;
                                end 
                            else begin
                                    next_state = green;
                                 end               
                        end
                
                yellow_2 : begin
                            y = 1;
                            if ( timer == 6'd10 )
                                begin
                                    next_state = red;
                                    timer_clear = 1;
                                end
                            else 
                                begin
                                    next_state = yellow_2;
                                end      
                           end 
                default : next_state = off;       
         endcase
    end

// just for error checking or debugging
assign state_out = current_state;

// sequential logic
always@(posedge clk)
    begin
        if (reset)
            begin
                current_state <= off;
            end
        else if (!enable)
        begin
            current_state <= off;
        end
        else
        begin   
            current_state <= next_state;
        end
       
    end
    
// timer logic 
always@(posedge clk or posedge reset)
    begin
        if (reset )
            begin
                timer <= 6'b0;
            end
        else if ((timer_clear == 1) || (enable == 0))
        begin
                timer <= 6'b0;
        end
        else 
        begin
            timer <= timer + 1'b1;
        end
    end
 
endmodule
