class fifo_drv extends uvm_driver #(fifo_trans);

    `uvm_component_utils(fifo_drv)

    fifo_agt_config agt_configh;

    extern function new(string name="fifo_drv",uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);

 endclass

    function fifo_drv :: new(string name="fifo_drv",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_drv :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(fifo_agt_config)::get(this,"","fifo_agt_config",agt_configh)) begin
            `uvm_fatal("get_type_name()","cannot get agt config data"); end
    endfunction
