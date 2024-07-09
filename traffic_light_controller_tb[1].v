`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:25:05 06/26/2023
// Design Name:   traffic_light_controller
// Module Name:   /home/kusuma/Desktop/Opt/14.7/ISE_DS/taffic_light_gpt/traffic_light_controller_tb.v
// Project Name:  taffic_light_gpt
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic_light_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module traffic_light_controller_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire red;
    wire yellow;
    wire green;

    // Instantiate the traffic light controller module
    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        clk = 0;
        reset = 0;

        #10 reset = 1;   // Apply reset

        #20 reset = 0;   // Release reset

        // Wait for a complete cycle
        #100;

        // Terminate the simulation
        $finish;
    end

endmodule


