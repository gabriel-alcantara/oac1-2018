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
                FUNMULT:
                    oControlSignal  = OPMULT;
                FUNDIV:
                    oControlSignal  = OPDIV;
                FUNMULTU:
                    oControlSignal  = OPMULTU;
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
                    oControlSignal  = OPSRLV;
                FUNSLL:
                    oControlSignal  = OPSLLV;
                FUNSRA:
                    oControlSignal  = OPSRAV;
                default:
                    oControlSignal  = 5'b00000;
            endcase
        end
        2'b11:
            case (iFunct3)
                OPCADDI:
                    oControlSignal  = OPADD;
                OPCADDIU:
                    oControlSignal  = OPADD;
                OPCSLTI:
                    oControlSignal  = OPSLT;
                OPCSLTIU:
                    oControlSignal  = OPSLTU;
                OPCANDI:
                    oControlSignal  = OPAND;
                OPCORI:
                    oControlSignal  = OPOR;
                OPCXORI:
                    oControlSignal  = OPXOR;
                OPCLUI:
                    oControlSignal  = OPLUI;
                default:
                    oControlSignal  = 5'b00000;
            endcase
    endcase
end

endmodule
