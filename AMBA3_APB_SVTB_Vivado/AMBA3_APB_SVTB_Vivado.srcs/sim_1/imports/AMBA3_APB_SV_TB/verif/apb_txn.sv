//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_transaction_class
// Module Name: apb_txn
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: APB transaction class for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_txn;
	rand logic 			penable;
	rand logic 			psel;
	rand logic         	pwrite;
	rand logic[31:0] 	pwdata;
	rand logic[31:0]	paddr;
	
	logic 				pready;
	logic 				pslverr;
	logic [31:0]        prdata;
	
	// Constraints (if any)
//    constraint valid_addr {
//        paddr inside {32'h0000_0000 : 32'h0000_FFFF};
//    }
	
	// Pre & post randomization definition
	function apb_txn clone();
		apb_txn new_txn = new();
		
		new_txn.psel = this.psel;
		new_txn.penable = this.penable;
		new_txn.pwrite = this.pwrite;
		new_txn.pwdata = this.pwdata;
		new_txn.paddr = this.paddr;
		new_txn.pready = this.pready;
		new_txn.pslverr = this.pslverr;
		new_txn.prdata = this.prdata;
		
		return new_txn;
	endfunction
endclass