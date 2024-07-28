`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 21:22:53
// Design Name: 
// Module Name: MULT
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


module MULT(
input clk, //乘法器时钟信号
input reset, //复位信号，高电平有效
input start,
input signed [31:0] a, //输入数 a(被乘数)
input signed [31:0] b, //输入数 b（乘数）
output reg busy,
output [31:0]h,    
output [31:0]l   
);
reg [4:0]count;
reg signed [32:0]c;
reg signed [32:0]d;
reg signed [65:0]f;
assign h=c[31:0];
assign l=d[32:1];
always@(posedge clk,posedge reset)
begin
    if (reset == 1) 
    begin 
       count = 0;
       busy = 0;
    end
   else
   begin
       if(start)
       begin
           c=0;
           d={b,1'b0};
           busy=1;
           count=0;
       end
       else
       begin
        if(busy)
            begin
                if(d[0]==1'b0&&d[1]==1'b1)
                begin
                c=c-a;
                end
                if(d[0]==1'b1&&d[1]==1'b0)
                begin
                c=c+a;
                end
                f={c,d};
                {c,d}=f>>>1;
                if(count==5'b11111)
                begin
                    busy=0;
                end
                count=count+1;
            end
        end
   end
end
endmodule
