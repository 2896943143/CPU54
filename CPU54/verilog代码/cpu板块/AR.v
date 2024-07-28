`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/11 22:30:51
// Design Name: 
// Module Name: AR
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


module AR(
input clk,
input rst,
input start,
input [2:0]num,
input [31:0]in_addr,
output reg busy,
output [12:0]out_addr
);
reg [1:0]count;
reg [1:0]dst;
reg [12:0]mem;
assign out_addr=mem;
always @(posedge clk,posedge rst) 
begin
    if(rst)
    begin
        count=0;
        busy=0;
        dst=0;
        mem=0;
    end
    else
    begin
        if(start)
        begin
            count=0;
            mem=in_addr[12:0];
            case(num)
                3'b000:
                dst=3;
                3'b001:
                dst=1;
                3'b010:
                dst=1;
                3'b011:
                dst=0;
                3'b100:
                dst=0;
            endcase
            busy=1;
        end
        else
        begin
            if(busy)
            begin
                if(count==dst)
                begin
                    busy=0;
                end
                else
                begin
                    count=count+1;
                    mem=mem+1;
                end
            end
        end
    end
end
endmodule
