`timescale 1 ns / 1 ps
// Module definition
module DataMem(MemRead, MemWrite, addr, write_data, read_data);

    input MemRead; //read enable signal,
    input MemWrite; //write enable signal
    input [8:0] addr;
    input [31:0] write_data;
    output reg [31:0] read_data;
    // Define I / O ports
    // Describe data_mem behavior
    reg [31:0] data_mem [127:0];
    always @ (*)
    begin
        if(MemRead)
            read_data = data_mem[addr[8:2]];
        else if(MemWrite)
            data_mem[addr[8:2]] = write_data;
    end
endmodule // data_mem