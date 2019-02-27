class rd_drv extends uvm_driver #(rd_trans);

    `uvm_component_utils(rd_drv)

    rd_agt_config rd_agt_configh;

    extern function new(string name="rd_drv",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function rd_drv :: new(string name="rd_drv",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void rd_drv :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db #(rd_agt_config) :: get(this,"","rd_agt_config",rd_agt_configh)) begin
            `uvm_fatal("get_type_name()","cannot get rd_agt_cofig data"); end
    endfunction
