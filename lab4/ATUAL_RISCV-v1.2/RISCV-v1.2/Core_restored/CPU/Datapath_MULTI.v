
`ifndef PARAM
	`include "../Parametros.v"
`endif

/*
 * Caminho de Dados do Processador MIPS Multiciclo
 *
 */

module Datapath_MULTI (
// Inputs e clocks
input  wire 			iCLK, iCLK50, iRST,
input  wire [31:0] 	iInitialPC,

// Para monitoramento
input  wire [4:0] 	iRegDispSelect,
output wire [31:0] 	oPC, oDebug, oInstr, oRegDisp,
input  wire	[4:0] 	wVGASelect,
output wire [31:0] 	wVGARead,
output wire [1:0] 	oALUOp, oALUSrcA,
output wire [2:0] 	oALUSrcB, oPCSource,
output wire 			oIRWrite, oIorD, oPCWrite, oRegWrite,
output wire [5:0] 	owControlState,
output wire [31:0] 	wBRReadA,
output wire [31:0] 	wBRReadB,
output wire [31:0] 	wBRWrite,
output wire [31:0] 	wULA,	 


//Barramento
output wire [31:0] DwAddress, DwWriteData,
input  wire	[31:0] DwReadData,
output wire DwWriteEnable, DwReadEnable,
output wire [3:0] DwByteEnable

);



	
/* ****************************************************** */
/* Definicao dos fios e registradores							 */
reg [31:0] PC,PCBack;
reg [31:0] A, B, MDR, IR, ALUOut;

wire [6:0]wOPcode;
wire [5:0] wRS1,wRS2,wRD
wire IRwrite,MemRead,RegWrite,IouD,MemWrite,PCWrite,PcWriteCond,OrigPC,OrigBULA,PCWriteBEQ, PCWriteBNE,
wALUZero,wALUOverflow;
wire [1:0] ALUOp;
wire [4:0] wALUControlSignal;
wire [31:0] wALUMuxA, wALUMuxB, wALUResult, wImmediateGerador, wImmediateDescMux,wImmediateMux,
				wReadData1, wReadData2, wRegWriteData, wMemorALU, wMemWriteData, 
				wMemReadData, wMemAddress, wPCMux, wJalAddress;
wire [9:0] wControlULA;





/* ****************************************************** */
/* Inicializacao dos registradores		  						 */



initial
begin
	PC			<= BEGINNING_TEXT;
	IR			<= 32'b0;
	ALUOut	<= 32'b0;
	MDR 		<= 32'b0;
	A 			<= 32'b0;
	B 			<= 32'b0;
end


 
/* ****************************************************** */
/* Definicao das estruturas assign		  						 */
assign wBRReadA		= wReadData1;
assign wBRReadB		= wReadData2;
assign wBRWrite		= wTreatedToRegister;
assign wULA				= wALUResult;
assign wOpCode  = IR[6:0];
assign wRS1     = IR[19:15];
assign wRS2     = IR[24:20];
assign wRD      = IR[11:7];
assign wControlULA = {IR[31:25],IR[14:12]};
assign wImmediateGerador = IR[31:0]
assign wImmediateDescMux = {IR[30:0],1b'0}
assign wImmediateMux = wImmediateGerador[31:0]

/* Output wires */
assign oPC			= PC;
assign oALUOp		= ALUOp;
assign oPCSource	= PCSource;
assign oIRWrite	= IRWrite;
assign oIorD		= IorD;
assign oPCWrite	= PCWrite;
assign oALUSrcA	= ALUSrcA;
assign oRegWrite	= RegWrite;
assign oRegDst		= RegDst;
assign oInstr 		= IR;
assign oALUSrcB	= ALUSrcB;
assign oALUSrcA	= ALUSrcA;




/* ****************************************************** */
/* Instanciacao das estruturas 	 		  						 */


Control_MULTI CrlMULTI (
	.iCLK(iCLK),
	.iRST(iRST),
	.iOp(wOpcode),
	.iFunct3(wFunct3),
	.iFunct7(wFunct7),
	.oIRWrite(IRWrite),
	.oMemtoReg(MemtoReg),
	.oMemWrite(MemWrite),
	.oMemRead(MemRead),
	.oIorD(IorD),
	.oPCWrite(PCWrite),
	.oPCWriteBEQ(PCWriteBEQ),
	.oPCWriteBNE(PCWriteBNE),
	.oPCSource(PCSource),
	.oALUOp(ALUOp),
	.oALUSrcB(ALUSrcB),
	.oALUSrcA(ALUSrcA),
	.oRegWrite(RegWrite),
	.oState(owControlState),
	.oStore(Store),
	.oLoadCase(wLoadCase),
	.oWriteCase(wWriteCase),
	);

/* Register bank module */
Registers RegsMULTI (
	.iCLK(iCLK),
	.iCLR(iRST),
	.iReadRegister1(wRs1),
	.iReadRegister2(wRs2),
	.iWriteRegister(wWriteRegister),
	.iWriteData(wTreatedToRegister),
	.iRegWrite(RegWrite),
	.oReadData1(wReadData1),
	.oReadData2(wReadData2),
	.iRegDispSelect(iRegDispSelect),
	.oRegDisp(oRegDisp),
	.iVGASelect(wVGASelect),
	.oVGARead(wVGARead)
	);


/* Arithmetic Logic Unit module */
ALU ALU0 (
	.iCLK(iCLK),
	.iRST(iRST),
	.iA(wALUMuxA),
	.iB(wALUMuxB),
	.iControlSignal(wALUControlSignal),
	.oZero(wALUZero),
	.oALUresult(wALUResult),
	);

/* Arithmetic Logic Unit control module */
ALUControl ALUcont0 (
	.iFunct3(wFunct3),
	.iFunct7(wFunct7),
	.iOpcode(wOpcode),
	.iALUOp(ALUOp),
	.oControlSignal(wALUControlSignal)
	);




MemStore MemStore0 (
	.iAlignment(wMemAddress[1:0]),
	.iWriteTypeF(wWriteCase),
	.iOpcode(wOpcode),
	.iData(wMemWriteData),
	.oData(wTreatedToMemory),
	.oByteEnable(wByteEnabler),
	.oException()
	);


/* RAM Memory bus module */

assign DwAddress 		= wMemAddress;
assign DwWriteData 	= wTreatedToMemory;
assign wMemReadData 	= DwReadData;
assign DwWriteEnable = MemWrite;
assign DwReadEnable 	= MemRead;
assign DwByteEnable 	= wByteEnabler;


MemLoad MemLoad0 (
	.iAlignment(wLigaULA_PASSADA),
	.iLoadTypeF(wLoadCase),
	.iOpcode(OPCDUMMY),
	.iData(wRegWriteData),
	.oData(wTreatedToRegister),
	.oException()
	);




/* ****************************************************** */
/* multiplexadores							  						 */



// Mux WriteData
always @(*)
	case (Store)
		3'd0: wRegWriteData <= wMemorALU;
		3'd1: wRegWriteData <= PC;
		default: wRegWriteData <= ZERO;
	endcase


// Mux ALU input 'A'
always @(*)
	case (ALUSrcA)
		2'd0: wALUMuxA <= PC;
		2'd1: wALUMuxA <= A;
		default: wALUMuxA <= 32'd0;
	endcase


// Mux ALU input 'B'
always @(*)
	case (ALUSrcB)
		3'd0: wALUMuxB <= B;
		3'd1: wALUMuxB <= 32'h4;
		3'd2: wALUMuxB <= wImmediate;
		3'd3: wALUMuxB <= {wImmediate[30:0],1'b0};
		default: wALUMuxB <= 32'd0;
	endcase



// Mux OrigPC
always @(*)
	case (PCSource)
		3'd0: wPCMux <= wALUResult;		
		3'd1: wPCMux <= ALUOut;				 
		3'd2: wPCMux <= wJalAddress;		
		3'd3: wPCMux <= wALUResult & ~(32'h1);					
		default: wPCMux <= 32'd0;
	endcase




/* ****************************************************** */
/* A cada ciclo de clock					  						 */

always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
	begin
		PC			<= iInitialPC;
		IR			<= 32'b0;
		ALUOut	<= 32'b0;
		MDR 		<= 32'b0;
		A 			<= 32'b0;
		B 			<= 32'b0;
	end
	else
	begin
		/* Unconditional */
		ALUOut	<= wALUResult;
		A			<= wReadData1;
		B			<= wReadData2;
		MDR		<= wMemReadData;

		/* Conditional */
		if (PCWrite || (PCWriteBEQ && wALUZero) || (PCWriteBNE && ~wALUZero))
			PC	<= wPCMux;

		if (IRWrite)
			IR	<= wMemReadData;

	end
end



endmodule
