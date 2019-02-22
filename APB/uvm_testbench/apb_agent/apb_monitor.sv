class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    uvm_analysis_export #(apb_jtag_transaction) ap;
    virtual intf vif;


    function new(string name ="", uvm_component parent);
        super.new(name,parent);
        ap = new("ap",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name, "build phase started", UVM_MEDIUM) 
        if(!uvm_config_db#(virtual intf)::get(this, "","vif",vif)) `uvm_fatal("intf_driver","interface not found");
    endfunction
    

    task run_phase(uvm_phase phase);
        apb_jtag_transaction trans;
   fork
        begin
        forever begin
            trans = apb_jtag_transaction::type_id::create("trans");
            @(posedge vif.pclock);
            /*trans.presetn = vif.presetn;
            trans.transfer = vif.transfer;
            trans.read = vif.read;
            trans.write = vif.write;
            trans.apb_paddr = vif.apb_paddr;
            trans.apb_write_data = vif.apb_write_data;
            trans.prdata = vif.prdata;
            trans.pslverr = vif.pslverr;
            trans.psel = vif.psel;
            trans.penable = vif.penable;
            trans.paddr = vif.paddr;
            trans.pwdata = vif.pwdata;
            trans.apb_read_data_out = vif.apb_read_data_out;
            trans.apb_read_data_valid = vif.apb_read_data_valid;
            trans.print;
            */
            if(vif.presetn) begin
                @(posedge vif.pclock);
                trans.transfer = vif.transfer;
                if(vif.transfer) begin
                    trans.read = vif.read;
                    trans.write = vif.write;
                    trans.apb_paddr = vif.apb_paddr;
                    trans.apb_write_data = vif.apb_write_data;
                    wait(vif.psel);                              //wait for psel to go high
                    trans.psel = vif.psel;
                    trans.paddr = vif.paddr;
                    trans.pslverr = vif.pslverr;
                    if(vif.write == 1)
                        trans.pwdata = vif.pwdata;
                    wait(vif.penable);
                    if(vif.read) begin
                        //trans.prdata = vif.prdata;
                        wait(vif.apb_read_data_valid);
                        trans.prdata = vif.prdata;
                        trans.apb_read_data_out = vif.apb_read_data_out;
                    end
                    `uvm_info(get_type_name, "from monitor after sampling", UVM_MEDIUM)
                    $display(vif.prdata, " -------------", vif.apb_read_data_out);
                    trans.print();
                    ap.write(trans);
                end
                
            end
            
        end
    end
    join
    endtask
endclass

/*
class apb_monitor extends uvm_monitor;
    virtual apb_if vif;
    uvm_analysis_port #(apb_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            apb_transaction tr = apb_transaction::type_id::create("tr");

            @(posedge vif.pclock);
            if (vif.psel && vif.penable) begin
                tr.paddr = vif.paddr;
                tr.pwdata = vif.pwdata;
                tr.read = !vif.pwrite;
                tr.write = vif.pwrite;
                if (vif.apb_read_data_valid) begin
                    `uvm_info("MONITOR", $sformatf("Read Data Observed: %h", vif.apb_read_data_out), UVM_MEDIUM)
                end
                ap.write(tr);
            end
        end
    endtask
endclass

*/
