class write_xtn extends uvm_sequence_item;
        `uvm_object_utils(write_xtn)
         rand bit[7:0] header;
         rand bit[7:0] payload_data[];
         bit[7:0] parity; 
         bit err; 
         constraint C1{header [1:0]!=3;} 
         constraint C2{payload_data.size == header[7:2];}
         constraint C3{header[7:2] != 0;}

        extern function new (string name = "write_xtn");
        extern function void post_randomize;
        extern function void do_print(uvm_printer printer);

endclass : write_xtn

function write_xtn::new(string name ="write_xtn");
        super.new(name);
endfunction

function void write_xtn::post_randomize(); 
           parity = 0 ^ header; 
           foreach (payload_data[i])
               parity = payload_data[i] ^ parity;
endfunction

function void::write_xtn::do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field( "header",   this.header,                   8,                              UVM_HEX);
        foreach (payload_data[i])
        printer.print_field($sformat("payload_data[%0d]",i), this.payload_data[i],    8,        UVM_HEX);
        printer.print_field("parity",     this.parity                   8,                      UVM_HEX);
endfunction

class bad_xtn extends write_xtn;

 `uvm_object_utils(bad_xtn)

 rand xtn_type trans_type; 
 extern function new (string name = "bad_xtn");
 extern function void post_randomize();
 extern function void do_print (uvm_printer printer);

endclass

function bad_xtn::new(string name ="bad_xtn");
        super.new(name);
endfunction

function void bad_xtn::post_randomize();
        parity = $random;
endfunction

function void bad_xtn::do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_generic("trans_type",   "xtns_type",               $bits(trans_type),             trans_type.name);
endfunction

         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
