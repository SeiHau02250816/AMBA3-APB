//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_generator
// Module Name: apb_gen
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Generator for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_gen;
	apb_txn txn_h;
	mailbox g2d_mb;
	
	function new(mailbox g2d_mb);
		this.g2d_mb = g2d_mb;
	endfunction
	
	task gen;
	    #30;
		$display($time, ", Task generate :: apb_gen");
		
		repeat(10) begin
			txn_h = new();
			txn_h.randomize();
			g2d_mb.put(txn_h);
		end
	endtask
endclass