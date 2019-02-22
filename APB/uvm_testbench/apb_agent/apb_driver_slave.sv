class apb_slave_driver extends uvm_driver #(apb_slave_transaction);
    virtual intf vif;

    `uvm_component_utils(apb_slave_driver)
    int unsigned memory [*];
    function new(string name = "apb_slave_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name, "build phase started", UVM_MEDIUM) 
        if (!uvm_config_db #(virtual intf)::get(this, "", "vif", vif)) begin
            `uvm_fatal("APB_SLAVE_DRIVER", "Virtual interface not set for slave driver")
        end
    endfunction

    task run_phase(uvm_phase phase);
        apb_slave_transaction tr;
        vif.pready <= 0;
        vif.pslverr <= 0;
        vif.prdata <= 0;
        forever begin
            seq_item_port.get_next_item(tr);
            `uvm_info(get_type_name, "psel _driver running", UVM_MEDIUM)
            // Drive responses on the slave interface
            @(posedge vif.pclock);
            
            if(vif.presetn) begin

                while(!vif.psel) @(posedge vif.pclock);
                `uvm_info(get_type_name, "psel detected high by slave", UVM_MEDIUM)
                if(tr.wait_no_wait_status == 1)
                    repeat(tr.no_of_wait_cycles) @(posedge vif.pclock);
                vif.pready <= tr.pready;
                vif.pslverr <= tr.pslverr;
                wait(vif.penable);
                `uvm_info(get_type_name, "high enable detected by slave", UVM_MEDIUM)
                if(vif.pwrite) begin
                    memory[vif.paddr] = vif.pwdata;
                    $display("data written into slave at memory [%h] = %h",vif.paddr,memory[vif.paddr]);
                end
                else begin
                    vif.prdata <= memory.exists(vif.paddr)? memory[vif.paddr]: $urandom();
                end
             
                @(posedge vif.pclock);
                vif.pready <= 0;
                vif.pslverr <= 0;
                //@(posedge vif.pclock);
            end
            else begin
                vif.pready <= 0;
                vif.pslverr <= 0;
                vif.prdata <= 0;
                @(posedge vif.pclock);
            end

            seq_item_port.item_done();
        end
    endtask
endclass
