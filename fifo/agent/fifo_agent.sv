class fifo_agent extends uvm_agent;

    `uvm_component_utils(fifo_agent)

    fifo_seqr seqrh;
    fifo_drv  drvh;
    fifo_mon  monh;
    fifo_agt_config agt_configh;


    extern function new(string name="fifo_agent",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass

    function fifo_agent :: new(string name="fifo_agent",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fifo_agent :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(fifo_agt_config)::get(this,"","fifo_agt_config",agt_configh))begin
            `uvm_fatal("get_type_name()","cannot get agent config data");end
        monh = fifo_mon::type_id::create("monh",this);
        
        if(agt_configh.is_active==UVM_ACTIVE)begin
            seqrh = fifo_seqr::type_id::create("seqrh",this);
            drvh = fifo_drv::type_id::create("drvh",this);end
    endfunction

    function void fifo_agent :: connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(agt_configh.is_active==UVM_ACTIVE)begin
            drvh.seq_item_port.connect(seqrh.seq_item_export);end
    endfunction  
