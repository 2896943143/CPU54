`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 21:33:59
// Design Name: 
// Module Name: CP0
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


module CP0(
input clk,
input rst,
input [31:0]data_in,
input [4:0]sel,
input [2:0]role,
output reg [31:0]outdata
);
reg [31:0]temp[31:0];
integer i;
always @(posedge clk,posedge rst) 
begin
    if(rst)
    begin
        for(i=0;i<32;i=i+1)
        begin
            temp[i]=0;
        end
        temp[12][0]=1;
    end
    else
    begin
        case(role)
            3'b000://mfc0
            begin
                outdata=temp[sel];
            end
            3'b001://mtc0
            begin
                temp[sel]=data_in;
            end
            3'b010://break
            begin
                if(!temp[12][9]&&temp[12][0])
                begin
                    temp[12][0]=0;
                    temp[12][10]=1;
                    temp[14]=data_in;
                    temp[13][5:2]={4'b1001};
                end
            end
            3'b011://syscall
            begin
                if(!temp[12][8]&&temp[12][0])
                begin
                    temp[12][0]=0;
                    temp[12][10]=1;
                    temp[12][9]=1;
                    temp[14]=data_in;
                    temp[13][5:2]={4'b1000};
                end
            end
            3'b100://teq
            begin
                if(!temp[12][10]&&temp[12][0])
                begin
                    temp[12][0]=0;
                    temp[14]=data_in;
                    temp[13][5:2]={4'b1101};
                end
            end
            3'b101://tert
            begin
                temp[12][0]=1;
                outdata=temp[14];
                temp[12][10:8]={3'b000};
                temp[13][5:2]={4'b0000};
            end
        endcase
    end
    
end
endmodule
