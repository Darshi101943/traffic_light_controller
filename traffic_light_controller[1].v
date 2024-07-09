`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:02 06/26/2023 
// Design Name: 
// Module Name:    traffic_light_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module traffic_light_controller(
    input clk,       // Clock signal
    input reset,     // Reset signal
    output reg red,  // Red light output
    output reg yellow,  // Yellow light output
    output reg green  // Green light output
);

// Traffic light states
parameter STOP = 2'b00;
parameter GET_READY = 2'b01;
parameter GO = 2'b10;
parameter SLOW_DOWN = 2'b11;

// Internal signals
reg [1:0] next_state,state;  // Current state
reg [3:0] count;  // Counter for state transitions

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= STOP;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        STOP:
            if (count < 4) begin
                count <= count + 1;
                next_state <= STOP;
            end
            else begin
                count <= 0;
                next_state <= GET_READY;
            end
        
        GET_READY:
            if (count < 2) begin
                count <= count + 1;
                next_state <= GET_READY;
            end
            else begin
                count <= 0;
                next_state <= GO;
            end
        
        GO:
            if (count < 6) begin
                count <= count + 1;
                next_state <= GO;
            end
            else begin
                count <= 0;
                next_state <= SLOW_DOWN;
            end
        
        SLOW_DOWN:
            if (count < 2) begin
                count <= count + 1;
                next_state <= SLOW_DOWN;
            end
            else begin
                count <= 0;
                next_state <= STOP;
            end
        
        default:
            next_state <= STOP;
    endcase
end

// Output control logic
always @(state) begin
    case (state)
        STOP:
            begin
                red = 1;
                yellow = 0;
                green = 0;
            end
        
        GET_READY:
            begin
                red = 1;
                yellow = 1;
                green = 0;
            end
        
        GO:
            begin
                red = 0;
                yellow = 0;
                green = 1;
            end
        
        SLOW_DOWN:
            begin
                red = 0;
                yellow = 1;
                green = 0;
            end
        
        default:
            begin
                red = 0;
                yellow = 0;
                green = 0;
            end
    endcase
end

endmodule