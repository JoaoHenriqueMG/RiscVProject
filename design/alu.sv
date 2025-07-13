`timescale 1ns / 1ps

module alu#(
                parameter DATA_WIDTH = 32,
                parameter OPCODE_LENGTH = 4
        )
        (
                input logic [DATA_WIDTH-1:0]    SrcA,
                input logic [DATA_WIDTH-1:0]    SrcB,
                input logic [OPCODE_LENGTH-1:0] Operation,
                output logic[DATA_WIDTH-1:0]    ALUResult
        );
    
        always_comb begin
            case(Operation)
                4'b0000:        // AND, ANDI
                        ALUResult = SrcA & SrcB;
                4'b0001:        // SUB
                        ALUResult = $signed(SrcA) - $signed(SrcB);
                4'b0010:        // ADD, ADDI
                        ALUResult = $signed(SrcA) + $signed(SrcB);
                4'b0011:        // OR, ORI  
                        ALUResult = SrcA | SrcB;
                4'b0100:        // XOR, XORI
                        ALUResult = SrcA ^ SrcB;
                4'b0101:        // SLL, SLLI
                        ALUResult = SrcA << SrcB[4:0];
                4'b0110:        // SRL, SRLI
                        ALUResult = SrcA >> SrcB[4:0]; 
                4'b0111:        // SRA, SRAI
                        ALUResult = $signed(SrcA) >>> SrcB[4:0];
                4'b1000:        // BEQ
                        ALUResult = SrcA == SrcB;
                4'b1001:        // SLT, SLTI
                        ALUResult = $signed(SrcA) < $signed(SrcB);
                4'b1010:        // SLTU, SLTUI
                        ALUResult = SrcA < SrcB;
                4'b1011:        // BNE
                        ALUResult = SrcA != SrcB;
                4'b1100:        // BLT
                        ALUResult = $signed(SrcA) < $signed(SrcB);
                4'b1101:        // BGE
                        ALUResult = $signed(SrcA) >= $signed(SrcB);
                default:
                        ALUResult = 0;
            endcase
        end

endmodule
