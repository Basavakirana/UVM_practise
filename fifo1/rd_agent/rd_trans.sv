class rd_trans extends uvm_sequence_item;

    `uvm_object_utils(rd_trans)

    extern function new(string name="rd_trans");

endclass

    function rd_trans :: new(string name="rd_trans");
        super.new(name);
    endfunction
