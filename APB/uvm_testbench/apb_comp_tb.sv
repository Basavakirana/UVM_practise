`timescale 1ns / 1ps

// UVM Testbench for APB Master
`include "uvm_macros.svh"
`include "apb_sequence.svh"
`include "apb_driver.svh"
`include "apb_monitor.svh"
`include "apb_agent.svh"
`include "apb_env.svh"
`include "apb_test.svh"

module apb_master_tb;

  // Clock and Reset
  bit clk;
  bit rst_n;

  // Interfaces
  apb_if #(32, 32) apb_if_inst();
  jtag_master_if #(32, 32) jtag_if_inst();

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // DUT instantiation
  apb_master #(.ADDR_WIDTH(32), .DATA_WIDTH(32)) dut (
    .apb_port(apb_if_inst),
    .jtag_port(jtag_if_inst)
  );

  // UVM Environment
  initial begin
    uvm_config_db#(virtual apb_if #(32, 32))::set(null, "*", "vif_apb", apb_if_inst);
    uvm_config_db#(virtual jtag_master_if #(32, 32))::set(null, "*", "vif_jtag", jtag_if_inst);

    run_test();
  end

endmodule

// Sequence
class apb_sequence extends uvm_sequence#(apb_transaction);
  `uvm_object_utils(apb_sequence)

  function new(string name = "apb_sequence");
    super.new(name);
  end

  task body();
    apb_transaction tr;

    tr = apb_transaction::type_id::create("tr");

    // Example: Write transaction
    tr.transfer = 1;
    tr.write = 1;
    tr.read = 0;
    tr.apb_paddr = 32'h0000_0004;
    tr.apb_write_data = 32'hDEADBEEF;
    start_item(tr);
    finish_item(tr);

    // Example: Read transaction
    tr.transfer = 1;
    tr.write = 0;
    tr.read = 1;
    tr.apb_paddr = 32'h0000_0008;
    start_item(tr);
    finish_item(tr);
  end

endclass

// Driver
class apb_driver extends uvm_driver#(apb_transaction);
  `uvm_component_utils(apb_driver)

  virtual apb_if #(32, 32) vif_apb;
  virtual jtag_master_if #(32, 32) vif_jtag;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  end

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if #(32, 32))::get(this, "", "vif_apb", vif_apb))
      `uvm_fatal("NOVIF", "No virtual interface specified for APB!");
    if (!uvm_config_db#(virtual jtag_master_if #(32, 32))::get(this, "", "vif_jtag", vif_jtag))
      `uvm_fatal("NOVIF", "No virtual interface specified for JTAG!");
  end

  task run_phase(uvm_phase phase);
    forever begin
      apb_transaction tr;
      seq_item_port.get_next_item(tr);

      vif_jtag.transfer = tr.transfer;
      vif_jtag.read = tr.read;
      vif_jtag.write = tr.write;
      vif_jtag.apb_paddr = tr.apb_paddr;
      vif_jtag.apb_write_data = tr.apb_write_data;

      // Wait for APB response
      @(posedge vif_apb.pclk);
      wait (vif_apb.pready);

      if (tr.read)
        tr.apb_read_data_out = vif_apb.prdata;

      seq_item_port.item_done();
    end
  end

endclass

// Monitor
class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual apb_if #(32, 32) vif_apb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  end

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if #(32, 32))::get(this, "", "vif_apb", vif_apb))
      `uvm_fatal("NOVIF", "No virtual interface specified for APB!");
  end

  task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif_apb.pclk);
      // Monitor transactions here
    end
  end

endclass

// Environment
class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)

  apb_agent apb_agent_inst;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  end

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_agent_inst = apb_agent::type_id::create("apb_agent_inst", this);
  end

endclass

// Test
class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)

  apb_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  end

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  end

  task run_phase(uvm_phase phase);
    apb_sequence seq;
    phase.raise_objection(this);

    seq = apb_sequence::type_id::create("seq");
    seq.start(env.apb_agent_inst.sequencer);

    phase.drop_objection(this);
  end

endclass

