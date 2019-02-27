class sb extends uvm_scoreboard;

    `uvm_component_utils(sb)

    extern function new(string name="sb",uvm_component parent);

endclass

    function sb :: new(string name="sb",uvm_component parent);
        super.new(name,parent);
    endfunction
