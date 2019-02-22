module apb_top;
    reg clk;
    reg rst;
    reg [31:0] paddr;
    reg [31:0] pwdata;
    reg pwrite;
    int location_index;

    wire pready_w;
    wire [31:0] prdata_w;
    wire [31:0] pwdata_w;
    wire psel_w;
    wire [31:0] paddr_w;
    wire pwrite_w;
    wire pen_w;
    
    initial begin
      clk = 0;
    end

    always #5 clk = ~clk;

    initial
    begin
      rst =  0;
      paddr = 0;
      pwdata = 0;
      pwrite = 0;
      repeat(2)@(negedge clk);
      rst = 1;

      // write 
      repeat(2)@(negedge clk)
      begin
      pwrite = 1;
      paddr = 32'd31;
      pwdata = $urandom();
      repeat(2)@(negedge clk);
      end

      repeat(2)@(negedge clk)
      begin
      paddr  = 32'd30;
      pwdata =  $urandom();
      repeat(2)@(negedge clk);
     end

      // Read
      repeat(2)@(negedge clk);
      pwrite = 0;
      paddr  = 32'd31;
      repeat(2)@(negedge clk);
      pwrite = 0;
      paddr  = 32'd30;



      for (location_index=31; location_index>=0;location_index=location_index-1 )
          begin
            // write 
            repeat(2)@(negedge clk) // continous two times write in each location
            begin
                pwrite = 1;
                paddr = location_index;
                pwdata = $urandom();
                repeat(2)@(negedge clk);

            end

          end

      for (location_index=31; location_index>=0;location_index=location_index-1 )
          begin
            // read
            repeat(2)@(negedge clk) // continous two times write in each location
            begin

                repeat(2)@(negedge clk);
                pwrite = 0;
                paddr  = location_index;
            end

          end



      #500 $finish;
    end
    apb_master MASTER(
    .pclk          (clk),
    .prst_n         (rst),
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
    .paddr         (paddr_w),
    .pwdata        (pwdata_w),
    .pwrite        (pwrite_w),
    .pen           (pen_w),
    .psel          (psel_w),
    .o_prdata      (prdata_w),
    .o_pready      (pready_w)
    );
 initial 
    begin
      $shm_open("wave.shm");
      $shm_probe("ACTMF");
    end
    endmodule

    
