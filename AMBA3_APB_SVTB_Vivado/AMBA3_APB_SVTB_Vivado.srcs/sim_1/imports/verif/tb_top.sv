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
// Revision 1.10 - More tests added
// Additional Comments: TB top for AMBA3 APB 
// 
//////////////////////////////////////////////////////////////////////////////////
`include "apb_txn.sv"
`include "tests/single_write_single_read_test.sv"
`include "tests/consecutive_mult_write_mult_read_test.sv"
`include "tests/non_consecutive_mult_write_mult_read_test.sv"
`include "apb_env.sv"
`include "apb_drv.sv"
`include "apb_gen.sv"
`include "apb_mon.sv"
`include "apb_sb.sv"


module tb_top();
	single_write_single_read_test              test_01_h;
	consecutive_mult_write_mult_read_test      test_02_h;
	non_consecutive_mult_write_mult_read_test  test_03_h;
	
	logic pclk, presetn;
	
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
	    
//	    test_01_h = new(intf);
//	    test_01_h.main();
	    
//	    test_02_h = new(intf);
//	    test_02_h.main();
	    
	    test_03_h = new(intf);
	    test_03_h.main();
	end
endmodule