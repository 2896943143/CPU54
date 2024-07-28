`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 20:55:10
// Design Name: 
// Module Name: regfile
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


module regfile(
input clk,
input reset,
input wea,
input [4:0]inorder,
input [4:0]outorder1,
input [4:0]outorder2,
input [31:0]indata,
output [31:0]outdata1,
output [31:0]outdata2
);
reg [31:0]array_reg[31:0];
integer i;
assign outdata1=array_reg[outorder1];
assign outdata2=array_reg[outorder2];
always@(posedge clk,posedge reset)
begin
if(reset)
begin
for(i=0;i<32;i=i+1)
begin
array_reg[i]=0;
end
end
else
begin
for(i=0;i<32;i=i+1)
begin
if(wea&&inorder==i&&i)
begin
array_reg[i]=indata;
end
end
end
end
endmodule
