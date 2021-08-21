class router_wr_driver extends uvm_driver #(write_xtn);

        `uvm_component_utils(router_wr_driver)     
        virtual router_if.WDR_MP vif;    

      
        router_wr_agent_config m_cfg;    
        
        extern function new (string name ="router_wr_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task send_to_dut(write_xtn xtn);
        extern function void report_phase(uvm_phase phase);

endclass

function router_wr_driver::new(string name = "router_wr_driver",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_wr_driver::build_phase(uvm_phase phase);
         super.build_phase(phase);
         if(!uvm_config_db # (router_wr_agent_config)::get(this,"","router_wr_agent_config",m_cfg)) 
         `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction


function void router_wr_driver::connect_phase(uvm_phase phase);
        vif = m_cfg.vif; 
endfunction

task router_wr_driver::run_phase(uvm_phase phase);
                @(vif.wdr_cb);
                vif.wdr_cb.rst<=0;
                @(vif.wdr_cb);
                vif.wdr_cb.rst<=1;  //in these 4 statements we are driving the reset
                forever
                begin
                 seq_item_port.get_next_item(req);
                 send_to_dut(req);  //meaning drive it to the DUT
                 seq_item_port.item_done();
                end
endtask

task router_wr_driver::send_to_dut(write_xtn xtn);     
          `uvm_info("WRITE_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
    
             @(vif.wdr_cb);
              wait(!vif.wdr_cb.busy)
              vif.wdr_cb.pkt_valid <=1; 
              vif.wdr_cb.data_in <= xtn.header; 
              foreach(xtn.payload_data[i])
                begin
                  wait(!vif.wdr_cb.busy)
                  vif.wdr_cb.data_in <= xtn.payload_data[i];
                  @(vif.wdr_cb);
                end
              wait(!vif.wdr_cb.busy)
              vif.wdr_cb.pkt_valid <=0; 
              vif.wdr_cb.data_in <= xtn.parity; 
              repeat(2)@(vif.wdr_cb); 
              m_cfg.drv_data_count++;
endtask

                
function void router_wr_driver::report_phase(uvm_phase phase);
         `uvm_info(get_type_name(), $sformatf("Report: router write driver sent %0d transactions", m_cfg.drv_data_count), UVM_LOW)
endfunction

