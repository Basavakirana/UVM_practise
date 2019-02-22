class apb_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(apb_scoreboard)
    
    uvm_analysis_imp#(apb_jtag_transaction, apb_scoreboard) api; //declarations
    virtual intf vif;

    function new (string name = "", uvm_component parent);//constructor
        super.new(name,parent);
        api = new("apb",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual intf)::get(this,"", "intf_inst",vif);
    endfunction

    virtual function void write(apb_jtag_transaction trans);
        //trans.print();
        if(trans.write)
            if(trans.apb_write_data == trans.pwdata)
                `uvm_info(get_type_name, $sformatf( "write operation performed successfully apb_write_data = %h,  apb_pwdata = %h", trans.apb_write_data, trans.pwdata),UVM_MEDIUM)
            else
                `uvm_error(get_type_name, $sformatf(" write operation failed apb_write_data = %h, apb.pwdata = %h", trans.apb_write_data,trans.pwdata))
        else
            if(trans.apb_read_data_out == trans.prdata)
                `uvm_info(get_type_name, $sformatf( "read operation performed successfully apb_read_data_out = %h,  apb_prdata = %h", trans.apb_read_data_out, trans.prdata),UVM_MEDIUM)
            else
                `uvm_error(get_type_name, $sformatf("read operation failed apb_read_data_out = %h, apb.prdata = %h", trans.apb_read_data_out,trans.prdata))
    endfunction

    //task run_phase(uvm_phase phase);
endclass


