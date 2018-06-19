`ifndef PARAM
	`include "../Parametros.v"
`endif

/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire 				iCLK, iRST,
	input wire 	[6:0] 	iOp, iFunct7,
	input wire  [2:0]		iFunct3,
	output wire 			oIRWrite, oMemtoReg, oMemWrite, oMemRead, oIorD, 
								oPCWrite, oPCWriteBEQ, oPCWriteBNE,oRegWrite, 
	output wire [1:0] 	oALUOp, oALUSrcA,
	output wire [2:0] 	oALUSrcB, oPCSource, oStore,
	output wire [5:0] 	oState,
	output wire [2:0] 	oLoadCase,
	output wire [1:0] 	oWriteCase
	);


logic	[40:0] 	word;				// sinais de controle do caminho de dados
reg 	[5:0] 	pr_state;		// present state
logic [5:0] 	nx_state;		// next state

assign	oWriteCase 			= word[39:38];
assign	oLoadCase		 	= word[37:35];
assign	oStore				= word[22:20];
assign	oPCWrite			= word[19];
assign	oPCWriteBNE			= word[18];
assign	oPCWriteBEQ			= word[17];
assign	oIorD				= word[16];
assign	oMemRead			= word[15];
assign	oMemWrite			= word[14];
assign	oIRWrite			= word[13];
assign	oMemtoReg			= word[12];
assign	oPCSource			= word[11:9];
assign	oALUOp				= word[8:7];
assign	oALUSrcB			= word[6:4];
assign	oALUSrcA			= word[3:2];
assign	oRegWrite			= word[1];

assign	oState		= pr_state;


initial
begin
	pr_state	<= FETCH;
end



/* Main control block */
always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		pr_state	<= FETCH;
	else
		pr_state	<= nx_state;
end



always @(*)
begin
	
	case (pr_state)
	
		FETCH:
		begin
			word		<= 41'b00000000000000000000010001010000000010000;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			word		<= 41'b00000000000000000000000000000000000110000;
			case (iOp)
				TYPER: // instruçoes tipo R
					case (iFunct3)
						3'h0:
							case(iFunct7)
								FUN7ADD:
									word   <= 41'b00000000000000000000000000000000000000000;
								FUN7SUB:
									word   <=  41'b00000000000000000000000000000000001000000;
							endcase
					default:
								word  <= 41'b00000000000000000000000000000000010000000;
					endcase
				TYPELOAD: // acesso de memoria
					word <= 41'b00000000000000000000000000000000000000000;
				TYPESTORE: // acesso de memoria
					word <= 41'b00000000000000000000000000000000000000000;
				TYPECOND: // devios condicionais
					word <= 41'b00000000000000000000000000000001001000000;
				OPCJAL: // devios incodicionais
					word <= 41'b00000000000000000000000000001001000000000;
				OPCJALR: // devios incodionais
					word <= 41'b00000000000000000000000000001001000000000;
				TYPEI: // instrucoes tipo I
				  case(iFunct3)
				  	3'b001:
					  word <= 41'b00000000000000000000000000000000000000000;
					default:
						word  <= 41'b00000000000000000000000000000000010000000;
				
				endcase
			endcase	
			nx_state <= FETCH;
		end	
						
		ERRO:
		begin
			word  	<= 41'b00000000000000000000000000000000000000001;
			nx_state	<= ERRO;
		end

		default:
		begin
			word		<= 41'b0;
			nx_state	<= ERRO;
		end
		
	endcase
end

endmodule
