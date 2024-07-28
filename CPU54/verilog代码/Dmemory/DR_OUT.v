`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 11:39:54
// Design Name: 
// Module Name: DR_OUT
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


module DR_OUT(
input clk,
input rst,
input start,
input [2:0]num,
input [31:0]in_data,
output reg busy,
output [7:0]out_data
);
reg [1:0]count;
reg [1:0]dst;
assign out_data=count==0?in_data[7:0]:count==1?in_data[15:8]:count==2?in_data[23:16]:in_data[31:24];
always @(posedge clk,posedge rst) 
begin
    if(rst)
    begin
        count=0;
        dst=0;
        busy=0;
    end
    else
    begin
        if(start)
        begin
            count=0;
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
                end
            end
        end
    end
end
endmodule
