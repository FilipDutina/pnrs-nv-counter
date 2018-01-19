package counter_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "command_transaction.sv"
	`include "command_sequence.sv"  
	`include "command_sequence_1.sv"
	`include "command_sequence_2.sv"  	
	`include "command_sequence_3.sv"
	`include "driver.sv"
	`include "monitor.sv"
	`include "../scoreboard/scoreboard.sv"
	`include "../predictor/predictor.sv"
	`include "agent.sv"
	`include "env.sv"
	`include "test.sv"

endpackage : counter_pkg
   