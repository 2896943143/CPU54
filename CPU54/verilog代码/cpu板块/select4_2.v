`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/11 20:29:17
// Design Name: 
// Module Name: select4_2
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


module select4_2(
input [31:0] in_data1,
input [31:0] in_data2,
input [31:0] in_data3,
input [31:0] in_data4,
input [1:0]  order,
output [31:0] out_data
);

assign out_data=order==0?in_data1:order==1?in_data2:order==2?in_data3:in_data4;

endmodule
