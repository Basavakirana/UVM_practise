class wr_seqr extends uvm_sequencer #(wr_trans);

    `uvm_component_utils(wr_seqr)

    extern function new(string name="wr_seqr",uvm_component parent);

endclass

    function wr_seqr :: new(string name="wr_seqr",uvm_component parent);
        super.new(name);
    endfunction
