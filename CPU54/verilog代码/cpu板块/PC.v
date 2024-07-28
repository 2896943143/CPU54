`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 20:43:24
// Design Name: 
// Module Name: PC
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


module PC(
input clk,
input rst,
input wea,
input [31:0]indata,
output [31:0]outdata
);
reg [31:0]memory1;
assign outdata=memory1;
always @(posedge clk or posedge rst) 
begin
    if(rst)
    begin
        memory1=32'h00400000;
    end
    else
    begin
        if(wea)
        begin
            memory1=indata;
            memory1[22]=1;
        end
    end
end
endmodule