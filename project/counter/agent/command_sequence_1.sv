class command_sequence_1 extends uvm_sequence #(command_transaction);
  `uvm_object_utils(command_sequence_1)
  
  function new (string name = "command_sequence_1");
    super.new(name);
  endfunction : new
  
  
  function bit simple_number(byte unsigned n);
	if (n == 2 || n == 1)
		return 1;
		
	for (int i = 2; i < n; i++)
		if (n % i == 0) 
			return 0;
	return 1;
  endfunction : simple_number

  // A variable that specifies the number of transactions to
  // generate in the sequence
  //int count = 9;

  task body;
    command_transaction tx;
	int tx_count = 9;
	byte unsigned gen_start_number;
	byte unsigned gen_cnt_number;
	byte unsigned gen_increment;
	bit gen_up_down = $urandom_range(0,1);
	$display(" Seq 2############################################################################");
    repeat(tx_count)
    begin
	    tx = command_transaction::type_id::create("tx");
		gen_start_number = $urandom_range(10,255);
		gen_cnt_number = $urandom_range(1,10);
		gen_increment = $urandom_range(1,10);
		
		while (simple_number(gen_increment) == 0 && gen_increment < 255)
			gen_increment++;
	
		start_item(tx);
		if(!tx.randomize() with { start_number == gen_start_number;
			cnt_number == gen_cnt_number;
			up_down == gen_up_down;
			enable dist {1'b0:=30,1'b1:=70};
			increment == gen_increment; } )
			`uvm_error(get_full_name(), "Randomization failed") 		
		tx.print_transaction();
		
		if (gen_up_down == 0)
			gen_up_down = 1;
		else
			gen_up_down = 0;
			
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

endclass: command_sequence_1

