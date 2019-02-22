/*class apb_agent_slave extends uvm_agent;

    `uvm_component_utils(apb_jtag_agent)
    
    apb_monitor mon;
    
    
    function new (string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon = apb_monitor::type_id::create("mon");
        
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
        
endclass

*/

class apb_slave_agent extends uvm_agent;
    virtual intf vif;
    
    `uvm_component_utils(apb_slave_agent)
    apb_slave_driver dri;
    apb_sequencer_slave seqr;

    function new(string name = "apb_slave_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

       `uvm_info(get_type_name, "build phase started", UVM_MEDIUM) 
        // Instantiate components
        dri = apb_slave_driver::type_id::create("dri_s", this);
        seqr = apb_sequencer_slave::type_id::create("seqr_s", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dri.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass
