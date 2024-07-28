`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 21:34:02
// Design Name: 
// Module Name: select8_3
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


module select8_3(
input [31:0] in_data1,
input [31:0] in_data2,
input [31:0] in_data3,
input [31:0] in_data4,
input [31:0] in_data5,
input [31:0] in_data6,
input [31:0] in_data7,
input [31:0] in_data8,
input [2:0]  order,
output [31:0] out_data
);
assign out_data=order==0?in_data1:order==1?in_data2:order==2?in_data3:order==3?in_data4:order==4?in_data5:order==5?in_data6:order==6?in_data7:in_data8;
endmodule
