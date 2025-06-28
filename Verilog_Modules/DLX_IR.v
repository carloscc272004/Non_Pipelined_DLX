`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2025 01:48:27 PM
// Design Name: 
// Module Name: DLX_IR
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


module DLX_IR( clock, reset, opcode, opcodeALU, IRoeS1, IRoeS2, data_bus, s1_bus, s2_bus, rs1, rs2, rd, IRload);

input clock;
input reset;
input IRoeS1;
input IRoeS2;
input[31:0] data_bus;
input IRload;

reg[31:0] IR_reg;
reg[5:0] opcode_reg;
reg[4:0] rs1_reg;
reg[4:0] rs2_reg;
reg[4:0] rd_reg;
reg[10:0] opcodeALU_reg;

output[5:0] opcode;
output[10:0] opcodeALU;
output[4:0] rs1;
output[4:0] rs2;
output[4:0] rd;
output[31:0] s1_bus;
output[31:0] s2_bus;


always @(posedge clock or posedge reset) 
begin
        if (reset) 
        begin
            IR_reg <= 32'b0;
            opcode_reg <= 6'd0;
            rs1_reg <= 5'd0;
            rs2_reg <= 5'd0;
            rd_reg <= 5'd0;
            opcodeALU_reg <= 11'd0;
        end 
        else if (IRload) 
        begin
            IR_reg <= data_bus;
            opcode_reg <= data_bus[31:26];
            
            case (data_bus[31:26])
                6'b000000: 
                begin // R-type
                    rs1_reg <= data_bus[25:21];
                    rs2_reg <= data_bus[20:16];
                    rd_reg  <= data_bus[15:11];
                    opcodeALU_reg <= data_bus[10:0];
                end
                6'b000010, // J
                6'b000011: 
                begin // JAL
                    rs1_reg <= 5'd0;
                    rs2_reg <= 5'd0;
                    rd_reg  <= 5'd0;
                    opcodeALU_reg <= 11'd0;
                end
                default: 
                begin // I-type
                    rs1_reg <= data_bus[25:21];
                    rs2_reg <= data_bus[20:16]; 
                    rd_reg  <= data_bus[20:16]; 
                    opcodeALU_reg <= 11'd0;
                end
            endcase
        end
    end

    assign s1_bus = IRoeS1 ? IR_reg : 32'bz;
    assign s2_bus = IRoeS2 ? IR_reg : 32'bz;

    assign opcode = opcode_reg;
    assign rs1 = rs1_reg;
    assign rs2 = rs2_reg;
    assign rd = rd_reg;
    assign opcodeALU = opcodeALU_reg;

endmodule