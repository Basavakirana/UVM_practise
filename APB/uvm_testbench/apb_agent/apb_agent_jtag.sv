class apb_agent_jtag extends uvm_agent;
    `uvm_component_utils(apb_agent_jtag)
    
    apb_sequencer_jtag seqr;
    apb_driver_jtag dri;
    apb_monitor mon;
    virtual intf vif;


    function new (string name ="apb_agent_jtag", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name, "build phase started", UVM_MEDIUM) 
        seqr = apb_sequencer_jtag::type_id::create("seqr", this);
        dri = apb_driver_jtag::type_id::create("dri", this);
        mon = apb_monitor::type_id::create("mon", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        dri.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass


/*
class apb_agent extends uvm_agent;
    apb_driver driver;
    apb_sequencer sequencer;
    apb_monitor monitor;

    virtual apb_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        driver = apb_driver::type_id::create("driver", this);
        sequencer = apb_sequencer::type_id::create("sequencer", this);
        monitor = apb_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        driver.vif = vif;
        monitor.vif = vif;
    endfunction
endclass
*/
