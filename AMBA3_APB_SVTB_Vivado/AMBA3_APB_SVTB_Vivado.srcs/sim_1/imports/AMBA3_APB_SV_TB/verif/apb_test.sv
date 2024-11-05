//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_test
// Module Name: apb_test
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Test for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_test;
	virtual apb_intf vintf;
	apb_env apb_env_h;
	int num_txns;

	function new(virtual apb_intf vintf, int num_txns = 10);
		this.vintf = vintf;
		this.num_txns = num_txns;
		apb_env_h = new(this.vintf, this.num_txns);
	endfunction
	
	task main;
		$display("Task main :: apb_test with %0d transactions", num_txns);
		apb_env_h.main();
	endtask
endclass