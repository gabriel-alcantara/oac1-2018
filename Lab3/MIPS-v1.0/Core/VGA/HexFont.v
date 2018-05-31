module HexFont (
	input wire [3:0] iNibble,
	input wire [2:0] iLineSelect,
	input wire [2:0] iPixelSelect,
	output reg       oPixel
);

reg [63:0] NibbleBitmap;
reg [ 7:0] NibbleLine;

always @(*) begin
	case (iNibble)
		4'h0: NibbleBitmap = 64'b0000000000111000010001000100110001010100011001000100010000111000;
		4'h1: NibbleBitmap = 64'b0000000000010000001100000001000000010000000100000001000000111000;
		4'h2: NibbleBitmap = 64'b0000000000111000010001000000010000001000000100000010000001111100;
		4'h3: NibbleBitmap = 64'b0000000000111000010001000000010000011000000001000100010000111000;
		4'h4: NibbleBitmap = 64'b0000000000001000000110000010100001001000011111000000100000011100;
		4'h5: NibbleBitmap = 64'b0000000001111100010000000111100000000100000001000100010000111000;
		4'h6: NibbleBitmap = 64'b0000000000111000010000000111100001000100010001000100010000111000;
		4'h7: NibbleBitmap = 64'b0000000001111100000001000000010000001000000100000001000000010000;
		4'h8: NibbleBitmap = 64'b0000000000111000010001000100010000111000010001000100010000111000;
		4'h9: NibbleBitmap = 64'b0000000000111000010001000100010001000100001111000000010000111000;
		4'hA: NibbleBitmap = 64'b0000000000010000001010000010100001000100011111000100010001000100;
		4'hB: NibbleBitmap = 64'b0000000001111000010001000100010001111000010001000100010001111000;
		4'hC: NibbleBitmap = 64'b0000000000111000010001000100000001000000010000000100010000111000;
		4'hD: NibbleBitmap = 64'b0000000001111000010001000100010001000100010001000100010001111000;
		4'hE: NibbleBitmap = 64'b0000000001111100010000000100000001111000010000000100000001111100;
		4'hF: NibbleBitmap = 64'b0000000001111100010000000100000001111000010000000100000001000000;
	endcase
end

always @(*) begin
	case (iLineSelect)
		3'h0: NibbleLine = NibbleBitmap[63:56];
		3'h1: NibbleLine = NibbleBitmap[55:48];
		3'h2: NibbleLine = NibbleBitmap[47:40];
		3'h3: NibbleLine = NibbleBitmap[39:32];
		3'h4: NibbleLine = NibbleBitmap[31:24];
		3'h5: NibbleLine = NibbleBitmap[23:16];
		3'h6: NibbleLine = NibbleBitmap[15: 8];
		3'h7: NibbleLine = NibbleBitmap[ 7: 0];
	endcase
end

	always @(*) begin
		case (iPixelSelect)
		3'h0: oPixel = NibbleLine[7];
		3'h1: oPixel = NibbleLine[6];
		3'h2: oPixel = NibbleLine[5];
		3'h3: oPixel = NibbleLine[4];
		3'h4: oPixel = NibbleLine[3];
		3'h5: oPixel = NibbleLine[2];
		3'h6: oPixel = NibbleLine[1];
		3'h7: oPixel = NibbleLine[0];
		endcase
	end

endmodule
