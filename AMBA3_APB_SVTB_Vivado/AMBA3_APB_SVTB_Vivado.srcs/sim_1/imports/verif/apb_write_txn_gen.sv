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
// Revision 1.10 - More tests added
// Additional Comments: Generator for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_write_txn_gen extends apb_gen;
	// Configuration properties as global class members
	int num_txns;
	int consecutive;

	apb_txn write_setup_txn, write_ready_txn, idle_txn;
	apb_txn read_setup_txn, read_ready_txn;

	// Constructor
	function new(mailbox g2d_mb);
		super.new(g2d_mb);
		load_configurations();  // Load configurations on instantiation
	endfunction

	// Method to load configurations from the config file
	function void load_configurations();
		int file;
		string line;
		num_txns = 0;      // Default value if not specified in the file
		consecutive = 0;   // Default to non-consecutive if not specified

		file = $fopen("apb_config.cfg", "r");
		if (file) begin
			while (!$feof(file)) begin
				line = "";
				$fgets(line, file);
				if ($sscanf(line, "NUM_OF_TXN=%d", num_txns) == 1) continue;
				if ($sscanf(line, "CONSECUTIVE=%d", consecutive) == 1) continue;
			end
			$fclose(file);
		end else begin
			$display("Error: Could not open configuration file apb_config.cfg");
		end
	endfunction

	// Task for generating transactions consecutively
	task gen_consecutive();
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
			write_ready_txn.penable = 1;
			g2d_mb.put(write_ready_txn);

			// Idle transaction
			idle_txn = new();
			idle_txn.randomize() with {
				psel == 0;
				penable == 0;
				paddr == i;
			};
			g2d_mb.put(idle_txn);
		end

		for (int i = 1; i <= num_txns; i++) begin
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
			read_ready_txn.penable = 1;
			g2d_mb.put(read_ready_txn);

			// Idle transaction
			idle_txn = new();
			idle_txn.randomize() with {
				psel == 0;
				penable == 0;
				paddr == i;
			};
			g2d_mb.put(idle_txn);
		end
	endtask

	// Task for generating transactions non-consecutively (alternating)
	task gen_non_consecutive();
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
			write_ready_txn.penable = 1;
			g2d_mb.put(write_ready_txn);

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
			read_ready_txn.penable = 1;
			g2d_mb.put(read_ready_txn);

			// Idle transaction
			idle_txn = new();
			idle_txn.randomize() with {
				psel == 0;
				penable == 0;
				paddr == i;
			};
			g2d_mb.put(idle_txn);
		end
	endtask

	// Override the gen task to choose between consecutive and non-consecutive modes
	task gen;
		#30;
		$display("Task generate :: apb_write_txn_gen with %0d transaction(s), CONSECUTIVE=%0d", num_txns, consecutive);

		if (consecutive == 1) begin
			gen_consecutive();
		end else begin
			gen_non_consecutive();
		end
	endtask
endclass


