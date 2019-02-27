
/*
    `include "fifo_env_config.sv"
    `include "fifo_agt_config.sv"
    `include "fifo_trans.sv"
    `include "fifo_seq.sv"    
    `include "fifo_drv.sv"
    `include "fifo_seqr.sv"    
    `include "fifo_mon.sv"
    `include "fifo_agt_top.sv"
    `include "fifo_agent.sv"
    `include "fifo_sb.sv"
    `include "fifo_env.sv"
    `include "fifo_test.sv"  */

module fifo_top;

   // `include "uvm_pkg.sv"
    import uvm_pkg::*;
    import test_pkg::*;
   // `include "uvm_macros.svh"

    

    initial begin
        run_test("fifo_test");
    end

endmodule

