/*class apb_sequence_write extends uvm_sequence#(apb_seq_item);
    
    `uvm_object_utils(apb_sequence_write)

    function new(string name = "");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_do_with(req,{read ==0; write ==1;})
        //apb_seq_item seq = apb_seq_item::type_id::create("seq");
        //wait_for_grant();
        //seq.randomize() with {read ==0; write == 1; };
        //send_request(seq);
        //wait_for_item_done;
        //get_response(rsp);
        
        //start_item(seq);
        //finish_item(seq);
    endtask
    
    task post_body();
        if(!rsp.pready)
            seq.rand_mode(0);
        else
            seq.rand_mode(1);
    endtask
    
endclass
*/
class base_sequence extends uvm_sequence#(apb_jtag_transaction);
    bit reset;
    bit write;
    bit read;

    function new(string name = "base_sequence");
        super.new(name);
    endfunction

endclass
class apb_jtag_write_sequence extends uvm_sequence #(apb_jtag_transaction);

    `uvm_object_utils(apb_jtag_write_sequence)
    bit reset;
    bit write;
    bit read;

    function new(string name = "apb_jtag_write_sequence");
        super.new(name);
    endfunction

    task body();
        apb_jtag_transaction tr;
        //foreach (10) begin
        `uvm_info(get_type_name, "in sequene body", UVM_MEDIUM) 
        tr = apb_jtag_transaction::type_id::create("write_transaction");
        assert(tr.randomize() with {
                presetn == !reset;
                //transfer == 1;
                tr.read == read;
                tr.write == write;
            });
        start_item(tr);
        finish_item(tr);
        `uvm_info(get_type_name, "jtag sequence completed", UVM_MEDIUM) 
        //end
    endtask
endclass


class apb_jtag_read_sequence extends base_sequence;

    `uvm_object_utils(apb_jtag_read_sequence)
    bit reset;
    bit write;
    function new(string name = "apb_jtag_read_sequence");
        super.new(name);
    endfunction

    task body();
        apb_jtag_transaction tr;
        //foreach (10) begin
        `uvm_info(get_type_name, "in sequene body", UVM_MEDIUM) 
        tr = apb_jtag_transaction::type_id::create("read_transaction");
        assert(tr.randomize() with {
                presetn == !reset;
                transfer == 1;
                read == !write;
                write == write;// write;
            });
        start_item(tr);
        finish_item(tr);
        
        tr.read = 1;
        tr.write = 0;
       // `uvm_send(tr)
        //`uvm_info(get_type_name, "jtag sequence completed", UVM_MEDIUM) ;
        //end
    endtask
endclass

class apb_random_sequence extends base_sequence;

    `uvm_object_utils(apb_random_sequence)
    bit reset;
    bit write;
    function new(string name = "apb_jtag_read_sequence");
        super.new(name);
    endfunction

    task body();
        apb_jtag_transaction tr;
        //foreach (10) begin
        `uvm_info(get_type_name, "in sequene body", UVM_MEDIUM) 
        tr = apb_jtag_transaction::type_id::create("read_transaction");
        assert(tr.randomize()); //with {
               // presetn == !reset;
               // transfer == 1;
           // });
        start_item(tr);
        finish_item(tr);
        
    endtask
endclass

class apb_jtag_custom_write_sequence extends uvm_sequence #(apb_jtag_transaction);

    `uvm_object_utils(apb_jtag_custom_write_sequence)
    apb_jtag_transaction tr;
    bit reset;
    bit write;
    bit read;
    bit [31:0] addr;

    function new(string name = "apb_jtag_custom_write_sequence");
        super.new(name);
        tr = apb_jtag_transaction::type_id::create("write_transaction");
    endfunction

    task body();
        
        //foreach (10) begin
        `uvm_info(get_type_name, "in sequene body", UVM_MEDIUM) 
        
       
        //writing to random addr
        start_item(tr);
        if(write)
            assert(tr.randomize() with {
                presetn == !reset;
                transfer == 1;
                tr.read ==0;// read;
                tr.write ==1;// write;
            });
        else if(read)
            assert(tr.randomize() with {
                presetn == !reset;
                transfer == 1;
                tr.read == 1;// read;
                tr.write == 0;// write;
                tr.apb_paddr == addr;
            });

        finish_item(tr);
        addr = tr.apb_paddr;

        //reading from same addr
        //tr.read = 1;
        //tr.write = 0;
        
        //start_item(tr);

        //finish_item(tr);
        `uvm_info(get_type_name, "jtag sequence completed", UVM_MEDIUM) 
        //end
    endtask
endclass

