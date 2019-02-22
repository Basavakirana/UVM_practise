interface intf(input logic pclock);						 // APB clock source  
		logic 		presetn;							// Active low reset signal
					
		//Signals comming from JTAG
		
		logic 		transfer;							 // Indicates start of transaction coming from APB_Master_Slave_Top
		logic 		read	;							 // Indicates read operation coming from APB_Master_Slave_Top
		logic 		write	;							 // Indicates write operation coming from APB_Master_Slave_Top
		logic 		[32-1:0] apb_paddr;			 // Address signal coming from APB_Master_Slave_Top
		logic 		[32-1:0] apb_write_data;		 // Write data coming from APB_Master_Slave_Top
					
		//Signals comming from the APB Slave
		
		logic 		[32-1:0] prdata ;				 // Read data coming from Slave
		logic 		pready			;					 // Ready signal which represents Slave is ready to write or read
		logic 		pslverr			;					 // Pslverr signal indicates failure of transfer

		//outputs of APB Master
		
		logic 		psel			;					 // Signal to select APB Slave 
		logic 		pwrite			;					 // Indicates write or read operation to be performed to Slave
		logic 	    penable			;					 // Enable signal indicates its ACCESS state
		logic    	[32-1:0] paddr	;			 // Address signal going to Slave
		logic    	[32-1:0] pwdata	;			 // Write data going to APB Slave
		logic    	[32-1:0] apb_read_data_out;	 // Data read from Slave in read operation  
		logic    	apb_read_data_valid		  ;			 // Data valid signal


/*
property reset_behavior_check;
  @(posedge pclk) (!presetn) |-> (!psel && !penable && paddr == '0 && pwdata == '0);
endproperty

assert property (reset_behavior_check)
  else `uvm_error(get_type_name, "Signals are not reset to default values when presetn is deasserted.");


property setup_phase_stability;
  @(posedge pclk) disable iff (presetn == 0)
    psel && !penable |-> $stable(paddr) && $stable(pwrite) && $stable(pwdata);
endproperty

assert property (setup_phase_stability)
  else `uvm_error(get_type_name, "Setup phase signals are not stable before penable is asserted.");

property enable_phase_check;
  @(posedge pclk) disable iff (presetn == 0)
    psel && !penable |-> ##1 penable;
endproperty

assert property (enable_phase_check)
  else `uvm_error(get_type_name, "penable is not asserted correctly in the enable phase.");

property penable_single_cycle;
  @(posedge pclk) disable iff (presetn == 0)
    penable |-> !penable ##1;
endproperty

assert property (penable_single_cycle)
  else `uvm_error(get_type_name, "penable remains high for more than one cycle.");


property read_data_validity;
  @(posedge pclk) disable iff (presetn == 0)
    (psel && !pwrite && penable) |-> (pready |-> prdata !== 'x);
endproperty

assert property (read_data_validity)
  else `uvm_error(get_type_name, "prdata is invalid when pready is asserted during a read transaction.");

 
property write_data_stability;
  @(posedge pclk) disable iff (presetn == 0)
    (psel && pwrite) |-> $stable(pwdata);
endproperty

assert property (write_data_stability)
  else `uvm_error(get_type_name, "pwdata is not stable during the write transaction.");

property no_overlapping_transactions;
  @(posedge pclk) disable iff (presetn == 0)
    psel && penable && pready |-> ##1 !psel;
endproperty

assert property (no_overlapping_transactions)
  else `uvm_error(get_type_name, "Overlapping transactions detected."); 

property read_data_validity;
  @(posedge pclk) disable iff (presetn == 0)
    (psel && !pwrite && penable) |-> (pready |-> prdata !== 'x);
endproperty

assert property (read_data_validity)
  else `uvm_error(get_type_name, "prdata is invalid when pready is asserted during a read transaction.");

property address_alignment;
  @(posedge pclk) disable iff (presetn == 0)
    psel |-> (paddr[1:0] == 2'b00);
endproperty

assert property (address_alignment)
  else `uvm_error(get_type_name, "paddr is not properly aligned.");
*/        
/*
    property check_penable_low_on_psel;
        @(posedge  pclock) disable iff (!presetn)
        $rose( psel) |-> $fell( penable);
    endproperty

    property check_penable_on_next_cycle;
        @(posedge  pclock) disable iff (!presetn)
        $rose( psel) |=> $rose( penable);
    endproperty

        
    

    assert property (check_penable_low_on_psel);
    assert property (check_penable_on_next_cycle);
 */               
endinterface
/*
interface apb_if #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32)
(
    input logic pclock,
    input logic presetn
);
    // APB Master Outputs
    logic psel;
    logic penable;
    logic pwrite;
    logic [ADDR_WIDTH-1:0] paddr;
    logic [DATA_WIDTH-1:0] pwdata;

    // APB Master Inputs
    logic transfer;
    logic read;
    logic write;
    logic [ADDR_WIDTH-1:0] apb_paddr;
    logic [DATA_WIDTH-1:0] apb_write_data;

    // APB Slave Inputs
    logic [DATA_WIDTH-1:0] prdata;
    logic pready;
    logic pslverr;

    // APB Master Outputs
    logic [DATA_WIDTH-1:0] apb_read_data_out;
    logic apb_read_data_valid;
endinterface
*/
/*
interface jtag_master_if #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32)(input pclock);

    logic transfer;                    // Indicates start of transaction
    logic read;                        // Read operation signal
    logic write;                       // Write operation signal
    logic [ADDR_WIDTH-1:0] apb_paddr;  // Address signal
    logic [DATA_WIDTH-1:0] apb_write_data; // Write data
    logic [DATA_WIDTH-1:0] apb_read_data_out; // Read data from APB
    logic apb_read_data_valid;         // Data valid signal

endinterface

interface apb_if #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32)(input pclock);

    //logic pclk;                        // APB clock
    logic presetn;                     // Active low reset
    logic [ADDR_WIDTH-1:0] paddr;      // Address bus
    logic psel;                        // Select signal
    logic penable;                     // Enable signal
    logic pwrite;                      // Write signal
    logic [DATA_WIDTH-1:0] pwdata;     // Write data
    logic [DATA_WIDTH-1:0] prdata;     // Read data
    logic pready;                      // Ready signal
    logic pslverr;                     // Slave error signal

endinterface
*/
