`timescale 1 ns / 1 ps
module processor(
    input clk , reset ,
    output [31:0] Result
    );
// Define the input and output signals
    wire [2:0] Funct3;
    wire [6:0] Funct7;
    wire [6:0] Opcode;
    wire [1:0] ALUOp;
    wire [3:0] Operation;
    wire MemtoReg, MemWrite, MemRead, ALUSrc, RegWrite;
    data_path datapath(clk, reset, RegWrite, MemtoReg, ALUSrc, MemWrite, MemRead, Operation, Opcode, Funct7, Funct3, Result);
    Controller controller(Opcode,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,ALUOp);
    ALUController ALUController(ALUOp , Funct7 , Funct3 , Operation);

// Define the processor modules behavior
endmodule // processor