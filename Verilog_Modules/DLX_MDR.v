`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2025 01:47:25 PM
// Design Name: 
// Module Name: DLX_MDR
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


module DLX_MDR(clk,reset,MDRload, MDRoeS2, MemWrite, s2_bus, data_bus, mux_out);

input clk;
input reset;
input MDRload;
input MDRoeS2;
input MemWrite;
input[31:0] mux_out;

output[31:0] s2_bus; 
output[31:0] data_bus;

reg[31:0] MDR_reg;
reg[31:0] s2_bus_reg;

always @(posedge clk or posedge reset)
begin
    if ( reset )
        MDR_reg <= 32'b0;
    else if (MDRload)
        MDR_reg <= mux_out;
        
end

assign s2_bus = MDRoeS2 ? MDR_reg : 32'bz; 
assign data_bus = MemWrite ? MDR_reg : 32'bz;

endmodule
