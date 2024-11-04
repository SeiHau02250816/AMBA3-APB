//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_intf
// Module Name: apb_intf
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Interface for AMBA3 APB TB
// 
//////////////////////////////////////////////////////////////////////////////////

interface apb_intf(
	input logic pclk,
	input logic presetn
);
	logic penable;
	logic psel;
	logic pwrite;
	logic [31 : 0] pwdata;
	logic [31 : 0] prdata;
	logic [31 : 0] paddr;
	logic pready;
	logic pslverr;
	
	clocking drv_cb @(posedge pclk);
		default input #1 output #1;
		
		output penable;
		output psel;
		output pwrite;
		output pwdata;
		output paddr;
		
		input pready;
	endclocking
	
	clocking mon_cb @(posedge pclk);
		default input #2 output #1;  // Adding #2 delay for inputs to ensure stability
		
		input penable;
		input psel;
		input pwrite;
		input pwdata;
		input prdata;
		input paddr;
		input pready;
		input pslverr;
	endclocking
	
	modport drv_mp(input pclk, input presetn, clocking drv_cb);
	modport mon_mp(input pclk, input presetn, clocking mon_cb);
	
endinterface