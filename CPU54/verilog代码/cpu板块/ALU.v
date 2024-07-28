`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 20:26:55
// Design Name: 
// Module Name: ALU
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


module ALU(
input clk,
input wea,
input [31:0] rst1,
input [31:0] rst2,
input [3:0] order,
output [31:0] result,
output Zero,
output Carry,
output Negative,
output Overflow
);
wire signed [31:0]signed1,signed2;
reg [31:0] my_result;
reg my_Carry;
reg my_Negative;
reg my_Overflow;
assign signed1=rst1;
assign signed2=rst2;
assign result=my_result;
assign Zero=my_result==0?1:0;
assign Carry=my_Carry;
assign Negative=my_Negative;
assign Overflow=my_Overflow;
always @(posedge clk) 
begin
    if(wea)
    begin
        case(order)
            4'b0000:begin//1,19
                my_result=rst1+rst2;
                if(rst1[31]==rst2[31]&&rst1[31]!=my_result[31])
                begin
                    my_Carry=1;
                end
                else
                begin
                    my_Carry=0;
                end
                my_Overflow=0;
                my_Negative=0;
            end
            4'b0001:begin//0,18
                my_result=signed1+signed2;
                if(signed1[31]==signed2[31]&&signed1[31]!=my_result[31])
                begin
                    my_Overflow=1;
                end
                else
                begin
                    my_Overflow=0;
                end
                if(my_result[31])
                begin
                    my_Negative=1;
                end
                else
                begin
                    my_Negative=0;
                end
                my_Carry=0;
            end
            4'b0010:begin//3
                my_result=rst1-rst2;
                if(rst1[31]==rst2[31]&&rst1[31]!=my_result[31])
                begin
                    my_Carry=1;
                end
                else
                begin
                    my_Carry=0;
                end
                my_Overflow=0;
                my_Negative=0;
            end
            4'b0011:begin//2,19
                my_result=signed1-signed2;
                if(signed1[31]==signed2[31]&&signed1[31]!=my_result[31])
                begin
                    my_Overflow=1;
                end
                else
                begin
                    my_Overflow=0;
                end
                if(my_result[31])
                begin
                    my_Negative=1;
                end
                else
                begin
                    my_Negative=0;
                end
                my_Carry=0;
            end
            4'b0100:begin//5,20
                my_result=rst1|rst2;
            end
            4'b0101:begin//4,19
                my_result=rst1&rst2;
            end
            4'b0110:begin//6,21
                my_result=rst1^rst2;
            end
            4'b0111:begin//7
                my_result=~(rst1|rst2);
            end
            4'b1000:begin//11,14
                my_result=rst2>>rst1;
            end
            4'b1001:begin//12,15
                my_result=signed2>>>rst1;
            end
            4'b1010:begin//10,13
                my_result=rst2<<rst1;
            end
            4'b1011:begin//8,26
                if(signed1<signed2)
                    my_result=1;
                else
                    my_result=0;
            end
            4'b1100:begin//9,27
                if(rst1<rst2)
                    my_result=1;
                else
                    my_result=0;
            end
        endcase
    end
end
endmodule

