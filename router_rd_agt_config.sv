class router_rd_agt_config extends uvm_object;

        `uvm_object_utils(router_rd_agt_config)

        virtual router_if vif;
        uvm_active_passive_enum is_active = UVM_ACTIVE;
        static int mon_data_cnt = 0; 
        static int drv_data_cnt = 0;
        extern function new(string name = "router_rd_agt_config");

endclass: router_rd_agt_config

function router_rd_agt_config::new(string name = "router_rd_agt_config");
         super.new(name);
endfunction

