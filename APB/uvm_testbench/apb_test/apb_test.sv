/*class apb_test extends uvm_test;
    `uvm_component_utils(apb_test)
    apb_environment env;
    
    function new (string name ="", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        env = apb_environment("env",this);
    endfunction

    task run_phase(uvm_phase phase);
    phase.raise_objection(this);
        if($test$plusargs("read"))begin
            apb_sequence_read seq;
            seq = apb_sequence_read::type_id::create("seq");
            seq.start(env.apj.seqr);
            end
        else if($test$plusargs("write")) begin
            apb_sequence_write seq;
            seq = apb_sequence_write::type_id::create("seq");
            seq.start(env.apj.seqr);
            end
        else if($test$plusargs("read") && $test$plusargs("write"))
            `uvm_fatal("test_args","invalid test args")
        else 
            `uvm_fatal("test_args","invalid test args")
    phase.drop_objection(this);
    endtask

endclass
*/
class apb_base_test extends uvm_test;
    `uvm_component_utils(apb_base_test)
    apb_environment env;

    function new(string name = "apb_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        env = apb_environment::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);

            
        // Start master sequences
        phase.drop_objection(this);
    endtask
endclass

class apb_write_test extends apb_base_test;
    `uvm_component_utils(apb_write_test)

    apb_jtag_write_sequence jseq;
    apb_slave_fixed_response_seq slseq;

    function new(string name = "apb_write_test", uvm_component parent = null);
        super.new(name, parent);
        jseq = apb_jtag_write_sequence::type_id::create("jseq");
        slseq = apb_slave_fixed_response_seq::type_id::create("slseq");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset test
        jseq.reset = 1;
        jseq.write = 0;
        jseq.read = 0;
        slseq.ready = 0;
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        //single write test
        jseq.reset = 0;
        jseq.write = 1;
        jseq.read = 0;
        slseq.ready = 1;
        repeat (2) begin
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        end

        phase.drop_objection(this);
    endtask
endclass

class apb_read_test extends apb_base_test;
    `uvm_component_utils(apb_read_test)

    apb_jtag_write_sequence jseq;
    apb_slave_fixed_response_seq slseq;

    function new(string name = "apb_read_test", uvm_component parent = null);
        super.new(name, parent);
        jseq = apb_jtag_write_sequence::type_id::create("jseq");
        slseq = apb_slave_fixed_response_seq::type_id::create("slseq");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset test
        jseq.reset = 1;
        jseq.write = 0;
        jseq.read = 0;
        slseq.ready = 0;
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        //single write test
        jseq.reset = 0;
        jseq.write = 0;
        jseq.read = 1;
        slseq.ready = 1;
        //repeat (50) begin
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        //end

        phase.drop_objection(this);
    endtask
endclass


class apb_random_test extends apb_base_test;
    `uvm_component_utils(apb_random_test)

    apb_random_sequence jseq;
    apb_slave_fixed_response_seq slseq;

    function new(string name = "apb_read_test", uvm_component parent = null);
        super.new(name, parent);
        jseq = apb_random_sequence::type_id::create("jseq");
        slseq = apb_slave_fixed_response_seq::type_id::create("slseq");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset test
        jseq.reset = 1;
        jseq.write = 0;
        jseq.read = 0;
        slseq.ready = 0;
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        //single write test
        jseq.reset = 0;
        //jseq.write = 0;
        //jseq.read = 1;
        slseq.ready = 1;
        repeat (50) begin
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        end

        phase.drop_objection(this);
    endtask
endclass

class apb_custom_write_test extends apb_base_test;
    `uvm_component_utils(apb_custom_write_test)

    apb_jtag_custom_write_sequence jseq;
    apb_slave_fixed_response_seq slseq;

    function new(string name = "apb_custom_write_test", uvm_component parent = null);
        super.new(name, parent);
        jseq = apb_jtag_custom_write_sequence::type_id::create("jseq");
        slseq = apb_slave_fixed_response_seq::type_id::create("slseq");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset test
        jseq.reset = 1;
        jseq.write = 0;
        jseq.read = 0;
        slseq.ready = 0;
        fork
            jseq.start(env.apj.seqr);
            slseq.start(env.aps.seqr);
        join
        //single write test
        
        
        jseq.reset = 0;
        //jseq.write = 0;
        //jseq.read = 1;
        slseq.ready = 1;
        
        repeat (3) begin
            jseq.write = 1;
            jseq.read = 0;
            fork
                jseq.start(env.apj.seqr);
                slseq.start(env.aps.seqr);
            join

            jseq.write = 0;
            jseq.read = 1;
            fork
                jseq.start(env.apj.seqr);
                slseq.start(env.aps.seqr);
            join
        end

        phase.drop_objection(this);
    endtask
endclass
