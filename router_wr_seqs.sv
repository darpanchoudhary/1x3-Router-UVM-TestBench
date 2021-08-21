
class router_wr_seqs extends uvm_sequence #(write_xtn); 
        `uvm_object_utils(router_wr_seqs)
   extern function new(string name = "router_wr_seqs");
endclass


function router_wr_seqs::new(string name = "router_wr_seqs");
        super.new(name);
endfunction

                           /////////small packet///////
class router_wxtns_small_pkt extends router_wr_seqs;
        `uvm_object_utils(router_wxtns_small_pkt)
        bit[1:0]addr;
        extern function new(string name = "router_wxtns_small_pkt");
        extern task body();
endclass

function router_wxtns_small_pkt::new(string name = "router_wxtns_small_pkt");
          super.new(name);
endfunction


task router_wxtns_small_pkt::body();
        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))        
           `uvm_fatal(get_type_name(),"getting the config failed,check if set properly")
        req = write_xtn::type_id::create("req"); 
        start_item(req);
        assert(req.randomize() with {header[7:2]inside {[1:15]} && header [1:0]==addr;});
        `uvm_info("write_sequence",$formatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
endtask

                            /////////medium packet/////////
class router_wxtns_medium_pkt extends router_wr_seqs;
        `uvm_object_utils(medium_write_seqs)
        bit[1:0]addr;
        extern function new(string name = "router_wxtns_medium_pkt");
        extern task body();
endclass

function router_wxtns_medium_pkt::new(string name = "router_wxtns_medium_pkt");
          super.new(name);
endfunction

task router_wxtns_medium_pkt::body();
        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))        
           `uvm_fatal(get_type_name(),"getting the config failed,check if set properly")
        req = write_xtn::type_id::create("req"); 
        start_item(req);
        assert(req.randomize() with header[7:2]inside {[16:30]} && header [1:0]==addr;});
        `uvm_info("write_sequence",$formatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
endtask


                               /////big packet////////
class router_wxtns_big_pkt extends router_wr_seqs;
        `uvm_object_utils(router_wxtns_big_pkt)
        bit[1:0]addr;
        extern function new(string name = "router_wxtns_big_pkt");
        extern task body();
endclass

function router_wxtns_big_pkt::new(string name = "router_wxtns_big_pkt");
          super.new(name);
endfunction

task router_wxtns_big_pkt::body();
        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))        
           `uvm_fatal(get_type_name(),"getting the config failed,check if set properly")
        req = write_xtn::type_id::create("req"); 
        start_item(req);
        assert(req.randomize() with header[7:2]inside {[31:45]} && header [1:0]==addr;});
        `uvm_info("write_sequence",$formatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
endtask



//random packet
class router_wxtns_random_pkt extends router_wr_seqs;
        `uvm_object_utils(router_wxtns_random_pkt)
        bit[1:0]addr;
        extern function new(string name = "router_wxtns_random_pkt");
        extern task body();
endclass

function router_wxtns_random_pkt::new(string name = "router_wxtns_random_pkt");
          super.new(name);
endfunction

task router_wxtns_random_pkt::body();
        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))        
           `uvm_fatal(get_type_name(),"getting the config failed,check if set properly")
        req = write_xtn::type_id::create("req"); 
        start_item(req);
        assert(req.randomize() with  header [1:0]==addr;});
        `uvm_info("write_sequence",$formatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
endtask
