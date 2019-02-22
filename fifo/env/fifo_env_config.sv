class fifo_env_config extends uvm_object;

    `uvm_object_utils(fifo_env_config)

    int no_of_agents;
    bit has_agent;
    bit has_sb;

    fifo_agent fifo_agt;

    extern function new(string name="fifo_env_config");

endclass

    function fifo_env_config :: new(string name="fifo_env_config");
        super.new(name);
    endfunction
