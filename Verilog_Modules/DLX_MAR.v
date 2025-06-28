`timescale 1ns / 1ps


module DLX_MAR(clk,reset,MARload, dest_bus, PCMARSelect_in);

input clk;
input reset;
input MARload;
input[31:0] dest_bus;

output[31:0] PCMARSelect_in;

reg[31:0] MAR_reg;

always @(posedge clk or posedge reset)
begin
    if ( reset )
        MAR_reg <= 32'b0;
    else if (MARload)
        MAR_reg <= dest_bus;
        
end

assign PCMARSelect_in = MAR_reg;

endmodule
