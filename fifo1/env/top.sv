module top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import test_pkg::*;

    initial begin
        run_test("test");
    end

endmodule
