//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_scoreboard
// Module Name: apb_sb
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Scoreboard for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_sb;
	mailbox m2s_mb;
	
	logic [31 : 0] mem[logic [31 : 0]];
	logic [31 : 0] rdata;
	apb_txn txn_h;
	
	function new(mailbox m2s_mb);
		this.m2s_mb = m2s_mb;
	endfunction
	
	task check;
		forever begin
			$display($time, ": Task check :: apb_sb");
			m2s_mb.get(txn_h);
			
			ref_model();
			compare();
		end
	endtask
	
	task ref_model;
		if (txn_h.psel && txn_h.pwrite && txn_h.penable && txn_h.pready)
			mem[txn_h.paddr] = txn_h.pwdata;
		
		if (txn_h.psel && !txn_h.pwrite && txn_h.penable && txn_h.pready)
			rdata = mem[txn_h.paddr];
	endtask
	
	task compare();
		if (txn_h.psel && !txn_h.pwrite && txn_h.penable && txn_h.pready) begin
			if (rdata == txn_h.prdata)
				$display($time, "[SCB-PASS] addr = %0h, \t expected data = %0h, actual data = %0h", txn_h.paddr, rdata, txn_h.prdata);
			else
				$error($time, "[SCB-FAIL] addr = %0h, \t expected data = %0h, actual data = %0h", txn_h.paddr, rdata, txn_h.prdata);
		end
	endtask
endclass