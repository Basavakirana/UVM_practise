class wr_agt_config extends uvm_object;

    `uvm_object_utils(wr_agt_config)

    uvm_active_passive_enum is_active = UVM_ACTIVE;

    extern function new(string name="wr_agt_config");
        
endclass

    function wr_agt_config :: new(string name="wr_agt_config");
        super.new(name);
    endfunction
