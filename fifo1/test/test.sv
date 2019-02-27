class test extends uvm_test;

    `uvm_component_utils(test)

    env_config env_configh;
    rd_agt_config rd_agt_configh[];
    wr_agt_config wr_agt_configh[];
    env envh;

  /*  bit has_wr_agt = 1;
    int no_of_wr_agt = 1;
    bit has_rd_agt = 1;
    int no_of_rd_agt = 1;
    bit has_sb = 1;
    bit has_vseqr = 1; */

    extern function new(string name="test",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

    function test :: new(string name="test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void test :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        envh = env::type_id::create("envh",this);
        env_configh = env_config::type_id::create("env_configh");
        env_configh.has_wr_agt = 1;
        env_configh.no_of_wr_agt = 2;
        env_configh.has_rd_agt = 1;
        env_configh.no_of_rd_agt = 2;
        env_configh.has_sb = 1;
        env_configh.has_vseqr = 1;
        wr_agt_configh = new[env_configh.no_of_wr_agt];
        env_configh.wr_agt_configh = new[env_configh.no_of_wr_agt];
        if(env_configh.has_wr_agt) begin
            foreach(wr_agt_configh[i])
            begin
                wr_agt_configh[i] = wr_agt_config::type_id::create($sformatf("wr_agt_configh[%0d]",i));
                if(i==0)
                wr_agt_configh[i].is_active = UVM_ACTIVE;
                else
                wr_agt_configh[i].is_active = UVM_PASSIVE;
                env_configh.wr_agt_configh[i] = wr_agt_configh[i];
            end
         end
        rd_agt_configh = new[env_configh.no_of_rd_agt];
        env_configh.rd_agt_configh = new[env_configh.no_of_rd_agt];
        if(env_configh.has_rd_agt) begin
            foreach(rd_agt_configh[i])
            begin
                rd_agt_configh[i] = rd_agt_config::type_id::create($sformatf("rd_agt_configh[%0d]",i));
                rd_agt_configh[i].is_active = UVM_ACTIVE;
                env_configh.rd_agt_configh[i] = rd_agt_configh[i];
            end
         end
        uvm_config_db #(env_config) :: set(this,"*","env_config",env_configh);
    endfunction

    function void test :: end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction




