`timescale 1ns / 1ps

module PC(clk,reset,PCoeS1,PCload, addr_bus, s1_bus);
    input clk;
    input reset;
    input PCoeS1;
    input PCload;
    
    input[31:0] addr_bus;
    output[31:0] s1_bus;
    
    reg[31:0] PC_reg;
    
    always@(posedge clk or posedge reset)
    begin
        if (reset)
            PC_reg <= 32'b0;
        else if (PCload)
            PC_reg <= addr_bus;
    end
    
    assign s1_bus = PCoeS1 ? PC_reg : 32'bz;
      
endmodule
