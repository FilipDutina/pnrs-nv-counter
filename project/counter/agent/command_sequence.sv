class command_sequence extends uvm_sequence #(command_transaction);
  `uvm_object_utils(command_sequence)
  
  function new (string name = "command_sequence");
    super.new(name);
  endfunction : new

  // A variable that specifies the number of transactions to
  // generate in the sequence
  //int count = 9;

  task body;
    command_transaction tx;
	int tx_count = 9;
	byte unsigned gen_start_number;
	byte unsigned gen_cnt_number;
	byte unsigned gen_increment;
	$display(" Seq ############################################################################");
    repeat(tx_count)
    begin
	    tx = command_transaction::type_id::create("tx");
		gen_start_number = $urandom_range(0,15);
		gen_cnt_number = $urandom_range(0,10);
		gen_increment = $urandom_range(1,5);
		start_item(tx);
		if(!tx.randomize() with { start_number == gen_start_number;
			up_down == 1;
			cnt_number == gen_cnt_number;
			enable == 1;
			increment == gen_increment; } )
			`uvm_error(get_full_name(), "Randomization failed") 		
		tx.print_transaction();
      finish_item(tx);      
    end 
	$display("############################################################################");
	
	 start_item(tx);
	 if(!tx.randomize() with { start_number == gen_start_number;
			up_down == 1;
			enable == 0;
			cnt_number == gen_cnt_number;
			increment == gen_increment; } )
			`uvm_error(get_full_name(), "Randomization failed") 
	 finish_item(tx); 
	 
  endtask: body

endclass: command_sequence

