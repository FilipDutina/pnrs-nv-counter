class driver extends uvm_driver #(command_transaction);
   `uvm_component_utils(driver)
   
   //virtual da bi mogao da pristupi
   virtual command_if cmd_if;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(virtual command_if)::get(this, "","command_interface", cmd_if))
        `uvm_fatal("DRIVER", "Failed to get interface");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
    command_transaction tr;
	 
    forever begin
	
      seq_item_port.get_next_item(tr);
	  		  
	  //iz env u interface
	  cmd_if.start_number <= tr.start_number;
	  cmd_if.increment <= tr.increment;
	  cmd_if.up_down  <= tr.up_down;
	  cmd_if.cnt_number <= tr.cnt_number;
	  cmd_if.enable <= tr.enable;
	  
	  @(posedge cmd_if.clk);
	  if (cmd_if.reset_n == 1) begin
		  
		  while (cmd_if.ready == 0) begin
			
			@(posedge cmd_if.clk);
		  end
		  
	  end else
		  @(posedge cmd_if.clk);
		
	  seq_item_port.item_done();	
	  
    end
   endtask : run_phase
   
   
endclass : driver
