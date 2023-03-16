//Kang HB
`timescale 1ns / 1ps
module state_machine
(
input clk,
input reset_n,
input [2:0]switch_in,
input mode,
output reg [1:0] current_state,
output reg [15:0] timeout,
output reg [1:0] cnt
);

reg [2:0]switch_buffer1;
reg [2:0]switch_true;
localparam up_wait = 2'b00;
localparam up_run = 2'b01;
localparam down_wait = 2'b10;
localparam down_run = 2'b11;

reg [1:0] next_state;
//switch edge detection
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

always@(posedge clk or negedge reset_n) 
begin
	if (!reset_n) begin
		current_state <= up_wait;
	end
	else begin
		current_state <= next_state;
	end
end

always@(*)
begin
	case(current_state)
	up_wait : if(mode==0)begin
	       next_state = down_wait;
	   end
	   else if(switch_true==3'd01) begin
			next_state = up_run;
	   end
	   else begin
			next_state = up_wait;
	   end
	
	up_run : if(mode==0)begin
	       next_state = down_wait;
	   end 
	   else if(switch_true==3'd01||switch_true==3'd02) begin
			next_state = up_wait;
	   end
	   else begin
			next_state = up_run;
	   end
	down_wait : if(mode==1) begin
	       next_state=up_wait;
	   end
	   else if (switch_true==3'd01) begin
			next_state = down_run;
	   end
	   else begin
			next_state = down_wait;
	   end
	down_run :if(mode==1)begin
	       next_state = up_wait;
	   end 
	   else if(switch_true==3'd01||switch_true==3'd02) begin
			next_state = down_wait;
	   end
	   else begin
			next_state = down_run;
	   end
	endcase
end

//cnt for digit pos control

always@(posedge clk or negedge reset_n)
begin
    if(!reset_n)begin
        cnt<=0;
    end
	else if (current_state==up_run||current_state==down_run)begin
		cnt<=0;
	end
	else if(switch_true==3'd2) begin
	   cnt<=0;
	end
	else if (switch_true==3'd3)begin
	    if(cnt==3'd3)begin
	       cnt<=0;
	    end
	    else begin
		cnt<=cnt+1;
		end
	end
	else begin
		cnt <= cnt;
	end
end

always@(posedge clk)
begin
	if(current_state==down_wait)begin
	        if(switch_true==4'd2)begin
	           timeout[15:0] <= 16'b0000_0000_0000_0000;
	        end
		
			else if(switch_true==4'd4)begin
			    if (cnt==0)begin
			         if(timeout[15:12]==9)begin
			             timeout[15:12]<=0;
			         end
			         else begin
			         timeout[15:12]<=timeout[15:12]+1;
			         end
			    end
			    else if (cnt==1)begin
			         if(timeout[11:8]==9)begin
			             timeout[11:8]<=0;
			         end
			         else begin
			         timeout[11:8]<=timeout[11:8]+1;
			         end
			    end
			    else if (cnt==2)begin
			         if(timeout[7:4]==9)begin
			             timeout[7:4]<=0;
			         end
			         else begin
			         timeout[7:4]<=timeout[7:4]+1;
			         end
			    end
			    else begin
			         if(timeout[3:0]==9)begin
			             timeout[3:0]<=0;
			         end
			         else begin
			         timeout[3:0]<=timeout[3:0]+1;
			         end
			    end
			end
			else begin
				if (cnt==0)begin
			         timeout[15:12]<= timeout[15:12];
			    end
			    else if (cnt==1)begin
			         timeout[11:8]<= timeout[11:8];
			    end
			    else if (cnt==2)begin
			         timeout[7:4]<= timeout[7:4];
			    end
			    else begin
			         timeout[3:0]<= timeout[3:0];
			    end
			end
		
	end
	else if (current_state==down_run)begin
	   if(switch_true==4'd2) begin
	       timeout[15:0] <= 16'b0000_0000_0000_0000;
	   end
	   else begin
	       timeout[15:0] <= timeout[15:0];
	   end
	end
	else begin
	timeout[15:0] <= 16'b0000_0000_0000_0000;//set to invalid number
	end
end

endmodule
