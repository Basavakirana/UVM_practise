class wr_agt_top extends uvm_env;

    `uvm_component_utils(wr_agt_top)

    wr_agt_config wr_agt_configh[];
    wr_agent wr_agth[];
    env_config env_configh;

    extern function new(string name="wr_agt_top",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function wr_agt_top :: new(string name="wr_agt_top",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void wr_agt_top :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config) :: get(this,"","env_config",env_configh)) begin
            `uvm_fatal(get_full_name(),"cannot get env config data"); end
        wr_agth = new[env_configh.no_of_wr_agt];
        if(env_configh.has_wr_agt) begin
            foreach(wr_agth[i])
                begin
                    wr_agth[i] = wr_agent::type_id::create($sformatf("wr_agth[%0d]",i),this);
                    uvm_config_db #(wr_agt_config) :: set(this,($sformatf("wr_agth[%0d]*",i)),"wr_agt_config",env_configh.wr_agt_configh[i]);
                end
         end
    endfunction
