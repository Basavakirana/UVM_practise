class wr_seq extends uvm_sequence #(wr_trans);

    `uvm_object_utils(wr_seq)

    extern function new(string name="wr_seq");

endclass

    function wr_seq :: new(string name="wr_seq");
        super.new(name);
    endfunction
