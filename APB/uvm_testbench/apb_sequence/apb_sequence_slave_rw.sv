class apb_slave_fixed_response_seq extends uvm_sequence #(apb_slave_transaction);
    bit ready;
    bit error;
    `uvm_object_utils(apb_slave_fixed_response_seq)

    function new(string name = "apb_slave_fixed_response_seq");
        super.new(name);
    endfunction

    task body();
        apb_slave_transaction tr;
        //foreach (tr) begin
            `uvm_info(get_type_name, "in sequence body", UVM_MEDIUM) 
            tr = apb_slave_transaction::type_id::create("slave_fixed_response");
            //tr.prdata = $urandom; // Generate random read data
            //tr.pready = ready;        // Always ready
            //tr.pslverr = 1;       // No error
            start_item(tr);
            tr.randomize with {pready == 1;};
            finish_item(tr);
            $display("the value of slave error is %d",tr.pslverr);
            `uvm_info(get_type_name, "slave sequence completed", UVM_MEDIUM) 
       // end
    endtask
endclass
