`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module led(
input rst_n,
input clk,
input [1:0] current_state,
output reg led0,
output reg led1,
output reg led2,
output reg led3
);
localparam up_wait = 2'b00;
localparam up_run = 2'b01;
localparam down_wait = 2'b10;
localparam down_run = 2'b11;

always@(posedge clk )begin
    if(!rst_n)begin
        led0<=1'b0;
        led1<=1'b0;
        led2<=1'b0;
        led3<=1'b0;
    end
    else if(current_state==up_wait)begin
        led0<=1'b1;
        led1<=1'b1;
        led2<=1'b0;
        led3<=1'b0;
    end 
    else if(current_state==up_run) begin
        led0<=1'b1;
        led1<=1'b0;
        led2<=1'b0;
        led3<=1'b0;
    end
    else if(current_state==down_wait) begin
        led0<=1'b0;
        led1<=1'b0;
        led2<=1'b1;
        led3<=1'b1;
    end
    else if(current_state==down_run) begin
        led0<=1'b0;
        led1<=1'b0;
        led2<=1'b0;
        led3<=1'b1;
    end
end

 
endmodule
