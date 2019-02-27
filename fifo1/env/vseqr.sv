class vseqr extends uvm_sequencer #(uvm_sequence_item);

    `uvm_component_utils(vseqr)

    extern function new(string name="vseqr",uvm_component parent);

endclass

    function vseqr :: new(string name="vseqr",uvm_component parent);
        super.new(name,parent);
    endfunction
