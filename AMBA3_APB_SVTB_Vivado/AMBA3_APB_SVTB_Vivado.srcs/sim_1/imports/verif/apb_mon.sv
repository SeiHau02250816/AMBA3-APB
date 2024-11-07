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
// Revision 1.10 - More tests added
// Additional Comments: Monitor for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class apb_mon;
	virtual apb_intf vintf;

	mailbox m2s_mb; 	// Monitor to scoreboard mailbox
	apb_txn txn_h;
	integer log_file;

	function new(virtual apb_intf vintf, mailbox m2s_mb);
		this.vintf = vintf;
		this.m2s_mb = m2s_mb;

		// Open the log file in write mode
		log_file = $fopen("results/transactions.log", "w");
		if (!log_file) $display("Error: Could not open transactions.log file.");
		else begin
			$display("Logging transactions to results/transactions.log");
			// Write the header row with right-aligned fields and separator line
			$fwrite(log_file, "%20s | %10s | %15s | %10s | %15s | %15s | %10s | %10s\n",
					"TIME(NS)", "OPERATION", "ADDR", "WRITE", "WRITE DATA", "READ DATA", "READY", "SLVERR");
			$fwrite(log_file, "------------------------------------------------------------------------------------------------------------------------------\n");
		end
	endfunction
	
	// Destructor to close the log file
	function void close();
		if (log_file) $fclose(log_file);
	endfunction
	
	task sample;
		forever begin
			txn_h = new();
			$display("Task sample :: apb_mon");
			
			@(vintf.mon_cb);
			apb_sample();
			apb_log(); // Log the transaction after sampling
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
            
            // Send transaction to mailbox for further processing
            m2s_mb.put(txn_h);
        end
	endtask

	task apb_log;
		// Log the transaction if psel = 1 and penable = 1
		if (txn_h.psel == 1 && txn_h.penable == 1) begin
			string operation;
			string wdata_str;
			string rdata_str;
			
			// Determine operation type and format write/read data accordingly
			if (txn_h.pwrite) begin
				operation = "WRITE";
				rdata_str = "0xXXXXXXXX";  // Unknown data representation
				$sformat(wdata_str, "0x%08h", txn_h.pwdata);  // Pad write data with leading zeros
			end else begin
				operation = "READ ";
				wdata_str = "0xXXXXXXXX";  // Unknown data representation
				$sformat(rdata_str, "0x%08h", txn_h.prdata);  // Pad read data with leading zeros
			end
			
			// Log the transaction details in right-aligned, table format with padded values
			$fwrite(log_file, "%12t | %10s |      0x%08h | %10d | %15s | %15s | %10d | %10d\n",
					$time, operation, txn_h.paddr, txn_h.pwrite, wdata_str, rdata_str, txn_h.pready, txn_h.pslverr);
		end
	endtask
endclass



