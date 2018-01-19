class predictor extends uvm_component;
	`uvm_component_utils(predictor)
	command_transaction tr;
	//input
	uvm_analysis_imp   #(command_transaction, predictor) i_operands;
   
	// output
	uvm_analysis_port       #(command_transaction) o_addr;
   
	static int num_of_prediction;
   
   function new(string name = "predictor", uvm_component parent);
		super.new(name, parent);
		i_operands    = new("i_operands"  , this);
		o_addr        = new("o_addr"       , this);
		tr = command_transaction::type_id::create("tr_in");		
   endfunction : new

   extern virtual task          run_phase    (uvm_phase phase);
	extern virtual function void write   (command_transaction t);

endclass : predictor

//******************************************************************************
// Function/Task implementations
//******************************************************************************
 function void predictor::write(command_transaction t);
	byte unsigned result = 0;
	 if (t.valid == 1) begin
		tr.start_number = t.start_number;
		tr.increment = t.increment;
		tr.up_down = t.up_down;
		tr.cnt_number = t.cnt_number;
		result = tr.start_number;
		for (int i = 0; i < tr.cnt_number; i++) begin
			if (tr.up_down == 0) begin
				result = result - tr.increment;
			end else
				result = result + tr.increment;	
		end
		tr.result = result;
		
		//saljem scor
		o_addr.write(tr);
	end
 endfunction : write
//------------------------------------------------------------------------------

task predictor::run_phase(uvm_phase phase);
	//forever begin

	//end
endtask : run_phase
