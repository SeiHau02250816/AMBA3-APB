//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_environment
// Module Name: apb_environment
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Enviroment for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_env;
	virtual apb_intf vintf;
	apb_gen apb_gen_h;
	apb_drv apb_drv_h;
	mailbox g2d_mb;
	
	apb_mon apb_mon_h;
	apb_sb  apb_sb_h;
	mailbox m2s_mb;
	
	function new(virtual apb_intf vintf);
		this.vintf = vintf;
		
		g2d_mb = new();
		apb_gen_h = new(g2d_mb);
		apb_drv_h = new(this.vintf, g2d_mb);
		
		m2s_mb = new();
		apb_mon_h = new(this.vintf, m2s_mb);
		apb_sb_h = new(m2s_mb);
	endfunction
	
	task main;
		$display("Task main :: apb_env");
		
		fork 
			apb_gen_h.gen();
			apb_drv_h.drive();
			apb_mon_h.sample();
			apb_sb_h.check();
		join_any
		
		#1500;
		$finish;
	endtask
endclass

