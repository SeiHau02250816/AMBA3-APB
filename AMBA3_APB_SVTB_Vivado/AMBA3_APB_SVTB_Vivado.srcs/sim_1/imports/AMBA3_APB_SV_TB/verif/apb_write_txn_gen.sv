//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: apb_write_transactions_generator
// Module Name: apb_write_txn_gen
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Generator for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_write_txn_gen extends apb_gen;
	apb_txn write_setup_txn, write_ready_txn, idle_txn;
	apb_txn read_setup_txn, read_ready_txn;
	int num_txns;

	// Constructor
	function new(mailbox g2d_mb, int num_txns = 1);
		super.new(g2d_mb);
		this.num_txns = num_txns;
	endfunction
	
	// Override the gen task to create specific transactions
	task gen;
		#30;
		$display("Task generate :: apb_write_txn_gen with %0d transactions", num_txns);
		
		idle_txn = new();
		idle_txn.randomize() with {
			psel == 0;
			penable == 0;
		};
		g2d_mb.put(idle_txn);
		
		for (int i = 1; i <= num_txns; i++) begin
			// Write transactions
			write_setup_txn = new();
			write_setup_txn.randomize() with {
				psel == 1;
				penable == 0;
				pwrite == 1;
				paddr == i;
			};
			g2d_mb.put(write_setup_txn);

			write_ready_txn = write_setup_txn.clone();
			write_ready_txn.psel = 1;
			write_ready_txn.penable = 1;
			g2d_mb.put(write_ready_txn);

			idle_txn = new();
			idle_txn.randomize() with {
				psel == 0;
				penable == 0;
				paddr == i;
			};
			g2d_mb.put(idle_txn);

			// Read transactions
			read_setup_txn = new();
			read_setup_txn.randomize() with {
				psel == 1;
				penable == 0;
				pwrite == 0;
				paddr == i;
			};
			g2d_mb.put(read_setup_txn);

			read_ready_txn = read_setup_txn.clone();
			read_ready_txn.psel = 1;
			read_ready_txn.penable = 1;
			g2d_mb.put(read_ready_txn);

			idle_txn = new();
			idle_txn.randomize() with {
				psel == 0;
				penable == 0;
				paddr == i;
			};
			g2d_mb.put(idle_txn);
		end
	endtask
endclass
