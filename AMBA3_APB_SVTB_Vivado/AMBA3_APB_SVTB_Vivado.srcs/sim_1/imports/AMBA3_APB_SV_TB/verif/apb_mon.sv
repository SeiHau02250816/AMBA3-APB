//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_monitor
// Module Name: apb_mon
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Monitor for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_mon;
	virtual apb_intf vintf;

	mailbox m2s_mb; 	// Monitor to scoreboard mailbox
	apb_txn txn_h;
	
	function new(virtual apb_intf vintf, mailbox m2s_mb);
		this.vintf = vintf;
		this.m2s_mb = m2s_mb;
	endfunction
	
	task sample;
		forever begin
			txn_h = new();
			$display("Task sample :: apb_mon");
			
			@(vintf.mon_cb);
			apb_sample();
		end
	endtask
	
	task apb_sample;
	    if (vintf.psel) begin
            txn_h.paddr = vintf.paddr;
            txn_h.psel = vintf.psel;
            txn_h.penable = vintf.penable;
            txn_h.pwrite = vintf.pwrite;
            txn_h.pwdata = vintf.pwdata;
            txn_h.pready = vintf.pready;
            
            #1;
            txn_h.pslverr = vintf.pslverr;
            txn_h.prdata = vintf.prdata;
            
            m2s_mb.put(txn_h);
        end
	endtask
endclass