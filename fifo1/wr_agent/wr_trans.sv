class wr_trans extends uvm_sequence_item;

    `uvm_object_utils(wr_trans)

    extern function new(string name="wr_trans");

endclass

    function wr_trans :: new(string name="wr_trans");
        super.new(name);
    endfunction
