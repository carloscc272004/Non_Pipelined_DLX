`timescale 1ns / 1ps


module DLX_IAR(clock, reset, dest_bus, IARoeS1, IARoeS2, IAR_load, s2_bus, s1_bus);

input clock;
input reset;
input[31:0] dest_bus;
input IARoeS1;
input IARoeS2;
input IAR_load;

reg[31:0] IAR_reg;

output[31:0] s2_bus;
output[31:0] s1_bus;

always@(posedge clock or posedge reset)
begin

    if (reset)
        IAR_reg <= 32'b0;
    else if (IAR_load)
        IAR_reg <= dest_bus;
    
end

assign s1_bus = IARoeS1 ? IAR_reg : 32'bz;
assign s2_bus = IARoeS2 ? IAR_reg : 32'bz;

endmodule
