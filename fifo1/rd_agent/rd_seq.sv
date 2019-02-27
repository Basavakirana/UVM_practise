class rd_seq extends uvm_sequence #(rd_trans);

    `uvm_object_utils(rd_seq)

    extern function new(string name="rd_seq");

endclass

    function rd_seq :: new(string name="rd_seq");
        super.new(name);
    endfunction
