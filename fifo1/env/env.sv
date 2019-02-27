class env extends uvm_env;

    `uvm_component_utils(env)

    env_config env_configh;
    wr_agt_top wr_agt_toph;
    rd_agt_top rd_agt_toph;
    sb sbh;
    vseqr vseqrh;

    extern function new(string name="env",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function env :: new(string name="env",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void env :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config) :: get(this,"","env_config",env_configh)) begin
            `uvm_fatal(get_full_name(),"cannot get env_config data"); end
        if(env_configh.has_wr_agt) begin
            wr_agt_toph = wr_agt_top::type_id::create("wr_agt_toph",this); end
        if(env_configh.has_rd_agt) begin
            rd_agt_toph = rd_agt_top::type_id::create("rd_agt_toph",this); end
        if(env_configh.has_sb) begin
            sbh = sb::type_id::create("sbh",this); end
        if(env_configh.has_vseqr) begin
            vseqrh = vseqr::type_id::create("vseqrh",this); end
     endfunction
