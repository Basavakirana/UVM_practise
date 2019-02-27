class fifo_agt_config extends uvm_object;

    `uvm_object_utils(fifo_agt_config)

    uvm_active_passive_enum is_active=UVM_ACTIVE;

    extern function new(string name="fifo_agt_config");

endclass

    function fifo_agt_config :: new(string name="fifo_agt_config");
        super.new(name);
    endfunction
