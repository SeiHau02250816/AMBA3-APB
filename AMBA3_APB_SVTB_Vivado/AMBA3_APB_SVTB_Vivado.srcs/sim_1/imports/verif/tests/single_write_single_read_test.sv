`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 06.11.2024 19:50:38
// Design Name: single_write_single_read_test
// Module Name: single_write_single_read_test
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Test for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class single_write_single_read_test;
	virtual apb_intf vintf;
	apb_env apb_env_h;

	function new(virtual apb_intf vintf);
		this.vintf = vintf;
		apb_env_h = new(this.vintf);
		write_config_file();
	endfunction

	// Write configuration to file
	function void write_config_file();
		int file;
		int num_txns = 1;  // Set number of transactions to 1 for single write + single read

		file = $fopen("apb_config.cfg", "w");
		if (file) begin
			$fdisplay(file, "NUM_OF_TXN=%0d", num_txns);
			$fclose(file);
			$display("Configuration file written successfully.");
			$display("Number of transactions = %0d.", num_txns);
		end else begin
			$error("Error: Could not create configuration file.");
		end
	endfunction
	
	task main;
		$display("Task main :: single_write_single_read");
		apb_env_h.main();
	endtask
endclass

