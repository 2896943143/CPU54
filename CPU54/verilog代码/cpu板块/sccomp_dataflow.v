`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 22:23:20
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
input clk_in,
input reset,
output [31:0]inst,
output [31:0] pc
);
wire imem_enb;
wire [31:0]imem_out;
wire d_wea,d_busy,d_start;
wire [2:0]d_num;
wire [31:0]d_addr,d_in,d_out;
wire [31:0]pc_out;
reg [31:0]pc_last;
assign inst=imem_out;
assign pc=pc_last;
always@(posedge clk_in,posedge reset)
begin
    if(reset)
    begin
        pc_last=32'h44436040;
    end
    else
    begin
        if(pc_last!=pc_out)
        begin
            pc_last=pc_out;
        end
    end
end
cpu sccpu(
.clk(clk_in),
.reset(reset),
.ir(imem_out),
.d_out(d_out),
.d_busy(d_busy),
.d_in(d_in),
.pc_out(pc_out),
.d_addr(d_addr),
.d_wea(d_wea),
.d_start(d_start),
.d_num(d_num),
.imem_enb(imem_enb)
);

Dmemory Dmemory(
.clk(clk_in),
.rst(reset),
.wea(d_wea),
.start(d_start),
.addr(d_addr),
.in_data(d_in),
.rol(d_num),
.busy(d_busy),
.out_data(d_out)
);
Imemory Imemory(
.clk(clk_in),
.rst(reset),
.enb(imem_enb),
.pc_out(pc_out),
.imem_out(imem_out)
);
endmodule
