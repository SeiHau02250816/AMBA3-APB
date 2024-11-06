//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_read_transactions_generator
// Module Name: apb_read_txn_gen
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Generator for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_read_txn_gen extends apb_gen;
	apb_txn read_setup_txn, read_ready_txn, idle_txn;
	
	// Constructor
	function new(mailbox g2d_mb);
		super.new(g2d_mb);
	endfunction
	
	// Override the gen task to create specific transactions
	task gen;
		$display("Task generate :: apb_write_txn_gen");
		
		for (int i=1; i <= 10; i++) begin
            // First transaction: read_setup_txn with psel = 1, penable = 0
            read_setup_txn = new();
            read_setup_txn.randomize() with {
                psel == 1;
                penable == 0;
                pwrite == 0;
                paddr == i;
            };
            g2d_mb.put(read_setup_txn);
            
            // Second transaction: read_ready_txn with psel = 1, penable = 1, and matching other fields
            read_ready_txn = new();
            read_ready_txn = read_setup_txn.clone();  // Copy fields from read_setup_txn
            read_ready_txn.psel = 1;
            read_ready_txn.penable = 1;
            g2d_mb.put(read_ready_txn);
            
            // Third transaction: idle transaction with psel = 0, penable = 0
            idle_txn = new();
            idle_txn.randomize() with {
                psel == 0;
                penable == 0;
            };
            g2d_mb.put(idle_txn);
        end
	endtask
endclass