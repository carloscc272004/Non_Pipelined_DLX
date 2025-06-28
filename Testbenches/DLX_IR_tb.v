`timescale 1ns / 1ps

module DLX_IR_tb;

    reg clock;
    reg reset;
    reg IRoeS1;
    reg IRoeS2;
    reg [31:0] data_bus;
    reg IRload;

    wire [5:0] opcode;
    wire [10:0] opcodeALU;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] s1_bus, s2_bus;

    DLX_IR uut (
        .clock(clock),
        .reset(reset),
        .opcode(opcode),
        .opcodeALU(opcodeALU),
        .IRoeS1(IRoeS1),
        .IRoeS2(IRoeS2),
        .data_bus(data_bus),
        .s1_bus(s1_bus),
        .s2_bus(s2_bus),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .IRload(IRload)
    );

    always #5 clock = ~clock;

    initial begin
        $dumpfile("DLX_IR_tb.vcd");
        $dumpvars(0, DLX_IR_tb);

        clock = 0;
        reset = 1; IRload = 0; IRoeS1 = 0; IRoeS2 = 0;
        #10;

        reset = 0;

        data_bus = 32'b00000000001000100001100000000001;
        IRload = 1;
        IRoeS1 = 1; IRoeS2 = 1;
        $display("R-type: opcode=%b, rs1=%d, rs2=%d, rd=%d, opcodeALU=%b", opcode, rs1, rs2, rd, opcodeALU);
        $display("s1_bus=%h, s2_bus=%h", s1_bus, s2_bus);

        data_bus = 32'b001000_00101_00110_0000000000001000; 
        IRload = 1;IRload = 0;
        IRoeS1 = 0; IRoeS2 = 0;
        $display("I-type: opcode=%b, rs1=%d, rs2=%d, rd=%d, opcodeALU=%b", opcode, rs1, rs2, rd, opcodeALU);

        data_bus = 32'b000010_00000000000000000000000000;
        IRload = 1;IRload = 0;
        IRoeS1 = 0; IRoeS2 = 0;
        $display("J-type: opcode=%b, rs1=%d, rs2=%d, rd=%d, opcodeALU=%b", opcode, rs1, rs2, rd, opcodeALU);

        $finish;
    end

endmodule
