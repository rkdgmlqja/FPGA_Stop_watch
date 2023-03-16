//Kang HB
`timescale 1ns / 1ps
module counter
(
input clk,
input reset_n,
input [2:0]switch_in,
input [1:0]current_state,
input [15:0] timeout,
output reg [3:0]min_cnt2,
output reg [3:0]min_cnt1,
output reg [2:0]sec_cnt2,
output reg [3:0]sec_cnt1
);


reg [1:0] csbuffer;
reg [1:0] cstrue;
reg [15:0]timebuffer;
reg[9:0] cntk1;
reg[9:0] cntk2;
reg[6:0] cnt125;
reg[9:0] cntk1a;
reg[9:0] cntk2a;
reg[6:0] cnt125a;
reg[3:0]min_cnt2a;
reg[3:0]min_cnt1a;
reg[2:0]sec_cnt2a;
reg[3:0]sec_cnt1a;

reg [2:0]switch_buffer1;
reg [2:0]switch_true;

localparam up_wait = 2'b00;
localparam up_run = 2'b01;
localparam down_wait = 2'b10;
localparam down_run = 2'b11;
reg [1:0] cntd;

always@(posedge clk or negedge reset_n)
begin
    if(!reset_n)begin
        cntd<=0;
    end
	else if (current_state==up_run||current_state==down_run)begin
		cntd<=0;
	end
	else if(switch_true==3'd2) begin
	   cntd<=0;
	end
	else if (switch_true==3'd3)begin
	    if(cntd==3'd3)begin
	       cntd<=0;
	    end
	    else begin
		cntd<=cntd+1;
		end
	end
	else begin
		cntd <= cntd;
	end
end









always@(posedge clk) begin
    switch_buffer1<= switch_in;
end
always@(posedge clk) begin
    if(switch_in==switch_buffer1)begin
        switch_true<=0;
    end
    else begin
        switch_true<=switch_in;
    end
end

always @ (posedge clk) begin
        csbuffer<=current_state;
        timebuffer<= timeout;
        cntk1a<=cntk1;
        cntk2a<=cntk2;
        cnt125a<=cnt125;
        min_cnt2a<=min_cnt2;
        min_cnt1a<=min_cnt1;
        sec_cnt2a<=sec_cnt2;
        sec_cnt1a<=sec_cnt1;
        
        
end
//cntk1
always@(posedge clk or negedge reset_n) begin
	if(!reset_n )begin
	   cntk1<=0;
    end
    
    else begin
        if (cntk1==10'd999) begin
            cntk1 <= 0;
        end
        else begin
            cntk1 <= cntk1+1;
        end
    end
end

//cntk2
always@(posedge clk or negedge reset_n) begin
	if(!reset_n )begin
	   cntk2<=0;
    end
    
    else begin
        if(cntk1==0&&cntk1a==999)begin
            if (cntk2==10'd999) begin
                cntk2 <= 0;
            end
            else begin
                cntk2 <= cntk2+1;
            end
        end
    end
end

//cnt125
always@(posedge clk or negedge reset_n) begin
	if(!reset_n )begin
	   cnt125<=0;
    end
    
    else begin
        if(cntk2==0&&cntk2a==999)begin
            if (cnt125==10'd124) begin
                cnt125 <= 0;
            end
            else begin
                cnt125 <= cnt125+1;
            end
        end
    end
end



always@(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        min_cnt2<=0;
        min_cnt1<=0;
        sec_cnt1<=0;
        sec_cnt2<=0;
    end
    else if((current_state==down_wait&&csbuffer==up_run)||(current_state==down_wait&&csbuffer==up_wait)) begin
        min_cnt2<=0;
        min_cnt1<=0;
        sec_cnt1<=0;
        sec_cnt2<=0;
    end
    
    else if((current_state==up_wait&&csbuffer==down_run)||(current_state==up_wait&&csbuffer==down_wait)) begin
        min_cnt2<=0;
        min_cnt1<=0;
        sec_cnt1<=0;
        sec_cnt2<=0;
    end
    else if (current_state==up_run) begin
        if(switch_in==2) begin
            min_cnt2<=0;
            min_cnt1<=0;
            sec_cnt1<=0;
            sec_cnt2<=0;
        end
        else if(cnt125==0&&cnt125a==124) begin
            if(sec_cnt1==9)begin
                sec_cnt1<=0;
            end
            else begin
                sec_cnt1<=sec_cnt1+1;
            end
        end
        else begin
            sec_cnt1<=sec_cnt1;
        end
        
        if(sec_cnt1a==9&&sec_cnt1==0) begin
            if(sec_cnt2==5) begin
                sec_cnt2<=0;
            end
            else begin
                sec_cnt2<= sec_cnt2+1;
            end
        end
        
        else begin
            sec_cnt2<=sec_cnt2;
        end
        
        if(sec_cnt2a==5&&sec_cnt2==0) begin
            if(min_cnt1==9) begin
                min_cnt1<=0;
            end
            else begin
                min_cnt1<= min_cnt1+1;
            end
        end
        
        else begin
            min_cnt1<=min_cnt1;
        end
        
        if(min_cnt1a==9&&min_cnt1==0) begin
            if(min_cnt2==9) begin
                min_cnt2<=0;
            end
            else begin
                min_cnt2<= min_cnt2+1;
            end
        end
        
        else begin
            min_cnt2<=min_cnt2;
        end
    end
    else if (current_state==up_wait) begin
        if(switch_in==2) begin
            min_cnt2<=0;
            min_cnt1<=0;
            sec_cnt1<=0;
            sec_cnt2<=0;
        end
        else begin
            min_cnt2<=min_cnt2;
            min_cnt1<=min_cnt1;
            sec_cnt1<=sec_cnt1;
            sec_cnt2<=sec_cnt2;
        end
    end
    else if (current_state==down_run) begin
        if(switch_in==2) begin
            min_cnt2<=4;
            min_cnt1<=4;
            sec_cnt1<=4;
            sec_cnt2<=4;
        end
        else if(cnt125==0&&cnt125a==124) begin
            if(sec_cnt1==0)begin
                sec_cnt1<=9;
            end
            else begin
                sec_cnt1<=sec_cnt1-1;
            end
        end
        else begin
            sec_cnt1<=sec_cnt1;
        end
        
        if(sec_cnt1a==0&&sec_cnt1==9) begin
            if(sec_cnt2==0) begin
                sec_cnt2<=5;
            end
            else begin
                sec_cnt2<= sec_cnt2-1;
            end
        end
        
        else begin
            sec_cnt2<=sec_cnt2;
        end
        
        if(sec_cnt2a==0&&sec_cnt2==5) begin
            if(min_cnt1==0) begin
                min_cnt1<=9;
            end
            else begin
                min_cnt1<= min_cnt1-1;
            end
        end
        
        else begin
            min_cnt1<=min_cnt1;
        end
        
        if(min_cnt1a==0&&min_cnt1==9) begin
            if(min_cnt2==0) begin
                min_cnt2<=9;
            end
            else begin
                min_cnt2<= min_cnt2-1;
            end
        end
        
        else begin
            min_cnt2<=min_cnt2;
        end
    end
    else if (current_state==down_wait)begin
             if(switch_true==3'd2)begin
	             min_cnt2<=0;
                 min_cnt1<=0;
                 sec_cnt1<=0;
                 sec_cnt2<=0;
	             end
		
	         else if(switch_true==3'd4)begin
			     if (cntd==0)begin
			         if(sec_cnt1==9)begin
			             sec_cnt1<=0;
			         end
			         else begin
			         sec_cnt1<=sec_cnt1+1;
			         end
			    end
			    else if (cntd==1)begin
			         if(sec_cnt2==5)begin
			             sec_cnt2<=0;
			         end
			         else begin
			         sec_cnt2<=sec_cnt2+1;
			         end
			    end
			    else if (cntd==2)begin
			         if(min_cnt1==9)begin
			             min_cnt1<=0;
			         end
			         else begin
			         min_cnt1<=min_cnt1+1;
			         end
			    end
			    else begin
			         if(min_cnt2==9)begin
			             min_cnt2<=0;
			         end
			         else begin
			         min_cnt2<=min_cnt2+1;
			         end
			    end
			end 
			else begin
				if (cntd==0)begin
			         sec_cnt1<= sec_cnt1;
			    end
			    else if (cntd==1)begin
			         sec_cnt2<= sec_cnt2;
			    end
			    else if (cntd==2)begin
			         min_cnt1<= min_cnt1;
			    end
			    else begin
			         min_cnt2<= min_cnt2;
			    end
			end
    end
    else begin
    end
end

endmodule
