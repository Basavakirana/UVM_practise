package test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "../wr_agent/wr_trans.sv"
    `include "../wr_agent/wr_agt_config.sv"
    `include "../rd_agent/rd_agt_config.sv"
    `include "../env/env_config.sv"
    `include "../wr_agent/wr_drv.sv"
    `include "../wr_agent/wr_mon.sv"
    `include "../wr_agent/wr_seqr.sv"
    `include "../wr_agent/wr_agent.sv"
    `include "../wr_agent/wr_agt_top.sv"
    `include "../wr_agent/wr_seq.sv"

    `include "../rd_agent/rd_trans.sv"
    `include "../rd_agent/rd_mon.sv"
    `include "../rd_agent/rd_seqr.sv"
    `include "../rd_agent/rd_seq.sv"
    `include "../rd_agent/rd_drv.sv"
    `include "../rd_agent/rd_agent.sv"
    `include "../rd_agent/rd_agt_top.sv"

    `include "../env/vseqr.sv"
    `include "../env/vseq.sv"
    `include "../env/sb.sv"

    `include "../env/env.sv"
    `include "../test/test.sv"

endpackage

