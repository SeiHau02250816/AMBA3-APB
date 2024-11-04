//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_rtl
// Module Name: apb_rtl
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: RTL Design for AMBA3 APB 
// 
//////////////////////////////////////////////////////////////////////////////////

module apb_rtl #(
	parameter DATA_WIDTH = 32, 
	parameter ADDR_WIDTH = 32
) (
	input logic clk, 
	input logic rst,
	input logic psel,
	input logic penable,
	input logic pwrite,
	input logic[DATA_WIDTH - 1 : 0] pwdata,
	input logic[ADDR_WIDTH - 1 : 0] paddr,
	
	output logic pready,
	output logic pslverr,
	output logic [DATA_WIDTH - 1 : 0] prdata
);
	
	// Internal variables declaration
	typedef enum logic[1:0] {
		IDLE 	= 2'b00,
		SETUP	= 2'b10,
		ACCESS	= 2'b11
	} state_t;
	
	state_t pstate, nstate;
	logic[DATA_WIDTH - 1 : 0] mem[0 : 2 ** 10 - 1];
	
	// clocking process
	always @(posedge clk) begin
		if (!rst)
			pstate <= IDLE;
		else
			pstate <= nstate;
	end
	
	// FSM
	always_comb begin
		case (pstate)
			IDLE: begin
				if (psel == 1 && penable == 0) begin
					nstate = SETUP;
					pready = 1;
					pslverr = 0;
				end 
				else begin
				    nstate = IDLE;
					pready = 1;
					pslverr = 0;
				end
			end
			
			SETUP: begin
				if (psel == 1 && penable == 1) begin
					nstate = ACCESS;
					pready = 1;
					pslverr = 0;
				end
				else if (psel == 1 && penable == 0) begin
				    nstate = SETUP;
					pready = 1;
					pslverr = 0;
				end
			end
			
			ACCESS: begin
				if (psel == 1 && penable == 1) begin
				    nstate = ACCESS;
					pready = 1;
					pslverr = 0;
				end
				else if (psel == 1 && penable == 0) begin
					nstate = SETUP;
					pready = 1;
					pslverr = 0;
				end
				else if (psel == 0 && penable == 0) begin
					nstate = IDLE;
					pready = 0;
					pslverr = 0;
				end
			end
		endcase
	end
	
	always_comb begin
        if (!rst)
           prdata <= 32'b0;
        else if (pstate == ACCESS && pwrite && pready) 
           mem[paddr] <= pwdata;
        else if (pstate == ACCESS && !pwrite && pready)
           prdata <= mem[paddr];
	end
	
endmodule