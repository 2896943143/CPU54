`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/10 14:25:34
// Design Name: 
// Module Name: Controller
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


module Controller(
input clk,
input rst,
input [31:0]ir,
input Zero,
input Negative,
input div_busy,
input divu_busy,
input mult_busy,
input multu_busy,
input d_busy,
input clz_busy,
output [2:0]select_regfile_in_order,
output [4:0]regfile_outorder1,
output [4:0]regfile_outorder2,
output [4:0]regfile_inorder,
output regfile_wea,
output [3:0]alu_order,
output [1:0]select_pc_in_order,
output pc_wea,
output [31:0]imem_1,
output [31:0]imem_2,
output alu_wea,
output [1:0]select_alu_in1_order,
output [1:0]select_alu_in2_order,
output [2:0]d_num,
output d_start,
output d_wea,
output div_start,
output divu_start,
output mult_start,
output multu_start,
output hi_wea,
output lo_wea,
output [2:0]cp0_role,
output select_cp0_in_order,
output select_hi_in_order,
output select_lo_in_order,
output clz_start,
output imem_enb,
output [1:0]select_div_mul_hin_order,
output [1:0]select_div_mul_lin_order,
output [4:0]cp0_sel
);
wire [53:0]temp;
reg [2:0]now;
reg flages;

parameter add = 0;
parameter addu = 1;
parameter sub = 2;
parameter subu = 3;
parameter and1 = 4;
parameter or1 = 5;
parameter xor1 = 6;
parameter nor1 = 7;
parameter slt  = 8;
parameter sltu = 9;
parameter sll = 10;
parameter srl = 11;
parameter sra = 12;
parameter sllv = 13;
parameter srlv = 14;
parameter srav = 15;
parameter jr = 16;
parameter addi = 17;
parameter addiu = 18;
parameter andi = 19;
parameter ori = 20;
parameter xori = 21;
parameter lw = 22;
parameter sw = 23;
parameter beq = 24;
parameter bne = 25;
parameter slti = 26;
parameter sltiu = 27;
parameter lui = 28;
parameter j = 29;
parameter jal = 30;
parameter div = 31;
parameter divu = 32;
parameter mult = 33;
parameter multu = 34;
parameter bgez = 35;
parameter jalr = 36;
parameter lbu = 37;
parameter lhu = 38;
parameter lb = 39;
parameter lh = 40;
parameter sb = 41;
parameter sh = 42;
parameter break = 43;
parameter syscall = 44;
parameter eret = 45;
parameter mfhi = 46;
parameter mflo = 47;
parameter mthi = 48;
parameter mtlo = 49;
parameter mfc0 = 50;
parameter mtc0 = 51;
parameter clz = 52;
parameter teq = 53;

decoder decoder1(
.ir(ir),
.out_data(temp)
);

assign select_div_mul_hin_order=temp[multu]?2'b11:temp[mult]?2'b10:temp[divu]?2'b01:2'b00;
assign select_div_mul_lin_order=temp[multu]?2'b11:temp[mult]?2'b10:temp[divu]?2'b01:2'b00;

assign imem_enb=now==0?1:0;

assign regfile_outorder1=ir[25:21];
assign regfile_outorder2=ir[20:16];
assign regfile_inorder=temp[jal]||temp[jalr]?5'b11111:(temp[addi]||temp[addiu]||temp[andi]||temp[ori]||temp[xori]||temp[lw]||temp[lb]||temp[lbu]||temp[lh]||temp[lhu]||temp[slti]||temp[sltiu]||temp[lui]||temp[mfc0])?ir[20:16]:ir[15:11];
assign regfile_wea=(now==3&&!temp[div]&&!temp[divu]&&!temp[mult]&&!temp[multu])?1:0;

assign alu_wea=now==2||now==6?1:0;
assign alu_order[0]=now==2?(temp[0]||temp[2]||temp[4]||temp[7]||temp[8]||temp[12]||temp[15]||temp[17]||temp[19]||temp[26]||temp[bgez])?1:0:0;
assign alu_order[1]=now==2?(temp[2]||temp[3]||temp[6]||temp[7]||temp[8]||temp[10]||temp[13]||temp[21]||temp[24]||temp[25]||temp[26]||temp[bgez]||temp[teq])?1:0:0;
assign alu_order[2]=now==2?(temp[5]||temp[4]||temp[6]||temp[7]||temp[9]||temp[19]||temp[20]||temp[21]||temp[27])?1:0:0;
assign alu_order[3]=now==2?(temp[8]||temp[9]||temp[10]||temp[11]||temp[12]||temp[13]||temp[14]||temp[15]||temp[26]||temp[27])?1:0:0;

assign select_regfile_in_order=temp[clz]?3'b111:temp[mflo]?3'b110:temp[mfhi]?3'b101:temp[mfc0]?3'b100:temp[jal]||temp[jalr]?3'b010:temp[lw]||temp[lb]||temp[lbu]||temp[lh]||temp[lhu]?3'b001:temp[lui]?3'b011:3'b000;

assign select_pc_in_order=(temp[eret])?2'b11:(temp[break]||temp[syscall]||(temp[teq]&&Zero))?2'b10:(temp[jr]||(temp[beq]&&flages)||(temp[bne]&&flages)||(temp[bgez]&&flages)||temp[j]||temp[jal]||temp[jalr])?2'b01:2'b00;
assign pc_wea=now==7?1:0;

assign imem_1={27'b000000000000000000000000000,ir[10:6]};
assign imem_2=temp[lui]?{ir[15:0],16'b0000000000000000}:ir[15]&&!temp[andi]&&!temp[ori]&&!temp[xori]?{16'b1111111111111111,ir[15:0]}:(now==6&&(temp[j]||temp[jal]||temp[bne]||temp[beq]||temp[bgez]||temp[jalr]))?{14'b00000000000000,ir[15:0],2'b00}:{16'b0000000000000000,ir[15:0]};

assign select_alu_in1_order=(now==6&&(temp[j]||temp[jal]||temp[jr]||temp[jalr]))?2'b11:(now==6&&(temp[beq]||temp[bgez]||temp[bne]))?2'b10:(temp[sll]||temp[srl]||temp[sra])?2'b01:2'b00;
assign select_alu_in2_order=(now==2&&temp[bgez])?2'b11:(now==6&&(temp[jr]||temp[jalr]))?2'b10:(temp[addi]||temp[addiu]||temp[andi]||temp[ori]||temp[xori]||temp[lw]||temp[lh]||temp[lhu]||temp[sh]||temp[lb]||temp[lbu]||temp[sb]||temp[sw]||temp[slti]||temp[sltiu]||temp[lui]||(now==6&&(temp[j]||temp[jal]||temp[bne]||temp[beq]||temp[bgez]||temp[jalr])))?2'b01:2'b00;

assign d_num=(temp[lw]||temp[sw])?0:(temp[lhu])?1:(temp[lh]||temp[sh])?2:(temp[lbu])?3:4;
assign d_start=((now==4||now==1)&&flages&&(temp[lw]||temp[lhu]||temp[lh]||temp[lb]||temp[lbu]||temp[sw]||temp[sh]||temp[sb]))?1:0;
assign d_wea=d_busy&&(temp[sw]||temp[sh]||temp[sb])?1:0;

assign div_start=(temp[div]&&now==2&&flages)?1:0;
assign divu_start=(temp[divu]&&now==2&&flages)?1:0;
assign multu_start=(temp[multu]&&now==2&&flages)?1:0;
assign mult_start=(temp[mult]&&now==2&&flages)?1:0;

assign hi_wea=now==3&&(temp[div]||temp[divu]||temp[mult]||temp[multu]||temp[mthi])?1:0;
assign lo_wea=now==3&&(temp[div]||temp[divu]||temp[mult]||temp[multu]||temp[mtlo])?1:0;
assign select_hi_in_order=temp[mthi]?1:0;
assign select_lo_in_order=temp[mtlo]?1:0;

assign cp0_role=now==5?temp[mfc0]?3'b000:temp[mtc0]?3'b001:temp[break]?3'b010:temp[syscall]?3'b011:temp[teq]?3'b100:3'b101:3'b111;
assign select_cp0_in_order=(temp[mtc0])?1:0;
assign cp0_sel=ir[15:11];

assign clz_start=(temp[clz]&&now==2&&flages)?1:0;

always @(negedge clk,posedge rst) 
begin
    if(rst)
    begin
        now=0;
        flages=0;
    end
    else
    begin
        case(now)
            3'b000:
            begin
                if(temp[j]||temp[jr]||temp[jal]||temp[lw]||temp[sw]||temp[lh]||temp[lhu]||temp[sh]||temp[lb]||temp[lbu]||temp[sb])
                begin
                    now=6;
                end
                else
                begin
                    if(temp[lui]||temp[mfhi]||temp[mflo])
                    begin
                        now=3;
                    end
                    else
                    begin
                        if(temp[mtc0]||temp[break]||temp[syscall]||temp[mfc0]||temp[eret])
                        begin
                            now=5;
                        end
                        else
                        begin
                            flages=1;
                            now=2;
                        end
                    end
                end
            end
            3'b001:
            begin
                flages=0;
                if(!d_busy)
                begin
                    now=3;
                end
            end
            3'b010:
            begin
                flages=0;
                if(temp[beq]||temp[bne]||temp[teq]||temp[bgez])
                begin
                    if((temp[beq]&&Zero)||(temp[bne]&&!Zero)||(temp[bgez]&&!Negative))
                    begin
                        now=6;
                    end
                    else
                    begin
                        if(temp[teq]&&Zero)
                        begin
                            now=5;
                        end
                        else
                        begin
                            now=7;
                        end
                    end
                end
                else
                begin
                    if((temp[mult]||temp[div]||temp[divu]||temp[multu]||temp[clz])&&(div_busy||divu_busy||mult_busy||multu_busy||clz_busy))
                    begin
                        now=2;
                    end
                    else
                    begin
                        now=3;
                    end
                end
            end
            3'b011:
            begin
                now=7;
            end
            3'b100:
            begin
                flages=0;
                if(!d_busy)
                begin
                    now=7;
                end
            end
            3'b101:
            begin
                if(temp[mfc0])
                begin
                    now=3;
                end
                else
                begin
                    now=7;
                end
            end
            3'b110:
            begin
                flages=1;
                if(temp[lw]||temp[lbu]||temp[lb]||temp[lh]||temp[lhu])
                begin
                    now=1;
                end
                else
                begin
                    if(temp[sw]||temp[sh]||temp[sb])
                    begin
                        now=4;
                    end
                    else
                    begin
                        if(temp[jal]||temp[jalr])
                        begin
                            now=3;
                        end
                        else
                        begin
                            now=7;
                        end
                    end
                end
            end
            3'b111:
            begin
                now=0;
                flages=0;
            end
        endcase
    end
end
endmodule
