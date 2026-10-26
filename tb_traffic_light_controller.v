`timescale 1ns / 1ps

module tb_traffic_light_controller();

reg clk = 0;
reg reset;
reg enable;

wire r;
wire y;
wire g;
wire [4:0] state_out;

// Instantiating the DUT
traffic_light_controller DUT (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .r(r),
    .y(y),
    .g(g),
    .state_out(state_out)
);


// Clock generation
always #1 clk = ~clk;


// Stimulus
initial begin

    $monitor($time,
             " reset=%b enable=%b r=%b y=%b g=%b state=%b",
             reset, enable, r, y, g, state_out);


    // Reset
    reset = 1;
    enable = 0;

    #2;

    // Release reset
    reset = 0;

    #2;

    // Start traffic controller
    enable = 1;

    // RED ≈ 50 clocks = 100 ns
    #105;

    // YELLOW1 ≈ 10 clocks = 20 ns
    #25;

    // GREEN ≈ 30 clocks = 60 ns
    #65;

    // YELLOW2 ≈ 10 clocks = 20 ns
    #25;

    // Now it should return to RED
    #105;

    // Disable controller
    enable = 0;

    #10;

    // Enable again
    enable = 1;

    #250;

    $stop;

end

endmodule