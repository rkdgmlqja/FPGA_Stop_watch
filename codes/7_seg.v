//Kang HB
`timescale 1ns / 1ps

module sseg(

input clk,
input reset_n,
input [1:0] current_state,
input[3:0]min_cnt2,
input[3:0]min_cnt1,
input[2:0]sec_cnt2,
input[3:0]sec_cnt1,
input [2:0]switch_in,
output reg [6:0]   seg0,
output reg [6:0]   seg1,
output reg [6:0]   seg2,
output reg [6:0]   seg3

);

localparam up_wait = 2'b00;
localparam up_run = 2'b01;
localparam down_wait = 2'b10;
localparam down_run = 2'b11;

localparam d0 = 4'd0;
localparam d1 = 4'd1;
localparam d2 = 4'd2;
localparam d3 = 4'd3;    
localparam d4 = 4'd4;
localparam d5 = 4'd5;
localparam d6 = 4'd6;
localparam d7 = 4'd7;
localparam d8 = 4'd8;
localparam d9 = 4'd9;

localparam n0 = 7'b011_1111;
localparam n1 = 7'b000_0110;
localparam n2 = 7'b101_1011;
localparam n3 = 7'b100_1111;    
localparam n4 = 7'b110_0110;
localparam n5 = 7'b110_1101;
localparam n6 = 7'b111_1100;
localparam n7 = 7'b010_0111;
localparam n8 = 7'b111_1111;
localparam n9 = 7'b110_1111;
localparam nl = 7'b000_0000;
localparam no = 7'b100_0000;
reg lap_on;
//reg seg0w, seg1w, seg2w, seg3w;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        lap_on<=0;
    end
    else if(current_state==up_run||current_state==up_wait) begin
        if(switch_in==3)begin
            lap_on<=~lap_on;
        end
        else begin
            lap_on<=lap_on;
        end
    end
    else begin
        lap_on<=0;
    end
end


always @ (posedge clk or negedge reset_n)begin
    if(!reset_n)begin
        seg0<=no;
        seg1<=no;
        seg2<=no;
        seg3<=no;
    end
    else if(current_state==up_run)begin
        if(lap_on)begin
            if(switch_in==4)begin
                if (sec_cnt1==0)
                    seg0<=n0;
                else if(sec_cnt1==1)
                    seg0<=n1;
                else if(sec_cnt1==2)
                    seg0<=n2;
                else if(sec_cnt1==3)
                    seg0<=n3;
                else if(sec_cnt1==4)
                    seg0<=n4;
                else if(sec_cnt1==5)
                    seg0<=n5;
                else if(sec_cnt1==6)
                    seg0<=n6;
                else if(sec_cnt1==7)
                    seg0<=n7;
                else if(sec_cnt1==8)
                    seg0<=n8;
                else if(sec_cnt1==9)
                    seg0<=n9;
                else
                    seg0<=nl;
                ///
                if (sec_cnt2==0)
                    seg1<=n0;
                else if(sec_cnt2==1)
                    seg1<=n1;
                else if(sec_cnt2==2)
                    seg1<=n2;
                else if(sec_cnt2==3)
                    seg1<=n3;
                else if(sec_cnt2==4)
                    seg1<=n4;
                else if(sec_cnt2==5)
                    seg1<=n5;
                else if(sec_cnt2==6)
                    seg1<=n6;
                else if(sec_cnt2==7)
                    seg1<=n7;
                else if(sec_cnt2==8)
                    seg1<=n8;
                else if(sec_cnt2==9)
                    seg1<=n9;
                else
                    seg1<=nl;      
///
                if (min_cnt1==0)
                    seg2<=n0;
                else if(min_cnt1==1)
                    seg2<=n1;
                else if(min_cnt1==2)
                    seg2<=n2;
                else if(min_cnt1==3)
                    seg2<=n3;
                else if(min_cnt1==4)
                    seg2<=n4;
                else if(min_cnt1==5)
                    seg2<=n5;
                else if(min_cnt1==6)
                    seg2<=n6;
                else if(min_cnt1==7)
                    seg2<=n7;
                else if(min_cnt1==8)
                    seg2<=n8;
                else if(min_cnt1==9)
                    seg2<=n9;
                else
                    seg2<=nl;   
///
                if (min_cnt2==d0)
                    seg3<=n0;
                else if(min_cnt2==1)
                    seg3<=n1;
                else if(min_cnt2==2)
                    seg3<=n2;
                else if(min_cnt2==3)
                    seg3<=n3;
                else if(min_cnt2==4)
                    seg3<=n4;
                else if(min_cnt2==5)
                    seg3<=n5;
                else if(min_cnt2==6)
                    seg3<=n6;
                else if(min_cnt2==7)
                    seg3<=n7;
                else if(min_cnt2==8)
                    seg3<=n8;
                else if(min_cnt2==9)
                    seg3<=n9;
                else
                    seg3<=nl;     
            end
            else begin
                seg0<=seg0;
                seg1<=seg1;
                seg2<=seg2;
                seg3<=seg3;
            end
        end
        else begin
            if (sec_cnt1==0)
            seg0<=n0;
        else if(sec_cnt1==1)
            seg0<=n1;
        else if(sec_cnt1==2)
            seg0<=n2;
        else if(sec_cnt1==3)
            seg0<=n3;
        else if(sec_cnt1==4)
            seg0<=n4;
        else if(sec_cnt1==5)
            seg0<=n5;
        else if(sec_cnt1==6)
            seg0<=n6;
        else if(sec_cnt1==7)
            seg0<=n7;
        else if(sec_cnt1==8)
            seg0<=n8;
        else if(sec_cnt1==9)
            seg0<=n9;
        else
            seg0<=nl;
        ///
        if (sec_cnt2==0)
            seg1<=n0;
        else if(sec_cnt2==1)
            seg1<=n1;
        else if(sec_cnt2==2)
            seg1<=n2;
        else if(sec_cnt2==3)
            seg1<=n3;
        else if(sec_cnt2==4)
            seg1<=n4;
        else if(sec_cnt2==5)
            seg1<=n5;
        else if(sec_cnt2==6)
            seg1<=n6;
        else if(sec_cnt2==7)
            seg1<=n7;
        else if(sec_cnt2==8)
            seg1<=n8;
        else if(sec_cnt2==9)
            seg1<=n9;
        else
            seg1<=nl;      
///
        if (min_cnt1==0)
            seg2<=n0;
        else if(min_cnt1==1)
            seg2<=n1;
        else if(min_cnt1==2)
            seg2<=n2;
        else if(min_cnt1==3)
            seg2<=n3;
        else if(min_cnt1==4)
            seg2<=n4;
        else if(min_cnt1==5)
            seg2<=n5;
        else if(min_cnt1==6)
            seg2<=n6;
        else if(min_cnt1==7)
            seg2<=n7;
        else if(min_cnt1==8)
            seg2<=n8;
        else if(min_cnt1==9)
            seg2<=n9;
        else
            seg2<=nl;   
///
        if (min_cnt2==d0)
            seg3<=n0;
        else if(min_cnt2==1)
            seg3<=n1;
        else if(min_cnt2==2)
            seg3<=n2;
        else if(min_cnt2==3)
            seg3<=n3;
        else if(min_cnt2==4)
            seg3<=n4;
        else if(min_cnt2==5)
            seg3<=n5;
        else if(min_cnt2==6)
            seg3<=n6;
        else if(min_cnt2==7)
            seg3<=n7;
        else if(min_cnt2==8)
            seg3<=n8;
        else if(min_cnt2==9)
            seg3<=n9;
        else
            seg3<=nl;
        end
    end
    else begin
        if (sec_cnt1==0)
            seg0<=n0;
        else if(sec_cnt1==1)
            seg0<=n1;
        else if(sec_cnt1==2)
            seg0<=n2;
        else if(sec_cnt1==3)
            seg0<=n3;
        else if(sec_cnt1==4)
            seg0<=n4;
        else if(sec_cnt1==5)
            seg0<=n5;
        else if(sec_cnt1==6)
            seg0<=n6;
        else if(sec_cnt1==7)
            seg0<=n7;
        else if(sec_cnt1==8)
            seg0<=n8;
        else if(sec_cnt1==9)
            seg0<=n9;
        else
            seg0<=nl;
        ///
        if (sec_cnt2==0)
            seg1<=n0;
        else if(sec_cnt2==1)
            seg1<=n1;
        else if(sec_cnt2==2)
            seg1<=n2;
        else if(sec_cnt2==3)
            seg1<=n3;
        else if(sec_cnt2==4)
            seg1<=n4;
        else if(sec_cnt2==5)
            seg1<=n5;
        else if(sec_cnt2==6)
            seg1<=n6;
        else if(sec_cnt2==7)
            seg1<=n7;
        else if(sec_cnt2==8)
            seg1<=n8;
        else if(sec_cnt2==9)
            seg1<=n9;
        else
            seg1<=nl;      
///
        if (min_cnt1==0)
            seg2<=n0;
        else if(min_cnt1==1)
            seg2<=n1;
        else if(min_cnt1==2)
            seg2<=n2;
        else if(min_cnt1==3)
            seg2<=n3;
        else if(min_cnt1==4)
            seg2<=n4;
        else if(min_cnt1==5)
            seg2<=n5;
        else if(min_cnt1==6)
            seg2<=n6;
        else if(min_cnt1==7)
            seg2<=n7;
        else if(min_cnt1==8)
            seg2<=n8;
        else if(min_cnt1==9)
            seg2<=n9;
        else
            seg2<=nl;   
///
        if (min_cnt2==d0)
            seg3<=n0;
        else if(min_cnt2==1)
            seg3<=n1;
        else if(min_cnt2==2)
            seg3<=n2;
        else if(min_cnt2==3)
            seg3<=n3;
        else if(min_cnt2==4)
            seg3<=n4;
        else if(min_cnt2==5)
            seg3<=n5;
        else if(min_cnt2==6)
            seg3<=n6;
        else if(min_cnt2==7)
            seg3<=n7;
        else if(min_cnt2==8)
            seg3<=n8;
        else if(min_cnt2==9)
            seg3<=n9;
        else
            seg3<=nl;                                                           
    end
end


endmodule
