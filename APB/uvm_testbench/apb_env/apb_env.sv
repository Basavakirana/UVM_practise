class apb_environment extends uvm_env;
    
    `uvm_component_utils(apb_environment)

    apb_agent_jtag apj;
    apb_slave_agent aps;

    apb_scoreboard scb;

    function new(string name ="", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        apj = apb_agent_jtag::type_id::create("apj", this);
        aps = apb_slave_agent::type_id::create("aps", this);
        scb = apb_scoreboard::type_id::create("scb", this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        apj.mon.ap.connect(scb.api);
    endfunction

endclass

/*
class apb_env extends uvm_env;
    apb_agent master_agent;
    apb_slave_agent slave_agent;

    function new(string name = "apb_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Master Agent
        master_agent = apb_agent::type_id::create("master_agent", this);
        uvm_config_db #(virtual apb_if)::set(this, "master_agent", "vif", vif);

        // Slave Agent
        slave_agent = apb_slave_agent::type_id::create("slave_agent", this);
        uvm_config_db #(virtual apb_if)::set(this, "slave_agent", "vif", vif);
    endfunction
endclass
*/
