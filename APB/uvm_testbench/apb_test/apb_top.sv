
`timescale 1ns/1ps
module apb_top;

import uvm_pkg::*;
import apb_test_pkg::*;
`include "uvm_macros.svh"

bit clk;

always #10 clk = ~clk;

initial begin
run_test();

end

intf intf_inst (clk);

apb_master dut (   .pclock(clk),								 
		 		        .presetn(intf_inst.presetn),								
		                .transfer(intf_inst.transfer),							 
		                .read(intf_inst.read),								
		                .write(intf_inst.write),								
		                .apb_paddr(intf_inst.apb_paddr),			
		                .apb_write_data(intf_inst.apb_write_data),		
		                .prdata(intf_inst.prdata),
		                .pready(intf_inst.pready),					
		                .pslverr(intf_inst.pslverr),								
		                .psel(intf_inst.psel),								
		                .pwrite(intf_inst.pwrite),								
		                .penable(intf_inst.penable),								 
		                .paddr(intf_inst.paddr),				 
		                .pwdata(intf_inst.pwdata),				 
		                .apb_read_data_out(intf_inst.apb_read_data_out), 
		                .apb_read_data_valid(intf_inst.apb_read_data_valid)
                        );

    initial begin
        uvm_config_db#(virtual intf)::set(uvm_root::get(),"*", "vif",intf_inst);
    end

    initial begin
        $shm_open("wave.shm");
        $shm_probe("ACTMF");
    end

endmodule
