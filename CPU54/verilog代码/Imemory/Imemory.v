`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/13 11:26:01
// Design Name: 
// Module Name: Imemory
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


module Imemory(
input clk,
input rst,
input enb,
input [31:0]pc_out,
output [31:0]imem_out
);
reg [31:0]mem;
wire [31:0]spo;
assign imem_out=mem;
imem imem(
.a(pc_out[12:2]),
.spo(spo)
);
always @(posedge clk,posedge rst) 
begin
    if(rst)
    begin
        mem=0;
    end
    else
    begin
        if(enb)
        begin
            mem=spo;
        end
    end    
end
endmodule
