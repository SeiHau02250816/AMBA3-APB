//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_tb_top
// Module Name: tb_top
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: TB top for AMBA3 APB 
// 
//////////////////////////////////////////////////////////////////////////////////
`include "apb_txn.sv"
`include "apb_test.sv"
`include "apb_env.sv"
`include "apb_drv.sv"
`include "apb_gen.sv"
`include "apb_write_txn_gen.sv"
`include "apb_mon.sv"
`include "apb_sb.sv"


module tb_top();
	logic pclk, presetn;
	apb_test apb_test_h;
	
	// Interface instantiation
	apb_intf intf(pclk, presetn);
	
	// DUT instantiation
	apb_rtl dut (
		.clk 		(intf.pclk),
		.rst 		(intf.presetn),
		.psel		(intf.psel),
		.penable	(intf.penable),
		.pwrite 	(intf.pwrite),
		.pready		(intf.pready),
		.pwdata		(intf.pwdata),
		.paddr		(intf.paddr),
		.prdata		(intf.prdata),
		.pslverr	(intf.pslverr)
	);
	
	// Clock generation
	always #5 pclk = ~pclk;
	
	// Reset generation
	initial begin
		presetn = 0;
		#30 presetn = 1;
	end
	
	// Test instantiation
	initial begin
	    pclk = 0;
	    
		apb_test_h = new(intf, 10);
		apb_test_h.main();
	end
endmodule