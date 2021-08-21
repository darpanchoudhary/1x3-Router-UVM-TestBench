class router_wr_agt_config extends uvm_object;

        `uvm_object_utils(router_wr_agt_config)
        virtual router_if vif;
        uvm_active_passive_enum is_active = UVM_ACTIVE;
        static int mon_data_cnt = 0; 
        static int drv_data_cnt = 0;
        extern function new(string name = "router_wr_agt_config");

endclass: router_wr_agt_config

function router_wr_agt_config::new(string name = "router_wr_agt_config");
        super.new(name);
endfunction

