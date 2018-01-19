class test extends uvm_test;                                                                                                       
  `uvm_component_utils(test);                                      
                                                                    
  env m_env;                                                         
                                                                  
  function new (string name, uvm_component parent);                       
    super.new(name, parent);                                              
  endfunction : new                                                       


  function void build_phase(uvm_phase phase);                             
                                                               
    m_env = env::type_id::create("env", this);                     

  endfunction : build_phase                                               

  task run_phase(uvm_phase phase);                                        
//     command_sequence seq;
	 
//	 command_sequence_1 seq_1;
//	 command_sequence_2 seq_2;
	 command_sequence_3 seq_3;
 
	 phase.raise_objection(this);
/*	 
     seq = command_sequence::type_id::create("seq");
	 seq.start(m_env.m_agent.m_sequencer);
	 #2us;
*/
/*	 
	 seq_1 = command_sequence_1::type_id::create("seq_1");
	 seq_1.start(m_env.m_agent.m_sequencer);
	 #2us;
*/
/*	 
	 seq_2 = command_sequence_2::type_id::create("seq_2");
	 seq_2.start(m_env.m_agent.m_sequencer);	
	 #2us;
	*/ 
	 
	 seq_3 = command_sequence_3::type_id::create("seq_3");
	 seq_3.start(m_env.m_agent.m_sequencer);
	 
	 phase.drop_objection(this);	 
  endtask: run_phase                                                      

endclass: test                                                    
