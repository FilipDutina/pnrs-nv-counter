class command_sequence_3 extends uvm_sequence #(command_transaction);
  `uvm_object_utils(command_sequence_3)
  
  function new (string name = "command_sequence_3");
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
	bit gen_up_down = $urandom_range(0,1);
	$display(" Seq 3############################################################################");
    repeat(tx_count)
    begin
	    tx = command_transaction::type_id::create("tx");
		gen_start_number = $urandom_range(1,255);
		start_item(tx);
		if(!tx.randomize() with { start_number == gen_start_number;
			enable == 1;} )
			`uvm_error(get_full_name(), "Randomization failed") 		
		tx.print_transaction();
				
		finish_item(tx);      
    end 
	$display("############################################################################");
	    tx = command_transaction::type_id::create("tx");
		gen_start_number = $urandom_range(1,255);
		start_item(tx);
		if(!tx.randomize() with { start_number == gen_start_number;
			enable == 0;} )
			`uvm_error(get_full_name(), "Randomization failed") 		
		tx.print_transaction();	
		finish_item(tx); 
  endtask: body

endclass: command_sequence_3

