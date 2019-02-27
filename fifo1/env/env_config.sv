class env_config extends uvm_object;

    `uvm_object_utils(env_config)

    bit has_wr_agt = 1;
    int no_of_wr_agt = 1;
    bit has_rd_agt = 1;
    int no_of_rd_agt = 1;
    bit has_sb = 1;
    bit has_vseqr = 1;

    wr_agt_config wr_agt_configh[];
    rd_agt_config rd_agt_configh[];

    extern function new(string name="env_config");

endclass

    function env_config :: new(string name="env_config");
        super.new(name);
    endfunction
