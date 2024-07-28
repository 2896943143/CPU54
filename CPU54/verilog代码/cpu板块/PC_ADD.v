`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 20:52:01
// Design Name: 
// Module Name: PC_ADD
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
module PC_ADD(
input [31:0]npc_in,
output reg [31:0]npc_out
);
always @(*) 
begin
    npc_out=npc_in+4;
end
endmodule
