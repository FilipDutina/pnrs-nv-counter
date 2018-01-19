	class monitor extends uvm_monitor;
		`uvm_component_utils(monitor)
	
		// Components
		virtual command_if cmd_if;
		
		// Ports
		uvm_analysis_port #(command_transaction) aport;

		// Constructor
		function new(string name = get_name(), uvm_component parent);
			super.new(name, parent);
			aport = new("aport", this);
		endfunction
		
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(virtual command_if)::get(this, "","command_interface", cmd_if))
			  `uvm_fatal("MONITOR", "Failed to get interface");
		endfunction : build_phase
	
		// Function/Task declarations
		extern virtual task          run_phase          (uvm_phase phase);

	endclass: monitor

//******************************************************************************
// Function/Task implementations
//******************************************************************************

	task monitor::run_phase(uvm_phase phase);
		command_transaction tr_in;
		tr_in = command_transaction::type_id::create("tr_in");
		forever begin
			
			@(posedge cmd_if.clk);
			if(cmd_if.reset_n == 1) begin
				
				//kupim podatke iz drajvera
				tr_in.start_number = cmd_if.start_number;
				tr_in.increment = cmd_if.increment;
				tr_in.up_down = cmd_if.up_down;
				tr_in.cnt_number = cmd_if.cnt_number;			
			
			    //cekam da valid bude 1
				while (cmd_if.valid == 0)  begin
					@(posedge cmd_if.clk);
				end	
				
				tr_in.valid = cmd_if.valid; 
				tr_in.result = cmd_if.number;	
				
				//slanje podataka sco i pred				
				aport.write(tr_in);
			end else
				@(posedge cmd_if.clk);
		end
	endtask: run_phase
