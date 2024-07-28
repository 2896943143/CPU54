`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 15:50:49
// Design Name: 
// Module Name: LO
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


module LO(
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
        memory1=32'h0000000;
    end
    else
    begin
        if(wea)
        begin
            memory1=indata;
        end
    end
end
endmodule