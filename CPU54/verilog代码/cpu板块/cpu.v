`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/10 16:28:35
// Design Name: 
// Module Name: cpu
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

module cpu(
input clk,
input reset,
input [31:0]ir,
input [31:0]d_out,
input d_busy,
output [31:0]d_in,
output [31:0]pc_out,
output [31:0]d_addr,
output d_wea,
output d_start,
output [2:0]d_num,
output imem_enb
);
wire clz_start,clz_busy;
wire [31:0]clz_output;

wire [31:0]hi_in,hi_out,lo_in,lo_out,div_mul_hout,div_mul_lout;
wire [31:0]div_hi_out,div_lo_out,divu_hi_out,divu_lo_out,mult_hi_out,mult_lo_out,multu_hi_out,multu_lo_out;
wire hi_wea,lo_wea;
wire select_hi_in_order;
wire select_lo_in_order;
wire [1:0]select_div_mul_hin_order;
wire [1:0]select_div_mul_lin_order;

wire div_start,div_busy;
wire divu_start,divu_busy;
wire mult_start,mult_busy;
wire multu_start,multu_busy;

wire [31:0]imem_1,imem_2;

wire [1:0]select_alu_in1_order;
wire [1:0]select_alu_in2_order;

wire alu_wea;
wire [31:0]alu_in1,alu_in2,alu_out;
wire [3:0]alu_order;
wire Zero;
wire Carry;
wire Negative;
wire Overflow;

wire [31:0]pc_indata,pc_outdata;
wire pc_wea;
wire [1:0]select_pc_in_order;

wire [31:0] npc_out;

wire regfile_wea;
wire [4:0]regfile_inorder;
wire [4:0]regfile_outorder1;
wire [4:0]regfile_outorder2;
wire [31:0]regfile_outdata1,regfile_outdata2;
wire [31:0]regfile_indata;
wire [2:0]select_regfile_in_order;

wire [31:0]dr_out;

wire [4:0]cp0_order;
wire [2:0]cp0_role;
wire [31:0]cp0_outdata,cp0_indata;
wire select_cp0_in_order;

assign pc_out=pc_outdata;
assign d_in=regfile_outdata2;
assign d_addr=alu_out;

Controller Controller(
.clk(clk),
.rst(reset),
.ir(ir),
.Zero(Zero),
.Negative(Negative),
.div_busy(div_busy),
.divu_busy(divu_busy),
.mult_busy(mult_busy),
.multu_busy(multu_busy),
.d_busy(d_busy),
.clz_busy(clz_busy),
.select_regfile_in_order(select_regfile_in_order),
.regfile_outorder1(regfile_outorder1),
.regfile_outorder2(regfile_outorder2),
.regfile_inorder(regfile_inorder),
.regfile_wea(regfile_wea),
.alu_order(alu_order),
.select_pc_in_order(select_pc_in_order),
.pc_wea(pc_wea),
.imem_1(imem_1),
.imem_2(imem_2),
.alu_wea(alu_wea),
.select_alu_in1_order(select_alu_in1_order),
.select_alu_in2_order(select_alu_in2_order),
.d_num(d_num),
.d_start(d_start),
.d_wea(d_wea),
.div_start(div_start),
.divu_start(divu_start),
.mult_start(mult_start),
.multu_start(multu_start),
.hi_wea(hi_wea),
.lo_wea(lo_wea),
.cp0_role(cp0_role),
.select_cp0_in_order(select_cp0_in_order),
.select_hi_in_order(select_hi_in_order),
.select_lo_in_order(select_lo_in_order),
.clz_start(clz_start),
.imem_enb(imem_enb),
.select_div_mul_hin_order(select_div_mul_hin_order),
.select_div_mul_lin_order(select_div_mul_lin_order),
.cp0_sel(cp0_order)
);

PC_ADD npc(
.npc_in(pc_outdata),
.npc_out(npc_out)
);

select2_1 select_cp0_in(
.in_data1(npc_out),
.in_data2(regfile_outdata2),
.order(select_cp0_in_order),
.out_data(cp0_indata)
);

select2_1 select_hi_in(
.in_data1(div_mul_hout),
.in_data2(regfile_outdata1),
.order(select_hi_in_order),
.out_data(hi_in)
);

select2_1 select_lo_in(
.in_data1(div_mul_lout),
.in_data2(regfile_outdata1),
.order(select_lo_in_order),
.out_data(lo_in)
);

select8_3 select_regfile_in(
.in_data1(alu_out),
.in_data2(d_out),
.in_data3(npc_out),
.in_data4(imem_2),
.in_data5(cp0_outdata),
.in_data6(hi_out),
.in_data7(lo_out),
.in_data8(clz_output),
.order(select_regfile_in_order),
.out_data(regfile_indata)
);

select4_2 select_pc_in(
.in_data1(npc_out),
.in_data2(alu_out),
.in_data3(32'h00400004),
.in_data4(cp0_outdata),
.order(select_pc_in_order),
.out_data(pc_indata)
);

select4_2 select_alu_in1(
.in_data1(regfile_outdata1),
.in_data2(imem_1),
.in_data3(npc_out),
.in_data4(32'h00000000),
.order(select_alu_in1_order),
.out_data(alu_in1)
);

select4_2 select_alu_in2(
.in_data1(regfile_outdata2),
.in_data2(imem_2),
.in_data3(regfile_outdata1),
.in_data4(32'h00000000),
.order(select_alu_in2_order),
.out_data(alu_in2)
);

select4_2 select_div_mul_hin(
.in_data1(div_hi_out),
.in_data2(divu_hi_out),
.in_data3(mult_hi_out),
.in_data4(multu_hi_out),
.order(select_div_mul_hin_order),
.out_data(div_mul_hout)
);

select4_2 select_div_mul_lin(
.in_data1(div_lo_out),
.in_data2(divu_lo_out),
.in_data3(mult_lo_out),
.in_data4(multu_lo_out),
.order(select_div_mul_lin_order),
.out_data(div_mul_lout)
);

ALU ALU(
.clk(clk),
.wea(alu_wea),
.rst1(alu_in1),
.rst2(alu_in2),
.order(alu_order),
.result(alu_out),
.Zero(Zero),
.Carry(Carry),
.Negative(Negative),
.Overflow(Overflow)
);

PC  PC(
.clk(clk),
.rst(reset),
.wea(pc_wea),
.indata({16'h0000,pc_indata[15:0]}),
.outdata(pc_outdata)
);

regfile cpu_ref(
.clk(clk),
.reset(reset),
.wea(regfile_wea),
.inorder(regfile_inorder),
.outorder1(regfile_outorder1),
.outorder2(regfile_outorder2),
.indata(regfile_indata),
.outdata1(regfile_outdata1),
.outdata2(regfile_outdata2)
);

CP0 CP0(
.clk(clk),
.rst(reset),
.data_in(cp0_indata),
.sel(cp0_order),
.role(cp0_role),
.outdata(cp0_outdata)
);

DIV DIV(
.dividend(regfile_outdata1),
.divisor(regfile_outdata2),   
.start(div_start),    
.clock(clk),
.reset(reset),
.q(div_lo_out),    
.r(div_hi_out),    
.busy(div_busy)
);

DIVU DIVU(
.dividend(regfile_outdata1),
.divisor(regfile_outdata2),   
.start(divu_start),    
.clock(clk),
.reset(reset),
.q(divu_lo_out),    
.r(divu_hi_out),    
.busy(divu_busy)
);

MULT MULT(
.clk(clk),
.reset(reset),
.start(mult_start),
.a(regfile_outdata1),
.b(regfile_outdata2),
.busy(mult_busy),
.h(mult_hi_out),    
.l(mult_lo_out)   
);

MULTU MULTU(
.clk(clk),
.reset(reset),
.start(multu_start),
.a(regfile_outdata1),
.b(regfile_outdata2),
.busy(multu_busy),
.h(multu_hi_out),    
.l(multu_lo_out)   
);

HI HI(
.clk(clk),
.rst(reset),
.wea(hi_wea),
.indata(hi_in),
.outdata(hi_out)
);

LO LO(
.clk(clk),
.rst(reset),
.wea(lo_wea),
.indata(lo_in),
.outdata(lo_out)
);

CLZ CLZ(
.clk(clk),
.in_data(regfile_outdata1),   
.start(clz_start),    
.reset(reset),  
.result(clz_output),    
.busy(clz_busy)
);
endmodule
