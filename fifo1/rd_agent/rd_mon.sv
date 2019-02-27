class rd_mon extends uvm_monitor;

    `uvm_component_utils(rd_mon)

    rd_agt_config rd_agt_configh;

    extern function new(string name="rd_mon",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function rd_mon ::new(string name="rd_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void rd_mon :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(rd_agt_config) :: get(this,"","rd_agt_config",rd_agt_configh)) begin
            `uvm_fatal("get_type_name()","cannot get rd_agt_config data"); end
    endfunction
