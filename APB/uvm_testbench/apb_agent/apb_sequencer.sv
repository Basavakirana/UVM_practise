class apb_sequencer_jtag extends uvm_sequencer#(apb_jtag_transaction);
    
    `uvm_component_utils(apb_sequencer_jtag)
    
    function new (string name = "", uvm_component parent );
        super.new(name,parent);
    endfunction

endclass

/*class apb_sequencer_slave extends uvm_sequencer#(apb_seq_item);
    
    `uvm_component_utils(apb_sequencer_slave)

    function new (string name = "", uvm_component parent );
        super.new(name,parent);
    endfunction

endclass*/

