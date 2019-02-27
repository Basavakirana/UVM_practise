class rd_seqr extends uvm_sequencer #(rd_trans);

    `uvm_component_utils(rd_seqr)

    extern function new(string name="rd_seqr",uvm_component parent);

endclass

    function rd_seqr :: new(string name="rd_seqr",uvm_component parent);
        super.new(name,parent);
    endfunction
