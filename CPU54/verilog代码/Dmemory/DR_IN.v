`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/11 21:58:19
// Design Name: 
// Module Name: DR
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


module DR_IN(
input clk,
input rst,
input start,
input [2:0]num,
input [7:0]in_data,
output reg busy,
output [31:0]out_data
);
reg [31:0]mem;
reg [1:0]count;
reg [1:0]dst;
assign out_data=mem;
always @(posedge clk,posedge rst) 
begin
    if(rst)
    begin
        mem=0;
        count=0;
        dst=0;
        busy=0;
    end
    else
    begin
        if(start)
        begin
            mem=0;
            count=0;
            busy=1;
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
        end
        else
        begin
            if(busy)
            begin
                case(count)
                2'b00:
                begin
                    mem[7:0]=in_data;
                end
                2'b01:
                begin
                    mem[15:8]=in_data;
                end
                2'b10:
                begin
                    mem[23:16]=in_data;
                end
                2'b11:
                begin
                    mem[31:24]=in_data;
                end
                endcase
                if(count==dst)
                begin
                    if(num==2&&mem[15])
                    begin
                        mem[31:16]=16'hffff;
                    end
                    if(num==4&&mem[7])
                    begin
                        mem[31:8]=24'hffffff;
                    end
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
