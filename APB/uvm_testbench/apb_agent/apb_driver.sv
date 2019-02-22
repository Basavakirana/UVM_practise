class apb_driver_jtag extends uvm_driver#(apb_jtag_transaction);
    virtual intf vif;
    `uvm_component_utils(apb_driver_jtag)

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name, "build phase started", UVM_MEDIUM) 
        if(!uvm_config_db#(virtual intf)::get(this, "","vif",vif)) `uvm_fatal("intf_driver","interface not found");
    endfunction

    task run_phase(uvm_phase phase);

    forever begin
        seq_item_port.get_next_item(req);
        if(!req.presetn) begin
            //@(negedge vif.pclock);
            reset();
        end
        else begin
            `uvm_info(get_type_name, "write instructions from sequence received given", UVM_MEDIUM)
            req.print();
            vif.presetn <= req.presetn;
            //@(posedge vif.pclock);
            vif.transfer <= req.transfer;// 1'b1;
            vif.read <= req.read;
            vif.write <= req.write;
            vif.apb_paddr <= req.apb_paddr;
            vif.apb_write_data <= req.apb_write_data;
            `uvm_info(get_type_name, "write instructions given", UVM_MEDIUM)
            if(vif.penable == 1) wait(!vif.penable);
            //vif.transfer <= 0;
            //vif.read <= 0;
            //vif.write <= 0;
            `uvm_info(get_type_name, "penable went low", UVM_MEDIUM)
            repeat(10)begin
                @(posedge vif.pclock);
                if(vif.penable) break;
            end
            `uvm_info(get_type_name, "penable went high", UVM_MEDIUM)
            if(!vif.pwrite) begin
                wait(vif.apb_read_data_valid);
                req.apb_read_data_out = vif.apb_read_data_out;
            end

            wait(!vif.penable);
            `uvm_info(get_type_name, "penable went low for next transaction", UVM_MEDIUM)
            `uvm_info(get_type_name, "transaction completed", UVM_MEDIUM)
            //vif.transfer <= 0;
            //vif.read <= 0;
            //vif.write <= 0;
            //vif.apb_paddr <= 0;
            //vif.apb_write_data <= 0;
        end
        seq_item_port.item_done();
    end
    endtask


    task reset();
        //@(negedge vif.pclock);
        vif.presetn <= 1'b0;
        vif.transfer <= 1'b0;
        vif.read <= 1'b0;
        vif.write <= 1'b0;
        vif.apb_paddr <= 1'b0;
        vif.apb_write_data <= 1'b0;
        @(posedge vif.pclock);
        @(negedge vif.pclock);
        //vif.presetn <= 1;
    endtask

endclass

/*class apb_driver extends uvm_driver #(apb_transaction);
    virtual apb_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            apb_transaction tr;
            seq_item_port.get_next_item(tr);

            // Drive signals to start the transaction
            vif.transfer <= tr.transfer;
            vif.read <= tr.read;
            vif.write <= tr.write;
            vif.apb_paddr <= tr.paddr;
            vif.apb_write_data <= tr.pwdata;

            @(posedge vif.pclock);
            vif.psel <= 1;
            vif.penable <= 0;

            @(posedge vif.pclock);
            vif.penable <= 1;

            // Wait for ready
            while (!vif.pready) @(posedge vif.pclock);

            // Check read data validity
            if (tr.read && vif.apb_read_data_valid) begin
                `uvm_info("DRIVER", $sformatf("Read Data: %h", vif.apb_read_data_out), UVM_MEDIUM)
            end

            // Complete transaction
            vif.psel <= 0;
            vif.penable <= 0;
            vif.transfer <= 0;

            seq_item_port.item_done();
        end
    endtask
endclass
*/
