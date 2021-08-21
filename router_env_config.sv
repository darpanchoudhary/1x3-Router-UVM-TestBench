class router_env_config extends uvm_object;
        `uvm_object_utils(router_env_config)

        bit has_functional_coverage = 0;
        bit has_wagent_functional_coverage = 0;
        bit has_scoreboard = 1;
        bit has_wagent = 1;
        bit has_ragent = 1;
        int no_of_write_agent = 1;
        int no_of_read_agent = 3;
        bit has_virtual_sequencer = 1;
        router_wr_agent_config wr_agent_cfg[];
        router_rd_agent_config rd_agent_cfg[];
        extern function new(string name = "router_env_config");

endclass: router_env_config

function router_env_config::new(string name = "router_env_config");
  super.new(name);
endfunction
