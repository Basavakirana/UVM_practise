class fifo_seq extends uvm_sequence #(fifo_trans);

    `uvm_object_utils(fifo_seq)

    extern function new(string name="fifo_seq");

endclass

    function fifo_seq :: new(string name="fifo_seq");
        super.new(name);
    endfunction
