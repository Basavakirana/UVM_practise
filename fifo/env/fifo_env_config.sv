class fifo_env_config extends uvm_object;

    `uvm_object_utils(fifo_env_config)

    int no_of_agents=1;
    bit has_agent=1;
    bit has_sb=1;
 //   uvm_active_passive_enum is_active=UVM_ACTIVE;

    fifo_agt_config agt_configh;

    extern function new(string name="fifo_env_config");

endclass

    function fifo_env_config :: new(string name="fifo_env_config");
        super.new(name);
    endfunction
