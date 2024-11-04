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
	
	function new(virtual apb_intf vintf);
		this.vintf = vintf;
		apb_env_h = new(this.vintf);
	endfunction
	
	task main;
		$display("Task main :: apb_test");
		apb_env_h.main();
	endtask
endclass