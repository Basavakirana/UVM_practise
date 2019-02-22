class fifo_seqr extends uvm_sequencer #(fifo_trans);

    `uvm_component_utils(fifo_seqr)

    extern function new(string name="fifo_seqr",uvm_component parent);

endclass

    function fifo_seqr :: new(string name="fifo_seqr",uvm_component parent);
        super.new(name,parent);
    endfunction
