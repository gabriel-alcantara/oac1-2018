`ifndef PARAM
	`include "../Parametros.v"
`endif

/*
 * ALUcontrol.v
 *
 * Arithmetic Logic Unit control module.
 * Generates control signal to the ALU depending on the opcode and the funct field in the
 * current operation and on the signal sent by the processor control module.
 *
 * ALUOp    |    Control signal
 * -------------------------------------------
 * 00        |    The ALU performs an add operation.
 * 01        |    The ALU performs a subtract operation.
 * 10        |    The {funct7,func3} field determines the ALU operation.
 * 11        |    The funct3 field determines the ALU operation.
 */

module ALUControl (
	input wire [6:0] iFunct7, iOpcode,
	input wire [2:0] iFunct3,	
	input wire [1:0] iALUOp,
	output reg [4:0] oControlSignal
	); 
	
always @(*)
begin
    case (iALUOp)
        2'b00:
            oControlSignal  = OPADD;
        2'b01:
            oControlSignal  = OPSUB;
        2'b10:
        begin
            case ({iFunct7,iFunct3})
                FUNSLL:
                    oControlSignal  = OPSLL;
                FUNSRL:
                    oControlSignal  = OPSRL;
                FUNSRA:
                    oControlSignal  = OPSRA;
                FUNMUL:
                    oControlSignal  = OPMUL;
				FUNMULH:
					oControlSignal = OPMULH;
				FUNMULHSU:
					oControlSignal = OPMULHSU;
                FUNDIV:
                    oControlSignal  = OPDIV;
                FUNMULHU:
                    oControlSignal  = OPMULHU;
                FUNDIVU:
                    oControlSignal  = OPDIVU;
                FUNADD:
                    oControlSignal  = OPADD;
                FUNSUB:
                    oControlSignal  = OPSUB;
                FUNAND:
                    oControlSignal  = OPAND;
                FUNOR:
                    oControlSignal  = OPOR;
                FUNXOR:
                    oControlSignal  = OPXOR;
                FUNSLT:
                    oControlSignal  = OPSLT;
                FUNSLTU:
                    oControlSignal  = OPSLTU;
                FUNSRL:
                    oControlSignal  = OPSRL;
                FUNSLL:
                    oControlSignal  = OPSLL;
                FUNSRA:
                    oControlSignal  = OPSRA;
                default:
                    oControlSignal  = 5'b00000;
            endcase
        end
        2'b11:
            case (iFunct3)
                FUN3ADDI:
                    oControlSignal  = OPADD;
                FUN3SLTI:
                    oControlSignal  = OPSLT;
                FUN3SLTIU:
                    oControlSignal  = OPSLTU;
                FUN3ANDI:
                    oControlSignal  = OPAND;
                FUN3ORI:
                    oControlSignal  = OPOR;
                FUN3XORI:
                    oControlSignal  = OPXOR;
                default:
                    oControlSignal  = 5'b00000;
            endcase
    endcase
end

endmodule
