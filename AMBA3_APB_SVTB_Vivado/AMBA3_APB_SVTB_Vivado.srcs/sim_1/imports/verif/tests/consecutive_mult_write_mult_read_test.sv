//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sei Hau, Teo
// 
// Create Date: 22.10.2024 14:51:14
// Design Name: consecutive_mult_write_mult_read_test
// Module Name: consecutive_mult_write_mult_read_test
// Project Name: AMBA3_APB_SVTB
// 
// Revision:
// Revision 0.01 - File Created
// Revision 1.10 - More tests added
// Additional Comments: Test for AMBA3 APB SV TB 
// 
//////////////////////////////////////////////////////////////////////////////////

class consecutive_mult_write_mult_read_test;
	virtual apb_intf vintf;
	apb_env apb_env_h;

	function new(virtual apb_intf vintf);
		this.vintf = vintf;
		apb_env_h = new(this.vintf);
		write_config_file();
	endfunction
	
	// Write configuration to file with a randomized transaction count
	function void write_config_file();
		int file;
		int num_txns = $urandom_range(3, 10);  // Randomize between 3 and 10
		int consecutive = 1;
		
		file = $fopen("apb_config.cfg", "w");
		if (file) begin
			$fdisplay(file, "NUM_OF_TXN=%0d", num_txns);
			$fdisplay(file, "CONSECUTIVE=%0d", consecutive);
			$fclose(file);
			$display("Configuration file written successfully.");
			$display("Number of transactions = %0d.", num_txns);
			$display("Consecutive = %0d.", consecutive);
		end 
		else begin
			$error("Error: Could not create configuration file.");
		end
	endfunction
	
	task main;
		$display("Task main :: consecutive_mult_write_mult_read_test");
		apb_env_h.main();
	endtask
endclass