`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 21:26:39
// Design Name: 
// Module Name: DIV
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


module DIV(
input [31:0]dividend,
input [31:0]divisor,   
input start,    
input clock,
input reset,
output [31:0]q,    
output [31:0]r,    
output reg busy
);
reg [4:0]count;
reg signed [31:0]reg_q;
reg signed [31:0]reg_r;
reg signed [31:0]reg_b;
reg r_sign;
reg sign1,sign2;
wire signed [31:0]temp3;
wire signed [32:0]temp1={reg_r,reg_q[31]};
wire signed [32:0]temp2={{reg_b[31],reg_b}};
wire signed [32:0]sub_add=r_sign?(temp1+temp2):(temp1-temp2);
assign temp3=r_sign?reg_r+reg_b:reg_r;
assign r=sign2?-temp3:temp3;
assign q=sign1?-reg_q:reg_q;
always @ (posedge clock or posedge reset)
begin
    if (reset == 1) 
    begin 
       count = 0;
       busy = 0;
    end
   else
   begin
       if(start)
       begin
           reg_q=dividend;
           reg_q=dividend[31]?-reg_q:reg_q;
           r_sign=0;
           reg_r=0;
           reg_b=divisor;
           reg_b=divisor[31]?-reg_b:reg_b;
           count=0;
           busy=1'b1;
           sign1=dividend[31]^divisor[31];
           sign2=dividend[31];
       end
       else
        if(busy)
            begin
                reg_r=sub_add[31:0];
                r_sign=sub_add[32];
                reg_q={reg_q[30:0],~sub_add[32]};
                 if(count==5'b11111)
                      busy=0;
                 count=count+1;
            end
        end
   end
endmodule
