`timescale 1ns / 1ps

module DLX_ALU_tb;
    reg [31:0] s1;
    reg [31:0] s2;
    reg [4:0] ALUop;
    reg [2:0] s2op;

    wire [31:0] ALUout;
    wire Zflag;

    DLX_ALU uut (
        .s1(s1),
        .s2(s2),
        .ALUop(ALUop),
        .s2op(s2op),
        .ALUout(ALUout),
        .Zflag(Zflag)
    );

    initial 
    begin
        $dumpfile("DLX_ALU_tb.vcd");
        $dumpvars(0, DLX_ALU_tb);

        s1 = 32'd10; s2 = 32'd20; ALUop = 5'b00000; s2op = 3'b000;
        #10;
        $display("ADD: s1=%0d, s2=%0d -> ALUout=%0d, Zflag=%b", s1, s2, ALUout, Zflag);

        s1 = 32'd0; s2 = 32'h00000000; ALUop = 5'b00001; s2op = 3'b001;
        #10;
        $display("SUB (s2op=001): ALUout=%0d, Zflag=%b", ALUout, Zflag);

        s1 = 32'd100; s2 = 32'd100; ALUop = 5'b10000; s2op = 3'b000;
        #10;
        $display("BEQ: ALUout=%0d, Zflag=%b", ALUout, Zflag);

        $finish;
    end

endmodule
