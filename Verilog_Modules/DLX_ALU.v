`timescale 1ns / 1ps

module DLX_ALU( s1, s2, ALUop, s2op, ALUout, Zflag);

    input[31:0] s1;
    input[31:0] s2;
    input[4:0] ALUop;
    input[2:0] s2op;
    
    output[31:0] ALUout;
    output Zflag;
    
    reg[31:0] ALU_out;
    reg Zflag_;
    reg[31:0] s2_intermediate;
    
    assign ALUout = ALU_out;
    assign Zflag = Zflag_;
    
    always @(*) begin
        case (s2op)
            3'b000: s2_intermediate = s2;
            3'b001: s2_intermediate = {{24{s2[7]}}, s2[7:0]};
            3'b010: s2_intermediate = {{24{1'b0}}, s2[7:0]};
            3'b011: s2_intermediate = {{16{s2[15]}}, s2[15:0]};
            3'b100: s2_intermediate = {{16{1'b0}}, s2[15:0]};
            3'b101: s2_intermediate = {{6{s2[25]}}, s2[25:0]};
            3'b110: s2_intermediate = 32'b00000000000000000000000000010000; 
            3'b111: s2_intermediate = 32'b00000000000000000000000000000100;
        endcase
    end
    
    always @(*) begin
        case(ALUop)
            5'b00000: ALU_out = s2_intermediate + s1;
            5'b00001: ALU_out = s1 - s2_intermediate;
            5'b00010: ALU_out = s1;
            5'b00011: ALU_out = s2;
            5'b00100: ALU_out = s2_intermediate & s1;
            5'b00101: ALU_out = s2_intermediate | s1;
            5'b00110: ALU_out = s2_intermediate ^ s1;
            5'b01000: ALU_out = s1 << s2_intermediate;
            5'b01010: ALU_out = s1 >> s2_intermediate;
            5'b01100: ALU_out = s1 >>> s2_intermediate;
            5'b10000: ALU_out = (s1 == s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b10010: ALU_out = (s1 != s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b10100: ALU_out = (s1 < s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b10101: ALU_out = (s1 < s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b10110: ALU_out = (s1 >= s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b10111: ALU_out = (s1 >= s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b11000: ALU_out = (s1 > s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b11001: ALU_out = (s1 > s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b11010: ALU_out = (s1 <= s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            5'b11011: ALU_out = (s1 <= s2_intermediate) ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
        endcase
        
        Zflag_ = (ALU_out == 32'd0);
        
    end
    
endmodule
