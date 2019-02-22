class apb_jtag_transaction extends uvm_sequence_item;
					
		//Signals comming from JTAG
rand    bit         presetn		            ;
rand    bit 		transfer                ;	    // Indicates start of transaction coming from APB_Master_Slave_Top
rand	bit 		read					;		// Indicates read operation coming from APB_Master_Slave_Top
rand    bit 		write					;		// Indicates write operation coming from APB_Master_Slave_Top
rand    bit 		[32-1:0] apb_paddr		;	    // Address signal coming from APB_Master_Slave_Top
rand	bit 		[32-1:0] apb_write_data	;	    // Write data coming from APB_Master_Slave_Top
					
		//Signals comming from the APB Slave
		
    	bit 		[32-1:0] prdata			;	    // Read data coming from Slave
        bit 		pready					;	    // Ready signal which represents Slave is ready to write or read
		bit 		pslverr					;		// Pslverr signal indicates failure of transfer

		//outputs of APB Master
		
		bit 		psel					;		// Signal to select APB Slave 
		bit 		pwrite					;		// Indicates write or read operation to be performed to Slave
		bit 	    penable					;		// Enable signal indicates its ACCESS state
	 	bit  	    [32-1:0] paddr			;	    // Address signal going to Slave
		bit  	    [32-1:0] pwdata			;	    // Write data going to APB Slave
		bit  	    [32-1:0] apb_read_data_out;	    // Data read from Slave in read operation  
		bit  	    apb_read_data_valid;					 // Data valid signal



    `uvm_object_utils_begin(apb_jtag_transaction)
        `uvm_field_int(transfer,UVM_ALL_ON)
        `uvm_field_int(read,UVM_DEFAULT)
        `uvm_field_int(write,UVM_DEFAULT)
        `uvm_field_int(apb_paddr,UVM_DEFAULT)
        `uvm_field_int(apb_write_data,UVM_DEFAULT)
        `uvm_field_int(prdata,UVM_DEFAULT)
        `uvm_field_int(pready,UVM_DEFAULT)
        `uvm_field_int(pslverr,UVM_DEFAULT)
        `uvm_field_int(psel,UVM_DEFAULT)
        `uvm_field_int(pwrite,UVM_DEFAULT)
        `uvm_field_int(paddr,UVM_DEFAULT)
        `uvm_field_int(pwdata,UVM_DEFAULT)
        `uvm_field_int(apb_read_data_out,UVM_DEFAULT)
        `uvm_field_int(apb_read_data_valid,UVM_DEFAULT)
    `uvm_object_utils_end
    
    // Constraints
    constraint valid_transaction {
        // Either read or write can be active, not both
        read ^ write;
        // Transfer must be active for any transaction
        transfer == 1;
    }
    
    // Constructor
    function new(string name = "apb_jtag_transaction");
        super.new(name);
    endfunction

endclass
/*
class apb_transaction extends uvm_sequence_item;
    // Transaction control
    rand bit transfer;                 // Indicates start of a transaction
    rand bit read;                     // Indicates read operation
    rand bit write;                    // Indicates write operation
    rand bit [31:0] paddr;             // Address to be accessed
    rand bit [31:0] pwdata;            // Data to be written in write transactions

    // Slave response properties
    bit [31:0] prdata;                 // Data read from the slave
    bit pready;                        // Indicates slave is ready
    bit pslverr;                       // Error response from the slave

    // Expected outputs for functional checking
    bit [31:0] expected_data;          // Expected data for read transactions
    bit data_valid;                    // Indicates if the read data is valid

    // Constraints
    constraint valid_transaction {
        // Either read or write can be active, not both
        read ^ write;
        // Transfer must be active for any transaction
        transfer == 1;
    }

    // Constructor
    function new(string name = "apb_transaction");
        super.new(name);
    endfunction

    // UVM Macros for factory registration and debugging
    `uvm_object_utils_begin(apb_transaction)
        `uvm_field_int(transfer, UVM_ALL_ON)
        `uvm_field_int(read, UVM_ALL_ON)
        `uvm_field_int(write, UVM_ALL_ON)
        `uvm_field_int(paddr, UVM_ALL_ON)
        `uvm_field_int(pwdata, UVM_ALL_ON)
        `uvm_field_int(prdata, UVM_ALL_ON)
        `uvm_field_int(pready, UVM_ALL_ON)
        `uvm_field_int(pslverr, UVM_ALL_ON)
        `uvm_field_int(expected_data, UVM_ALL_ON)
        `uvm_field_int(data_valid, UVM_ALL_ON)
    `uvm_object_utils_end
endclass
*/
