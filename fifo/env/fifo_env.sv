class fifo_env extends uvm_env;

    `uvm_component_utils(fifo_env)

    fifo_env_config env_configh;
    fifo_agt_config agt_configh;
    fifo_agt_top agt_toph;
    fifo_sb sbh;

    extern function new(string name="fifo_env",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function fifo_env :: new(string name="fifo_env",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_env :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(fifo_env_config)::get(this,"","fifo_env_config",env_configh)) begin
            `uvm_fatal("get_type_name()","cannot get env config data"); end
        if(env_configh.has_agent) begin
            agt_toph = fifo_agt_top::type_id::create("agt_toph",this); end
          //  agt_configh = fifo_agt_config::type_id::create("agt_configh"); end
        if(env_configh.has_sb) begin
            sbh = fifo_sb::type_id::create("sbh",this); end
    endfunction

