`ifndef PARAM
`define PARAM

/* Parametros Gerais*/
parameter
    ON          = 1'b1,
    OFF         = 1'b0,
    ZERO        = 32'h0,

/* Operacoes da ULA */
	 OPAND		= 5'd00000,
	 OPOR 		= 5'b00001,
	 OPXOR 		= 5'b00010,
	 OPADD 		= 5'b00011,
	 OPSUB 		= 5'b00100,
	 OPSLT 		= 5'b00101,
	 OPSLTU 		= 5'b00110,
	 OPGE 		= 5'b00111,
	 OPGEU 		= 5'b01000,
	 OPSLL 		= 5'b01001,
	 OPSRL 		= 5'b01010,
	 OPSRA 		= 5'b01011,
	 OPLUI 		= 5'b01100,
	 OPMUL 		= 5'b01101,
	 OPMULH 		= 5'b01110,
	 OPMULHU 	= 5'b01111,
	 OPMULHSU   = 5'b10000,
	 OPDIV 		= 5'b10001,
	 OPDIVU 		= 5'b10010,
	 OPREM 		= 5'b10011,
	 OPREMU 		= 5'b10100,

/* Campo FUNCT */
	FUNSLL = 10'b0000000001,
    FUNSRL = 10'b0000000101,
    FUNSRA = 10'b0100000101,
    FUNMUL = 10'b0000001000,
    FUNMULH= 10'b0000001001,
    FUNMULHU=10'b0000001011,
    FUNMULHSU=10'b0000001010,
    FUNDIV = 10'b0000001100,
    FUNDIVU= 10'b0000001101,
    FUNADD = 10'b0000000000,
    FUNSUB = 10'b0100000000,
    FUNAND = 10'b0000001111,
    FUNOR  = 10'b0000000110,
    FUNXOR = 10'b0000000100,
    FUNSLT = 10'b0000000100,
    FUNSLTU= 10'b0000000101,
    FUNSLR = 10'b0000000101,
    FUNSLL = 10'b0000000001,
    FUNSRA = 10'b0100000101,
    	
	
	
	
	

/* Campo OPCODE */
	OPMUL   = 7'b0110011,
	// obs: mulhu no riscV
	OPMULHU  = 7'b0110011,
	// obs: no riscV eh a funcao srl
	OPSRLV   = 7'b0110011,
	// obs: eh a funcao sll
	OPSLLV   = 7'b0110011,
	// obs: funcao sra no riscV
	OPSRAV   = 7'b0110011,
	OPCADDI  = 7'b0010011,
	// obs: vou deixar o opocode do addi aqui, pois n achei o opcode de ADDIU no riscV
	OPCADDIU = 7'b0010011,
	OPCSLTI  = 7'b0010011,
	OPCSLTIU = 7'b0010011,
	OPCANDI  = 7'b0010011,
	OPCORI   = 7'b0010011,
	OPCXORI  = 7'b0010011,
	OPCLUI   = 7'b0010011,
	OPCSW    = 7'b0010011,
	OPCSH    = 7'b0100011,
	OPCSB    = 7'b0100011,
	OPCDUMMY = 7'b0000000,
	OPCLW    = 7'b0000011,
	OPCLH    = 7'b0000011,
	OPCLHU   = 7'b0000011,
	OPCLB    = 7'b0000011,
	OPCLBU   = 7'b0000011,
	
	
	
	
	


/* Memory access types ***********************************************************************************************/
    LOAD_TYPE_LW        = 3'b000,
    LOAD_TYPE_LH        = 3'b001,
    LOAD_TYPE_LHU       = 3'b010,
    LOAD_TYPE_LB        = 3'b011,
    LOAD_TYPE_LBU       = 3'b100,
    LOAD_TYPE_DUMMY     = 3'b111,

    STORE_TYPE_SW       = 2'b00,
    STORE_TYPE_SH       = 2'b01,
    STORE_TYPE_SB       = 2'b10,
    STORE_TYPE_DUMMY    = 2'b11,


/* ADDRESS MACROS *****************************************************************************************************/

    BACKGROUND_IMAGE    = "display.mif",

	 BEGINNING_BOOT      = 32'h0000_0000,
	 BOOT_WIDTH				= 9,					// 128 words = 128x4 = 512 bytes
    END_BOOT            = (BEGINNING_BOOT + 2**BOOT_WIDTH) - 1,	 
//    END_BOOT            = 32'h000001FF,	// 128 words

    BEGINNING_TEXT      = 32'h0040_0000,
	 TEXT_WIDTH				= 14,					// 4096 words = 4096x4 = 16384 bytes
    END_TEXT            = (BEGINNING_TEXT + 2**TEXT_WIDTH) - 1,	 
//    END_TEXT            = 32'h00403FFF,	// 4096 words

	 
    BEGINNING_DATA      = 32'h1001_0000,
	 DATA_WIDTH				= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_DATA            = (BEGINNING_DATA + 2**DATA_WIDTH) - 1,	 
//    END_DATA            = 32'h10011FFF,	// 2048 words


	 STACK_ADDRESS       = END_DATA-3,


    BEGINNING_KTEXT     = 32'h8000_0000,
	 KTEXT_WIDTH			= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_KTEXT           = (BEGINNING_KTEXT + 2**KTEXT_WIDTH) - 1,	 	 
//    END_KTEXT           = 32'h80001FFF,	// 2048 words
	 
    BEGINNING_KDATA     = 32'h9000_0000,
	 KDATA_WIDTH			= 12,					// 1024 words = 1024x4 = 4096 bytes
    END_KDATA           = (BEGINNING_KDATA + 2**KDATA_WIDTH) - 1,	 	 
//    END_KDATA           = 32'h900007FF, 	// 1024 words

	 
    BEGINNING_IODEVICES         = 32'hFF00_0000,
	 
    BEGINNING_VGA               = 32'hFF00_0000,
    END_VGA                     = 32'hFF01_2C00,  // 320 x 240 = 76800 bytes

	 KDMMIO_CTRL_ADDRESS		     = 32'hFF20_0000,	// Para compatibilizar com o KDMMIO
	 KDMMIO_DATA_ADDRESS		  	  = 32'hFF20_0004,
	 
	 BUFFER0_TECLADO_ADDRESS     = 32'hFF20_0100,
    BUFFER1_TECLADO_ADDRESS     = 32'hFF20_0104,
	 
    TECLADOxMOUSE_ADDRESS       = 32'hFF20_0110,
    BUFFERMOUSE_ADDRESS         = 32'hFF20_0114,
	  
	 AUDIO_INL_ADDRESS           = 32'hFF20_0160,
    AUDIO_INR_ADDRESS           = 32'hFF20_0164,
    AUDIO_OUTL_ADDRESS          = 32'hFF20_0168,
    AUDIO_OUTR_ADDRESS          = 32'hFF20_016C,
    AUDIO_CTRL1_ADDRESS         = 32'hFF20_0170,
    AUDIO_CRTL2_ADDRESS         = 32'hFF20_0174,

    NOTE_SYSCALL_ADDRESS        = 32'hFF20_0178,
    NOTE_CLOCK                  = 32'hFF20_017C,
    NOTE_MELODY                 = 32'hFF20_0180,
    MUSIC_TEMPO_ADDRESS         = 32'hFF20_0184,
    MUSIC_ADDRESS               = 32'hFF20_0188,         // Endereco para uso do Controlador do sintetizador
    PAUSE_ADDRESS               = 32'hFF20_018C,
		
	 IRDA_DECODER_ADDRESS		 = 32'hFF20_0500,
	 IRDA_CONTROL_ADDRESS       = 32'hFF20_0504, 	 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
	 IRDA_READ_ADDRESS          = 32'hFF20_0508,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    IRDA_WRITE_ADDRESS         = 32'hFF20_050C,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    
	 STOPWATCH_ADDRESS			 = 32'hFF20_0510,	 //Feito em 2/2016 para servir de cronometro
	 
	 LFSR_ADDRESS					 = 32'hFF20_0514,			// Gerador de numeros aleatorios
	 
	 KEYMAP0_ADDRESS				 = 32'hFF20_0520,			// Mapa do teclado 2017/2
	 KEYMAP1_ADDRESS				 = 32'hFF20_0524,
	 KEYMAP2_ADDRESS				 = 32'hFF20_0528,
	 KEYMAP3_ADDRESS				 = 32'hFF20_052C,
	 
	 BREAK_ADDRESS					 = 32'hFF20_0600,  	  // Buffer do endereço do Break Point
	 
	 
/* STATES ************************************************************************************************************/

	  FETCH 		= 6'd0,
	  DECODE 	= 6'd1,
	  ERRO      = 6'd63;  // Estado de Erro
	  
`endif