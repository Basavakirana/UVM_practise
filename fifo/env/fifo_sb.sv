class fifo_sb extends uvm_scoreboard;

    `uvm_component_utils(fifo_sb)

    extern function new(string name="fifo_sb",uvm_component parent);

endclass

    function fifo_sb :: new(string name="fifo_sb",uvm_component parent);
        super.new(name,parent);
    endfunction
