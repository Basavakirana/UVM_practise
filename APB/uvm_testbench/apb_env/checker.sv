class checker extends uvm_subscriber;
    
    `uvm_component_utils(checker)
    
    uvm_analysis_imp#(apb_jtag_transaction, checker) aps;
    apb_jtag_transaction tr;
    function new(string name = "checker");
        super.new(name);
        aps = new("aps", this);
        tr = apb_jtag_transaction::type_id::create("tr_checker");
    endfunction

    property check_penable_low_on_psel;
        @(posedge vif.pclock) disable iff (!vif.presetn);
        $rose(vif.psel) |-> $fell(vif.penable);
    endproperty

    property check_penable_on_next_cycle;
        @(posedge vif.pclock) disable iff (!vif.presetn);
        $rose(vif.psel) |=> $rose(vif.penable);
    endproperty

    property check_for_stability;
        @(posedge vif.pclock) disable iff (!vif.presetn);
        $rose(vif.psel) |-> $stable(vif.paddr) && $stable(vif.pwdata) throughout
        (vif.penable ##1 ($stable(vif.paddr) && $stable(vif.pwdata)));
    endproperty
    
    task run_phase(uvm_phase phase);

        assert property (check_penable_low_on_psel);
        assert property (check_penable_on_next_cycle);
        assert property (check_for_stability);
    endtask

endclass
