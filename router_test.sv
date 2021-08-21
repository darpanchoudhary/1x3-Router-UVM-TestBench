class router_test extends uvm_test;

        `uvm_component_utils(router_test)

        router_env env;
        router_env_config e_cfg[];
        router_wr_agt_config wcfg[];
        router_rd_agt_config rcfg[];

        bit has_ragent = 1;
        bit has_wagent = 1;
        int no_of_read_agent = 3;
        int no_of_write_agent = 1;

        extern function new(string name = "router_test",uvm_component parent);
        extern function void config_router();
        extern function void build_phase(uvm_phase phase);
endclass

function router_test::new(string name = "router_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test::config_router();
        if(has_wagent)
          begin
                wcfg = new[no_of_write_agent];
                foreach (wcfg[i])
                  begin
                        wcfg[i]=router_wr_agt_config::type_id::create($sformatf("wcfg[%0d]",i));
                        if(!uvm_config_db # (virtual router_if)::get(this,"","vif",wcfg[i].vif))
                                `uvm_fatal("VIF CONFIG - WRITE","cannot get() interface vif from uvm_config_db. Have you set() it?")
                        wcfg[i].is_active = UVM_ACTIVE;
                        e_cfg.wr_agt_cfg[i] = wcfg[i];

                  end
          end
      
         if(has_ragent)
          begin
                rcfg = new[no_of_read_agent];
                foreach (rcfg[i])
                  begin
                        rcfg[i]=router_rd_agt_config::type_id::create($sformatf("rcfg[%0d]",i));
                       
                        if(!uvm_config_db # (virtual router_if)::get(this,"","vif",rcfg[i].vif))
                                `uvm_fatal("VIF CONFIG - READ","cannot get() interface vif from uvm_config_db. Have you set() it?")
                        wcfg[i].is_active = UVM_ACTIVE;
                        e_cfg.rd_agt_cfg[i] = rcfg[i];

                  end
          end
                                        
        e_cfg.has_ragent = has_ragent;
        e_cfg.has_wagent = has_wagent;
        e_cfg.no_of_read_agent = no_of_read_agent;
        e_cfg.no_of_write_agent = no_of_write_agent;
endfunction


function void router_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
        e_cfg = router_env_config::type_id::create("e_cfg");

        if(has_wagent)
                begin
                        e_cfg.wr_agt_cfg = new[no_of_write_agent]; 
                end

        if(has_ragent)
                begin
                        e_cfg.rd_agt_cfg = new[no_of_read_agent];
                end
        config_router();
        uvm_config_db # (router_env_config)::set(this,"*","router_env_config",e_cfg);
        env = router_env::type_id::create("env",this);

endfunction


//small packet test
class router_small_pkt_test extends router_test;

        `uvm_component_utils(router_small_pkt_test)

        router_small_pkt_vseq router_seqh;
        bit[1:0] addr;

        extern function new(string name = "router_small_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function router_small_pkt_test::new(string name = "router_small_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_small_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_small_pkt_test::run_phase(uvm_phase phase);
        repeat(20)
          begin
           addr={random}%3;
            uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
            phase.raise_objection(this);
            router_seqh = router_small_pkt_vseq::type_id::create("router_seqh");
            router_seqh.start(env.v_sequencer);
            phase.drop_objection(this);
          end
endtask


                                      //medium packet test //
class router_medium_pkt_test extends router_test;
        `uvm_component_utils(router_medium_pkt_test)

        router_medium_pkt_vseq router_seqh;
        bit[1:0] addr;

        extern function new(string name = "router_medium_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass


function router_medium_pkt_test::new(string name = "router_medium_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_medium_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_medium_pkt_test::run_phase(uvm_phase phase);
        repeat(20)
          begin
           addr={random}%3;
            uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
            phase.raise_objection(this);
            router_seqh = router_medium_pkt_vseq::type_id::create("router_seqh");
            router_seqh.start(env.v_sequencer);
            phase.drop_objection(this);
          end
endtask


                                //big packet test//
class router_big_pkt_test extends router_test;
        `uvm_component_utils(router_big_pkt_test)

        router_big_pkt_vseq router_seqh; 
        bit[1:0] addr;
        extern function new(string name = "router_big_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function router_big_pkt_test::new(string name = "router_big_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_big_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction


task router_big_pkt_test::run_phase(uvm_phase phase);
        repeat(20)
          begin
           addr={random}%3;
            uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
            phase.raise_objection(this);
            router_seqh = router_big_pkt_vseq::type_id::create("router_seqh");
            router_seqh.start(env.v_sequencer);
            phase.drop_objection(this);
          end
endtask

                                                //random packet test//

class router_random_pkt_test extends router_test;

        `uvm_component_utils(router_random_pkt_test)

        router_rndm_pkt_vseq router_seqh; 
        bit[1:0] addr;
        extern function new(string name = "router_random_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function router_random_pkt_test::new(string name = "router_random_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_random_pkt_test::build_phase(uvm_phase phase);
         super.build_phase(phase);
endfunction


task router_random_pkt_test::run_phase(uvm_phase phase);
        repeat(10)
          begin
           addr={random}%3;
            uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
            phase.raise_objection(this);
            router_seqh = router_rndm_pkt_vseq::type_id::create("router_seqh");
            router_seqh.start(env.v_sequencer);
            phase.drop_objection(this);
          end
endtask


                                                //bad packet test//
class router_bad_pkt_test extends router_test;
        `uvm_component_utils(router_bad_pkt_test)

        router_rndm_pkt_vseq router_seqh; 
        bit[1:0] addr;

        extern function new(string name = "router_bad_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function router_bad_pkt_test::new(string name = "router_bad_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_bad_pkt_test::build_phase(uvm_phase phase);
        set_type_override_by_type(write_xtn::get_type(),bad_xtn::get_type());
        super.build_phase(phase);
endfunction


task router_bad_pkt_test::run_phase(uvm_phase phase);
        repeat(10)
          begin
           addr={random}%3;
            uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
            phase.raise_objection(this);
            router_seqh = router_rndm_pkt_vseq::type_id::create("router_seqh");
            router_seqh.start(env.v_sequencer);
            phase.drop_objection(this);
          end
endtask
