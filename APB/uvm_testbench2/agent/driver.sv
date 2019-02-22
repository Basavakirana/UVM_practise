// Driver
class apb_driver extends uvm_driver#(apb_transaction);
    `uvm_component_utils(apb_driver)

    virtual apb_if #(32, 32) vif_apb;
    virtual jtag_master_if #(32, 32) vif_jtag;
    apb_transaction tr;
  
    function new(string name, uvm_component parent);
        super.new(name, parent);
    end

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual apb_if #(32, 32))::get(this, "", "vif_apb", vif_apb))
            `uvm_fatal("NOVIF", "No virtual interface specified for APB!");
        if (!uvm_config_db#(virtual jtag_master_if #(32, 32))::get(this, "", "vif_jtag", vif_jtag))
            `uvm_fatal("NOVIF", "No virtual interface specified for JTAG!");
    end

    task run_phase(uvm_phase phase);
        forever begin
        
        seq_item_port.get_next_item(tr);
        //@(posedge vif_apb.pclk);
        vif_jtag.transfer = tr.transfer;
        vif_jtag.read = tr.read;
        vif_jtag.write = tr.write;
        vif_jtag.apb_paddr = tr.apb_paddr;
        vif_jtag.apb_write_data = tr.apb_write_data;

        // Wait for APB response
        @(posedge vif_apb.pclk);
        wait (vif_apb.pready);

        if (tr.read)
            tr.apb_read_data_out = vif_apb.prdata;

        seq_item_port.item_done();
        end
    endtask

endclass
