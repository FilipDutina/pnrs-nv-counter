module top;
import uvm_pkg::*;
import   counter_pkg::*;
`include "uvm_macros.svh"

bit clk; 
bit reset_n; 
command_if       command_interface();
   
counter       dut (.in_start_number(command_interface.start_number), 
				 .in_increment(command_interface.increment), 
                 .clk(command_interface.clk), 
				 .rst(command_interface.reset_n), 
				 .in_enable(command_interface.enable),
				 .in_cnt_number(command_interface.cnt_number),
				 .in_up_down(command_interface.up_down),
                 .o_valid(command_interface.valid),
				 .o_ready(command_interface.ready),
                 .o_number(command_interface.number));

 initial begin
  uvm_config_db #(virtual command_if)::set(null, "*", "command_interface", command_interface);
  run_test("test");
 end

 initial begin
    clk = 0;
    forever begin
       #10;
       clk = ~clk;
    end
 end
 
 initial begin
    reset_n = 1'b1;
    #10;
    reset_n = 1'b0;
    #40;
    reset_n = 1'b1;
 end 
 
assign command_interface.clk = clk;
assign command_interface.reset_n = reset_n; 
 
endmodule : top

     
   