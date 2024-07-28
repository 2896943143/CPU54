`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 22:03:48
// Design Name: 
// Module Name: CLZ
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


module CLZ(
input clk,
input [31:0]in_data,   
input start,    
input reset,  
output [31:0]result,    
output reg busy
);
reg [31:0]mem;
reg [5:0]count;
assign result={26'b00000000000000000000000000,count};
always @ (posedge clk or posedge reset)
begin
    if (reset == 1) 
    begin
       mem=0; 
       count = 0;
       busy = 0;
    end
   else
   begin
       if(start)
       begin
            mem=in_data;
            count=0;
            busy=1;
       end
       else
        if(busy)
        begin
            if(mem[31]||count==6'b100000)
            begin
                busy=0;
            end
            else
            begin
                count=count+1;
                mem=mem<<1;
            end
        end
    end
end
endmodule
