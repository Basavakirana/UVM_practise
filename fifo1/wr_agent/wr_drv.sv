class wr_drv extends uvm_driver #(wr_trans);

    `uvm_component_utils(wr_drv)

    wr_agt_config wr_agt_configh;

    extern function new(string name="wr_drv",uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

    function wr_drv :: new(string name="wr_drv",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void wr_drv :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(wr_agt_config) :: get(this,"","wr_agt_config",wr_agt_configh)) begin
            `uvm_fatal("get_type_name()","cannot get wr_agt_config data"); end
    endfunction
