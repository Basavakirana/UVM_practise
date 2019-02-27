class fifo_agt_top extends uvm_env;

    `uvm_component_utils(fifo_agt_top)

     fifo_agt_config agt_configh;
     fifo_env_config env_configh;
     fifo_agent fifo_agth;

     extern function new(string name="fifo_agt_top",uvm_component parent);
     extern function void build_phase(uvm_phase phase);

 endclass

    function fifo_agt_top :: new(string name="fifo_agt_top",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_agt_top :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(fifo_env_config)::get(this,"","fifo_env_config",env_configh))begin
            `uvm_fatal("get_type_name()","cannot get env config data");end        
        if(env_configh.has_agent)begin
          //  if (env_configh.agt_configh == null) 
 // `uvm_fatal("CFG", "agt_config is NULL before config_db::set") 
            uvm_config_db #(fifo_agt_config)::set(this,"fifo_agth*","fifo_agt_config",env_configh.agt_configh);
            fifo_agth = fifo_agent::type_id::create("fifo_agth",this);end
    endfunction



