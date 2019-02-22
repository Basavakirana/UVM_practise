 class fifo_trans extends uvm_sequence_item;

    `uvm_object_utils(fifo_trans)

    extern function new(string name="fifo_trans");

endclass

    function fifo_trans :: new(string name="fifo_trans");
        super.new(name);
        $display("trans class");
    endfunction
