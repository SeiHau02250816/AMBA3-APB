//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_driver
// Module Name: apb_drv
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Driver for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_drv;
	virtual apb_intf vintf;
	
	mailbox g2d_mb; // Generator to driver mailbox
	apb_txn txn_h;
	
	function new (virtual apb_intf vintf, mailbox g2d_mb);
		this.vintf = vintf;
		this.g2d_mb = g2d_mb;
	endfunction
	
	task drive;
		forever begin
			$display("Task drive :: apb_drv");
			
			@(vintf.drv_cb);
			g2d_mb.get(txn_h);
			$display("txn values :: driver = %p", txn_h);
			
			apb_drive();
		end
	endtask
	
	task apb_drive();
        vintf.paddr <= txn_h.paddr;
        vintf.psel <= txn_h.psel;
        vintf.pwrite <= txn_h.pwrite;
        vintf.pwdata <= txn_h.pwdata;
            
        vintf.penable <= txn_h.penable;
        wait(vintf.pready);
	endtask
endclass