
// Project: APB Protocol Top
// Company: FrenusTech Pvt Ltd
// Domain : RTL Design
// Author : Vinay chowdary

`define ADDR_WIDTH_32 										// MACRO of default 32 bit
//`timescale 1ns / 1ps

module APB_protocol_top 
													   #(	
		`ifdef ADDR_WIDTH_32
		parameter 	ADDR_WIDTH = 32						,	// 32 bit address bit
		parameter 	DATA_WIDTH = 32							// 32 bit data bit
		  
		`else
		parameter 	ADDR_WIDTH = 64						,	// 64 bit address bit
		parameter 	DATA_WIDTH = 64							// 64 bit data bit
		  
		`endif
														)
														(
		// Inputs of APB Top
		
		input 		pclock								, 	// System clock
		input		presetn								, 	// Active low reset signal
		input 		transfer							, 	// Indicates start of transaction
		input 		read_write							, 	// read write signal 1 for read, 0 for write
		input 		[ADDR_WIDTH-1:0] apb_write_paddr	, 	// write address
		input 		[DATA_WIDTH-1:0] apb_write_data		, 	// write data
		input 		[ADDR_WIDTH-1:0] apb_read_paddr		, 	// read address
					
		//Outputs of APB Top
		
		output 		[DATA_WIDTH-1:0] apb_read_data_out		// data out signal of top
													   );

		// Declaration of wires
		
		wire [ADDR_WIDTH-1:0] paddr;
		wire [DATA_WIDTH-1:0] pwdata;
		wire [DATA_WIDTH-1:0] prdata;
		wire [DATA_WIDTH-1:0] prdata1;
		wire [DATA_WIDTH-1:0] prdata2;
		wire penable;
		wire pwrite;
		wire pready;
		wire pready1;
		wire pready2;
		wire pslverr;
		wire pslverr1; 
		wire pslverr2;
		wire psel1;
		wire psel2;

		//APB Master Instantiation
		
		apb_master M1 									( 
				.pclock(pclock)							, 
				.presetn(presetn)						, 
				.prdata(prdata)							, 
				.pready(pready)							, 
				.pslverr(pslverr)						, 
				.psel1(psel1)							, 
				.psel2(psel2)							, 
				.penable(penable)						, 
				.pwrite(pwrite)							, 
				.paddr(paddr)							,
				.pwdata(pwdata)							, 
				.apb_write_data(apb_write_data)			, 
				.apb_read_data_out(apb_read_data_out)	, 
				.read_write(read_write)					, 
				.transfer(transfer)						, 
				.apb_write_paddr(apb_write_paddr)		, 
				.apb_read_paddr(apb_read_paddr)
													   );

		//APB Slave1 Instantiation
		apb_slave1 S1 									(
				.pclock(pclock)							, 
				.presetn(presetn)						,
				.psel1(psel1)							, 
				.penable(penable)						, 
				.pwrite(pwrite)							, 
				.paddr(paddr)							, 
				.pwdata(pwdata)							, 
				.prdata1(prdata1)						, 
				.pready1(pready1)						, 
				.pslverr1(pslverr1)
													   );

		//APB Slave2 Instantiation
		apb_slave2 S2 									(
				.pclock(pclock)							,
				.presetn(presetn)						, 
				.psel2(psel2)							, 
				.penable(penable)						, 
				.pwrite(pwrite)							, 
				.paddr(paddr)							,
				.pwdata(pwdata)							, 
				.prdata2(prdata2)						, 
				.pready2(pready2)						, 
				.pslverr2(pslverr2)
													   );

	assign pready = paddr[ADDR_WIDTH-1] ? pready2 : pready1 ;

	assign pslverr = paddr[ADDR_WIDTH-1] ? pslverr2 : pslverr1 ;

	assign prdata = paddr[ADDR_WIDTH-1] ? prdata2 : prdata1 ;

endmodule
