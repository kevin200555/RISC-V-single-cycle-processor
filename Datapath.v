`timescale 1ns / 1ps

module data_path # (
    parameter PC_W = 8 , // Program Counter
    parameter INS_W = 32 , // Instruction Width
    parameter RF_ADDRESS = 5 , // Register File Address
    parameter DATA_W = 32 , // Data WriteData
    parameter DM_ADDRESS = 9 , // Data Memory Address
    parameter ALU_CC_W = 4 // ALU Control Code Width
    )(
    input clk, // CLK in Datapath figure
    input reset, // Reset in Datapath figure
    input reg_write, // RegWrite in Datapath figure
    input mem2reg, // MemtoReg in Datapath figure
    input alu_src, // ALUSrc in Datapath figure
    input mem_write, // MemWrite in Datapath Figure
    input mem_read, // MemRead in Datapath Figure
    input [ ALU_CC_W -1:0] alu_cc, // ALUCC in Datapath Figure
    output [6:0] opcode, // opcode in Datapath Figure
    output [6:0] funct7, // Funct7 in Datapath Figure
    output [2:0] funct3, // Funct3 in Datapath Figure
    output [DATA_W-1:0] alu_result // Datapath_Result in Datapath Figure
    );
    // Write your code here
    wire [PC_W-1:0] PC;
    wire [PC_W-1:0] PCPlus4;
    wire [INS_W-1:0] Instruction;
    wire [INS_W-1:0] Reg1;
    wire [INS_W-1:0] Reg2;
    wire [INS_W-1:0] SreB;
    wire [INS_W-1:0] ExtImm;
    wire [INS_W-1:0] DataMem_read;
    wire [INS_W-1:0] WriteBack_Data;
    
    wire Carry_Out;
    wire Zero;
    wire Overflow;
    assign PCPlus4 = PC + 4;
    //FlipFlop(clk,reset,d,q)
    FlipFlop FlipFlop_inst(clk, reset,PCPlus4,PC);
    //InstMem(addr,instruction)
    InstMem InstMem_inst(PC,Instruction);
    assign opcode = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign funct7 = Instruction[31:25];
    //RegFile(clk, reset, rg_wrt_en, rg_wrt_addr, rg_rd_addr1,rg_rd_addr2,rg_wrt_data,rg_rd_data1,rg_rd_data2);
    wire [ RF_ADDRESS -1:0] rd_rg_wrt_wire ;
    wire [ RF_ADDRESS -1:0] rd_rg_addr_wire1 ;
    wire [ RF_ADDRESS -1:0] rd_rg_addr_wire2 ;
    assign rd_rg_wrt_wire = Instruction [11:7];
    assign rd_rg_addr_wire1 = Instruction [19:15];
    assign rd_rg_addr_wire2 = Instruction [24:20];
    RegFile RegFile_inst(clk, reset, reg_write, rd_rg_wrt_wire, rd_rg_addr_wire1, rd_rg_addr_wire2, WriteBack_Data, Reg1, Reg2);
    //ImmGen(InstCode, ImmOut);
    ImmGen ImmeGen_inst(Instruction,ExtImm);
    //MUX(D0,D1,S,Y);
    MUX ALU_MUX_inst(Reg2,ExtImm,alu_src,SreB);
    //ALU_32 (A_in, B_in,  ALU_Sel, ALU_Out, Carry_Out, Zero, Overflow)
    ALU ALU_inst(Reg1,SreB,alu_cc,alu_result,Carry_Out,Zero,Overflow);
    //DataMem(MemRead, MemWrite, addr, write_data, read_data);
    DataMem DataMem_inst(mem_read, mem_write, alu_result[8:0], Reg2, DataMem_read);
    //MUX(D0,D1,S,Y);
    MUX DATAMEM_MUX_inst(alu_result,DataMem_read,mem2reg,WriteBack_Data);
endmodule // Datapath