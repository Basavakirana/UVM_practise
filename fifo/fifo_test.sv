class fifo_test extends uvm_test;

    `uvm_component_utils(fifo_test)

    fifo_env envh;
    fifo_env_config env_configh;
    fifo_agt_config agt_configh;

  //  int no_of_agents = 1;
  //  bit has_agent = 1;
  //  bit has_sb = 1;

    extern function new(string name="fifo_test",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

    function fifo_test :: new(string name="fifo_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_test :: build_phase(uvm_phase phase);
        env_configh = fifo_env_config::type_id::create("env_configh");
        env_configh.no_of_agents = 2;
        env_configh.has_agent = 1;
        env_configh.has_sb = 1;
        if(env_configh.has_agent) begin
            agt_configh = fifo_agt_config::type_id::create("agt_configh");
            agt_configh.is_active = UVM_ACTIVE;
            env_configh.agt_configh = agt_configh; end 
        uvm_config_db #(fifo_env_config)::set(this,"*","fifo_env_config",env_configh);
         super.build_phase(phase);
        envh = fifo_env::type_id::create("envh",this);
    endfunction

    function void fifo_test :: end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction
