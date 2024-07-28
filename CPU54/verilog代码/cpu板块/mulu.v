`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 21:15:22
// Design Name: 
// Module Name: mulu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MULTU(
input clk, //乘法器时钟信号
input reset, //复位信号，高电平有效
input start,
input [31:0] a, //输入数 a(被乘数)
input [31:0] b, //输入数 b（乘数）
output reg busy,
output [31:0]h,    
output [31:0]l   
);
reg [33:0]x;
reg [31:0]y;
reg [65:0]f;
reg [4:0]count;
assign h=x[31:0];
assign l=y;
always@(posedge clk or posedge reset) 
    if (reset == 1) 
    begin 
       count = 0;
       busy = 0;
    end
   else
   begin
       if(start)
       begin
           x=0;
           y=b;
           busy=1;
           count=0;
           f=0;
       end
       else
       begin
        if(busy)
            begin
                if(y[0]==1)
                begin
                x=x+{2'b00,a};
                end
                f={x,y};
                {x,y}=f>>1;
                if(count==5'b11111)
                begin
                    busy=0;
                end
                count=count+1;
            end
        end
   end
endmodule
