`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 11:32:06
// Design Name: 
// Module Name: Dmemory
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


module Dmemory(
input clk,
input rst,
input wea,
input start,
input [31:0]addr,
input [31:0]in_data,
input [2:0]rol,
output busy,
output [31:0]out_data
);
wire [7:0] mem_indata,mem_outdata;
wire [12:0] mem_addr;
wire dr_in_busy,dr_out_busy,ar_busy;
assign busy=dr_in_busy|dr_out_busy|ar_busy;
DR_IN DR_IN(
.clk(clk),
.rst(rst),
.start(start),
.num(rol),
.in_data(mem_outdata),
.busy(dr_in_busy),
.out_data(out_data)
);

DR_OUT DR_OUT(
.clk(clk),
.rst(rst),
.start(start),
.num(rol),
.in_data(in_data),
.busy(dr_out_busy),
.out_data(mem_indata)
);

AR AR(
.clk(clk),
.rst(rst),
.start(start),
.num(rol),
.in_addr(addr),
.busy(ar_busy),
.out_addr(mem_addr)
);

dmem dmem(
.clk(~clk),
.we(wea),
.a(mem_addr[10:0]),
.d(mem_indata),
.spo(mem_outdata)
);
endmodule
