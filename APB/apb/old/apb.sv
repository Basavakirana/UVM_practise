module apb_top;
    reg clk;
    reg rst;
    reg pready;
    reg prdata;
    reg paddr;
    reg pwdata
    reg pwrite;
    reg psel;
    reg pen;

    wire pready_w;
    wire prdata_w;


    initial begin
      clk = 0;
    end

    always # clk = ~clk;

    apb_master MASTER(
    .pclk          (clk),
    .prstn         (rst),
    .i_psel        (psel),
    .i_pen         (pen),
    .i_paddr       (paddr),
    .i_pwrite      (pwrite),
    .i_pwdata      (pwdata),
    .pready        (pready_w),
    .prdata        (prdata_w),
    .o_psel        (psel_w),
    .o_pen         (pen_w),
    .o_paddr       (paddr_w),
    .o_pwrite      (pwrite_w),
    .o_pwdata      (pwdata_w)
    );

    apb_slave SLAVE(
    .pclk          (clk),
    .prst_n        (rst),
    .i_pready      (pready),
    .i_prdata      (prdata),
    .paddr         (paddr_w),
    .pwdata        (pwdata_w),
    .pwrite        (pwrite_w),
    .pen           (pen_w),
    .psel          (psel_w),
    .o_prdata      (prdata_w),
    .o_pready      (pready_w),
    );

    
