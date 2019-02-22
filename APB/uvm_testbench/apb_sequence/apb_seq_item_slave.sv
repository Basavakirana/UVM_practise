class apb_slave_transaction extends uvm_sequence_item;
    rand bit [31:0] prdata;                 // Data to send in response to read transactions
    rand bit pready;                        // Ready signal, indicates slave is ready
    rand bit pslverr;                       // Error signal for failure responses
    rand bit wait_no_wait_status;           // whether to make master wait or no
    rand bit [2:0] no_of_wait_cycles;       // no of cycles of wait to be inserted


   // constraint wait_for_pready { (wait_no_wait_status== 0) -> no_of_wait_cycles  == 0; }
   // constraint pslverr_cont {pslverr dist { 0:=1,1:=1};}
    // Constructor
    function new(string name = "apb_slave_transaction");
        super.new(name);
    endfunction

    // UVM Macros for factory registration and debugging
    `uvm_object_utils_begin(apb_slave_transaction)
        `uvm_field_int(prdata, UVM_ALL_ON)
        `uvm_field_int(pready, UVM_ALL_ON)
        `uvm_field_int(pslverr, UVM_ALL_ON)
    `uvm_object_utils_end
endclass
