`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/10 16:30:39
// Design Name: 
// Module Name: select2_1
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


module select2_1(
input [31:0]in_data1,
input [31:0]in_data2,
input order,
output [31:0]out_data
);
assign out_data=order?in_data2:in_data1;
endmodule
