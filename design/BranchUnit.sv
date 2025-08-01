`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic Halt,
    input logic Jal,
    input logic Jalr,
    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel,
    output logic JSel
);

  logic Branch_Sel;
  logic [31:0] PC_Full;
  assign PC_Full = {23'b0, Cur_PC};
 
  assign PC_Imm = (Jalr) ? AluResult : (PC_Full + Imm);  // Jalr = 0: AluResult, Jalr = 1: Pc + imm
  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = Branch && AluResult[0];  // 0:Branch is taken; 1:Branch is not taken

  assign BrPC = (Branch_Sel || Jal || Jalr) ? PC_Imm : ((Halt) ? PC_Full : 32'b0);  // Branch || Jal || Jalr -> PC+Imm // Otherwise, Halt -> Pc_Full // else, BrPC not is important
  assign PcSel = Branch_Sel || Halt || Jal || Jalr;  // 1:branch is taken; 0:branch is not taken(choose pc+4)
  assign JSel = (Jal || Jalr);  // 1: PC_four is write in memory register, 0: Alu_Result or MenReadData value

endmodule