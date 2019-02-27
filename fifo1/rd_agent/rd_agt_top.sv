class rd_agt_top extends uvm_env;

    `uvm_component_utils(rd_agt_top)

    rd_agt_config rd_agt_configh[];
    rd_agent rd_agth[];
    env_config env_configh;

    extern function new(string name="rd_agt_top",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function rd_agt_top :: new(string name="rd_agt_top",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void rd_agt_top :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config) :: get(this,"","env_config",env_configh)) begin
            `uvm_fatal(get_full_name(),"cannot get env config data"); end
        rd_agth = new[env_configh.no_of_rd_agt];
        if(env_configh.has_rd_agt) begin
            foreach(rd_agth[i])
            begin
                rd_agth[i] = rd_agent::type_id::create($sformatf("rd_agth[%0d]",i),this);
                uvm_config_db #(rd_agt_config) :: set(this,($sformatf("rd_agth[%0d]*",i)),"rd_agt_config",env_configh.rd_agt_configh[i]);
            end
        end
    endfunction
