package test_pkg;
   // `include "uvm_pkg.sv"
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "../agent/fifo_trans.sv"
    `include "../agent/fifo_agt_config.sv"
    `include "../env/fifo_env_config.sv"
    `include "../agent/fifo_drv.sv"
    `include "../agent/fifo_mon.sv"
    `include "../agent/fifo_seqr.sv"
    `include "../agent/fifo_agent.sv"
    `include "../agent/fifo_agt_top.sv"
    `include "../agent/fifo_seq.sv"

    `include "../env/fifo_sb.sv"
    `include "../env/fifo_env.sv"
    `include "../fifo_test.sv"

endpackage
