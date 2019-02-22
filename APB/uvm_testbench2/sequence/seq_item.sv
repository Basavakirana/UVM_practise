// Transaction Class
class apb_transaction extends uvm_sequence_item;
  `uvm_object_utils(apb_transaction)

  // Fields
  bit transfer;
  bit read;
  bit write;
  bit [31:0] apb_paddr;
  bit [31:0] apb_write_data;
  bit [31:0] apb_read_data_out;
  bit apb_read_data_valid;

  // Constructor
  function new(string name = "apb_transaction");
    super.new(name);
  end

  // Field automation for randomization and printing
  `uvm_field_bit(transfer, UVM_ALL_ON)
  `uvm_field_bit(read, UVM_ALL_ON)
  `uvm_field_bit(write, UVM_ALL_ON)
  `uvm_field_int(apb_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_write_data, UVM_ALL_ON)
  `uvm_field_int(apb_read_data_out, UVM_ALL_ON)
  `uvm_field_bit(apb_read_data_valid, UVM_ALL_ON)

endclass
