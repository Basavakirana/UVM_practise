class rd_agent extends uvm_agent;

    `uvm_component_utils(rd_agent)

    rd_agt_config rd_agt_configh;
    rd_drv rd_drvh;
    rd_mon rd_monh;
    rd_seqr rd_seqrh;

    extern function new(string name="rd_agent",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass

    function rd_agent :: new(string name="rd_agent",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void rd_agent :: build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db #(rd_agt_config) :: get(this,"","rd_agt_config",rd_agt_configh)) begin
            `uvm_fatal("get_type_name()","cannot get rd_agt config data"); end
        rd_monh = rd_mon::type_id::create("rd_monh",this); 
        if(rd_agt_configh.is_active==UVM_ACTIVE) begin
            rd_drvh = rd_drv::type_id::create("rd_drvh",this);
            rd_seqrh = rd_seqr::type_id:: create("rd_seqrh",this); end
    endfunction

    function void rd_agent :: connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(rd_agt_configh.is_active==UVM_ACTIVE) begin
            rd_drvh.seq_item_port.connect(rd_seqrh.seq_item_export); end
    endfunction
