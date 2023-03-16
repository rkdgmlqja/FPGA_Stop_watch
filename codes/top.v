`timescale 1ns / 1ps
//Kang

module top(
input wire clkt,
input wire rstt,
input wire mode,
input wire strtps,
input wire stp,
input wire chngdigit,
input wire numbup,
output wire led0t, led1t, led2t, led3t,
output wire select_seg1, select_seg2,
output wire [6:0] segAout, segBout
    );

wire [2:0] switch_out;
wire rst_n;
wire modeout;
wire [1:0]current_state;
wire [15:0] timeout;
wire[3:0]min_cnt2;
wire[3:0]min_cnt1;
wire[2:0]sec_cnt2;
wire[3:0]sec_cnt1;
wire[1:0]cnt2;
reg select_seg;
wire [6:0]   seg0t, seg1t, seg2t, seg3t;
wire [1:0] statenum;

switch_interface si(
    .clk(clkt),
    .rst(rstt),
    .mode(mode),
    .strtps(strtps),
    .stp(stp),
    .chngdigit(chngdigit),
    .numbup(numbup),
    .switch_out(switch_out),
    .rst_n(rst_n),
    .modeout(modeout)
);

state_machine sm(
    .clk(clkt),
    .reset_n(rst_n),
    .switch_in(switch_out),
    .mode(modeout),
    .current_state(current_state),
    .timeout(timeout),
    .cnt(cnt2)
);

counter cnter(
    .reset_n(rst_n),
    .clk(clkt),
    .switch_in(switch_out),
    .current_state(current_state),
    .timeout(timeout),
    .min_cnt2(min_cnt2),
    .min_cnt1(min_cnt1),
    .sec_cnt1(sec_cnt1),
    .sec_cnt2(sec_cnt2)
);

led led(
    .rst_n(rst_n),
    .clk(clkt),
    .current_state(current_state),
    .led0(led0t),
    .led1(led1t),
    .led2(led2t),
    .led3(led3t)
);

sseg sg(
    .clk(clkt),
    .reset_n(rst_n),
    .min_cnt1(min_cnt1),
    .min_cnt2(min_cnt2),
    .sec_cnt1(sec_cnt1),
    .sec_cnt2(sec_cnt2),
    .seg0(seg0t),
    .seg1(seg1t),
    .seg2(seg2t),
    .seg3(seg3t),
    .current_state(current_state),
    .switch_in(switch_out)
);
reg [12:0] cnt;
always@(posedge clkt or negedge rst_n)begin
    if (!rst_n)begin
        cnt<=0;
        select_seg<=0;
    end
    else if(cnt==13'd1) begin
        select_seg<=~select_seg;
        cnt<= cnt+1;
    end
    
    else if (cnt==13'b1111_1111_1111_1)begin
        cnt<=0;
    end
    else begin
        cnt<= cnt+1;
    end        
    
end

//assgin section
assign select_seg1 = select_seg;
assign select_seg2 = select_seg;
assign segAout = (!select_seg) ? seg0t:seg1t;
assign segBout = (!select_seg) ? seg2t:seg3t;


endmodule
