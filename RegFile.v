`timescale 1ns / 1ps

// Module definition
module RegFile(
    clk, reset, rg_wrt_en,
    rg_wrt_addr,
    rg_rd_addr1,
    rg_rd_addr2,
    rg_wrt_data,
    rg_rd_data1,
    rg_rd_data2
);
input clk, reset, rg_wrt_en;
input [4:0] rg_wrt_addr;
input [4:0] rg_rd_addr1;
input [4:0] rg_rd_addr2;
input [31:0] rg_wrt_data;
output reg [31:0] rg_rd_data1;
output reg [31:0] rg_rd_data2;

reg [31:0] register [31:0]; 

integer i;
always @ (*)
begin
    if(reset == 1)
        for(i = 0; i < 32; i = i + 1)
            register[i] = 0;
    rg_rd_data1 <= register[rg_rd_addr1];
    rg_rd_data2 <= register[rg_rd_addr2];
end

always @ (posedge clk)
begin
    if(reset == 0 && rg_wrt_en == 1)
        register[rg_wrt_addr] <= rg_wrt_data;
end
endmodule