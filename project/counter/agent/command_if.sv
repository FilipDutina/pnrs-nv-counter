interface command_if;

   byte         unsigned        start_number;
   byte         unsigned        increment;
   bit 			up_down;
   byte 		unsigned 		cnt_number;
   bit          clk;
   bit          reset_n;
   bit			enable;
   bit 			valid;
   bit          ready;
   logic [7:0]  number;

endinterface : command_if
