`timescale 1ns / 1ps


module DLX_CU(clock, s2op, Zflag, ALUop, Cload, REGload, Aload, Aoe, Bload, Boe, REGselect, IRload, IRoeS1, IRoeS2,opcode,
    opcodeALU, Reset, PCload, PCoeS1, IARload, IARoeS1, IARoeS2, PCMARselect, MARload, MemRead, MDRload, MDRoeS2, MemWrite, MemOP, MemWait);

input clock;
output reg[2:0] s2op;
input Zflag;
output reg[4:0] ALUop;
output reg Cload;
output reg REGload;
output reg Aload;
output reg Aoe;
output reg Bload;
output Boe;

output reg[1:0] REGselect;
output reg IRload;
output IRoeS1;
output reg IRoeS2;
input[5:0] opcode;
input [4:0] opcodeALU;
input Reset;
output reg PCload;
output reg PCoeS1;

output IARload;
output IARoeS1;
output IARoeS2;

output reg PCMARselect;
output MARload;

output reg MemRead;
output MDRload;
output MDRoeS2;
output MemWrite;
output reg[1:0] MemOP;
input MemWait;

localparam IF = 3'b000;
localparam ID = 3'b001;
localparam EX = 3'b010;
localparam MEM = 3'b011;
localparam WB = 3'b100;

reg[2:0] present_stage, next_stage;

always @(posedge clock or posedge Reset)
begin
    if (Reset)
        present_stage <= IF;
    else if (MemWait)
        present_stage <= present_stage;
    else
        present_stage <= next_stage;
end

always@(*)
begin
    case(present_stage)
        IF: next_stage = ID;
        ID: next_stage = EX;
        EX: next_stage = MEM;
        MEM: next_stage = WB;
        WB: next_stage = IF;
        default: next_stage = IF;
    endcase 
end

always@(*)
begin
    PCMARselect = 0;
    MemRead = 0;
    MemOP = 2'b00;
    IRload = 0;
    Aload = 0;
    Bload = 0;
    PCoeS1 = 0;
    s2op = 3'b000;
    ALUop = 5'b00000;
    PCload = 0;
    IRoeS2 = 0;
    Aoe = 0;
    Cload = 0;
    REGselect = 2'b00;
    REGload = 0;
    case(present_stage)
    
        IF:
        begin
            PCMARselect <= 1'b0;
            MemRead <= 1'b1;
            MemOP <= 2'b00;
            IRload = 1'b1;
        end
        
        ID:
        begin
            Aload = 1'b1;
            Bload =1'b1;
            PCoeS1 =1'b1;
            s2op = 3'b111;
            ALUop = 1'b0;
            PCload =1'b1;
        end
        
        EX:
        begin
            if (opcode == 6'd8)
            begin
                IRoeS2 = 1'b1;
                Aoe = 1'b1;
                s2op = 2'b011;
                ALUop = 5'b00000; 
                Cload =1'b1;   
            end
            //More opcodes will be implemented but for the sake of making control unit, the following stages will be executing the ADDI instruction.
        end
        
        MEM:
        begin
            
        end
        
        WB:
        begin
          REGselect =2'b00;
          REGload = 1'b1;  
        end
    endcase

end
endmodule
