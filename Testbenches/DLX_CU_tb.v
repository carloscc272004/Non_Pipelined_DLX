`timescale 1ns / 1ps

module DLX_CU_tb;

    reg clock;
    reg Reset;
    reg Zflag;
    reg [5:0] opcode;
    reg [4:0] opcodeALU;
    reg MemWait;

    wire [2:0] s2op;
    wire [4:0] ALUop;
    wire Cload;
    wire REGload;
    wire Aload;
    wire Aoe;
    wire Bload;
    wire Boe;
    wire [1:0] REGselect;
    wire IRload;
    wire IRoeS1;
    wire IRoeS2;
    wire PCload;
    wire PCoeS1;
    wire IARload;
    wire IARoeS1;
    wire IARoeS2;
    wire PCMARselect;
    wire MARload;
    wire MemRead;
    wire MDRload;
    wire MDRoeS2;
    wire MemWrite;
    wire [1:0] MemOP;

    DLX_CU uut (
        .clock(clock),
        .s2op(s2op),
        .Zflag(Zflag),
        .ALUop(ALUop),
        .Cload(Cload),
        .REGload(REGload),
        .Aload(Aload),
        .Aoe(Aoe),
        .Bload(Bload),
        .Boe(Boe),
        .REGselect(REGselect),
        .IRload(IRload),
        .IRoeS1(IRoeS1),
        .IRoeS2(IRoeS2),
        .opcode(opcode),
        .opcodeALU(opcodeALU),
        .Reset(Reset),
        .PCload(PCload),
        .PCoeS1(PCoeS1),
        .IARload(IARload),
        .IARoeS1(IARoeS1),
        .IARoeS2(IARoeS2),
        .PCMARselect(PCMARselect),
        .MARload(MARload),
        .MemRead(MemRead),
        .MDRload(MDRload),
        .MDRoeS2(MDRoeS2),
        .MemWrite(MemWrite),
        .MemOP(MemOP),
        .MemWait(MemWait)
    );

    always #5 clock = ~clock;

    initial begin
        $dumpfile("DLX_CU_tb.vcd");
        $dumpvars(0, DLX_CU_tb);

        clock = 0;
        Reset = 1;
        opcode = 6'd8;
        opcodeALU = 5'b00000;
        Zflag = 0;
        MemWait = 0;

        #10 Reset = 0;

        repeat (10) 
        begin
            #10;
            $display("\nTime: %0t ns", $time);
            $display("ALUop       = %b", ALUop);
            $display("s2op        = %b", s2op);
            $display("Aload       = %b", Aload);
            $display("Aoe         = %b", Aoe);
            $display("Bload       = %b", Bload);
            $display("Boe         = %b", Boe);
            $display("Cload       = %b", Cload);
            $display("REGselect   = %b", REGselect);
            $display("REGload     = %b", REGload);
            $display("IRload      = %b", IRload);
            $display("IRoeS1      = %b", IRoeS1);
            $display("IRoeS2      = %b", IRoeS2);
            $display("PCload      = %b", PCload);
            $display("PCoeS1      = %b", PCoeS1);
            $display("PCMARselect = %b", PCMARselect);
            $display("MemRead     = %b", MemRead);
            $display("MemWrite    = %b", MemWrite);
            $display("MDRload     = %b", MDRload);
            $display("MDRoeS2     = %b", MDRoeS2);
            $display("MemOP       = %b", MemOP);
        end

        $finish;
    end

endmodule
