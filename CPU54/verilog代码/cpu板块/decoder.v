`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/10 14:27:59
// Design Name: 
// Module Name: decoder
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


module decoder(
input [31:0]ir,
output reg [53:0]out_data
);
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
always @(*) 
begin
    out_data=0;
    case(ir[31:26])
    6'b000000:
        begin
            case(ir[5:0])
                6'b100000:
                begin
                    out_data[add]=1;
                end
                6'b100001:
                begin
                    out_data[addu]=1;
                end
                6'b100010:
                begin
                    out_data[sub]=1;
                end
                6'b100011:
                begin
                    out_data[subu]=1;
                end
                6'b100100:
                begin
                    out_data[and1]=1;
                end
                6'b100101:
                begin
                    out_data[or1]=1;
                end
                6'b100110:
                begin
                    out_data[xor1]=1;
                end
                6'b100111:
                begin
                    out_data[nor1]=1;
                end
                6'b101010:
                begin
                    out_data[slt]=1;
                end
                6'b101011:
                begin
                    out_data[sltu]=1;
                end
                6'b000000:
                begin
                    out_data[sll]=1;
                end
                6'b000010:
                begin
                    out_data[srl]=1;
                end
                6'b000011:
                begin
                    out_data[sra]=1;
                end
                6'b000100:
                begin
                    out_data[sllv]=1;
                end
                6'b000110:
                begin
                    out_data[srlv]=1;
                end
                6'b000111:
                begin
                    out_data[srav]=1;
                end
                6'b001000:
                begin
                    out_data[jr]=1;
                end
                6'b011010:
                begin
                    out_data[div]=1;
                end
                6'b011011:
                begin
                    out_data[divu]=1;
                end
                6'b011000:
                begin
                    out_data[mult]=1;
                end
                6'b011001:
                begin
                    out_data[multu]=1;
                end
                6'b001001:
                begin
                    out_data[jalr]=1;
                end
                6'b001101:
                begin
                    out_data[break]=1;
                end
                6'b001100:
                begin
                    out_data[syscall]=1;
                end
                6'b010000:
                begin
                    out_data[mfhi]=1;
                end
                6'b010010:
                begin
                    out_data[mflo]=1;
                end
                6'b010001:
                begin
                    out_data[mthi]=1;
                end
                6'b010011:
                begin
                    out_data[mtlo]=1;
                end
                6'b110100:
                begin
                    out_data[teq]=1;
                end
            endcase
        end
        6'b010000:
        begin
            case(ir[5:0])
            6'b011000:
            begin
                out_data[eret]=1;
            end
            6'b000000:
            begin
                case(ir[25:21])
                5'b00000:
                begin
                    out_data[mfc0]=1;
                end
                5'b00100:
                begin
                    out_data[mtc0]=1;
                end
                endcase
            end
            endcase
        end
        6'b011100:
        begin
            out_data[clz]=1;
        end
        6'b000001:
        begin
            out_data[bgez]=1;
        end
        6'b100100:
        begin
            out_data[lbu]=1;
        end
        6'b100101:
        begin
            out_data[lhu]=1;
        end
        6'b100000:
        begin
            out_data[lb]=1;
        end
        6'b100001:
        begin
            out_data[lh]=1;
        end
        6'b101000:
        begin
            out_data[sb]=1;
        end
        6'b101001:
        begin
            out_data[sh]=1;
        end
        6'b001000:
        begin
            out_data[addi]=1;
        end
        6'b001001:
        begin
            out_data[addiu]=1;
        end
        6'b001100:
        begin
            out_data[andi]=1;
        end
        6'b001101:
        begin
            out_data[ori]=1;
        end
        6'b001110:
        begin
            out_data[xori]=1;
        end
        6'b100011:
        begin
            out_data[lw]=1;
        end
        6'b101011:
        begin
            out_data[sw]=1;
        end
        6'b000100:
        begin
            out_data[beq]=1;
        end
        6'b000101:
        begin
            out_data[bne]=1;
        end
        6'b001010:
        begin
            out_data[slti]=1;
        end
        6'b001011:
        begin
            out_data[sltiu]=1;
        end
        6'b001111:
        begin
           out_data[lui]=1;
        end
        6'b000010:
        begin
            out_data[j]=1;
        end
        6'b000011:
        begin
            out_data[jal]=1;
        end
    endcase
end
endmodule
