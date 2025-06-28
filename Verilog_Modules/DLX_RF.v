`timescale 1ns / 1ps

//module DMUX (REGload, REGselect, C_out, dmux_out);
//    input REGload;
//    input [4:0] REGselect;
//    input [31:0] C_out;
//    output reg [31:0] dmux_out [0:31];

//    integer i;

//    always @(*) begin
//        for (i = 0; i < 32; i = i + 1)
//            dmux_out[i] = 32'b0;

//        if (REGload)
//            dmux_out[REGselect] = C_out;
//    end

//endmodule
module DLX_RF(clock, reset, RegWrite, rs, rt, rd, write_data, a_out, b_out);
    input clock;
    input reset;
    input RegWrite;             
    input [4:0] rs;             
    input [4:0] rt;             
    input [4:0] rd;    
    input [31:0] write_data;    
    output [31:0] a_out;        
    output [31:0] b_out;

    reg [31:0] RF [0:31];
    integer i;
    
    always @(posedge clock or posedge reset) 
    begin
        if (reset) 
        begin
            for (i = 0; i < 32; i = i + 1)
                RF[i] <= 32'b0;
        end 
        else if (RegWrite && rd != 5'd0) begin
            RF[rd] <= write_data; 
        end
    end

    
    assign a_out = RF[rs];
    assign b_out = RF[rt];

endmodule
