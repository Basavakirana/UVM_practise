class fifo_mon extends uvm_monitor;

    `uvm_component_utils(fifo_mon)

    fifo_agt_config agt_configh;

    extern function new(string name="fifo_mon",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function fifo_mon :: new(string name="fifo_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_mon :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(fifo_agt_config)::get(this,"","fifo_agt_config",agt_configh))begin
            `uvm_fatal("get_type_name()","cannot get agt config data"); end
    endfunction
