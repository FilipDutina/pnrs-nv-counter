class command_transaction extends uvm_sequence_item;
   //`uvm_object_utils(command_transaction)
   rand byte unsigned        start_number;
   rand byte unsigned        increment;
   rand bit				        valid;
   rand bit				        ready;
   rand bit				        reset_n;
   rand bit				        enable;
   rand bit 					up_down;
   rand byte unsigned 		    cnt_number; 
   static int 					num_of_transaction;
   logic [7:0]		  	        result;
	
	constraint overflow_underflow_constarint {
		if (up_down == 1) {
			increment <= 255 - start_number;
			start_number + cnt_number * increment < 255; 
		} else {
			increment < start_number;
			start_number - cnt_number * increment > 0;
		}
	}
	
	
	 // UVM factory registracija
	`uvm_object_utils_begin(command_transaction)
		`uvm_field_int(start_number, UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(increment, UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(valid, 	  UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(enable, 	  UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(up_down,   UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(cnt_number,   UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(ready,   UVM_DEFAULT | UVM_NOCOMPARE)
		`uvm_field_int(result, UVM_DEFAULT)
	`uvm_object_utils_end

  function void print_transaction();
		$display("-----------------------------");
		$display("Start number %d", start_number);
		$display("Increment    %d", increment);
		$display("Up down 	   		%d", up_down);
		$display("Count number %d", cnt_number);
		$display("-----------------------------");
  endfunction : print_transaction	
		
		
   function new (string name = "command_transaction");
      super.new(name);
		num_of_transaction++;
		$display("Transaction number %d created", num_of_transaction);
   endfunction : new

endclass : command_transaction

      
        