class vseq extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_utils(vseq)

    extern function new(string name="vseq");

endclass

    function vseq :: new(string name="vseq");
        super.new(name);
    endfunction
