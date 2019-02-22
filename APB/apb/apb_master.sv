module apb_master(
    input pclk,
    input prst_n,
    input [31:0] i_paddr,
    input i_pwrite,
    input [31:0] i_pwdata,
    input pready,
    input [31:0] prdata,
    output reg o_psel,
    output reg o_pen,
    output reg [31:0] o_paddr,
    output reg o_pwrite,
    output reg [31:0] o_pwdata);

   always @(posedge pclk)
     begin
       if(!prst_n)
         begin
           o_psel = 0;
           o_pen = 0;
           o_paddr = 0;
           o_pwrite = 0;
           o_pwdata = 0;
         end

       else
         begin
           o_psel = 1;
           o_pen  = 0;
           o_paddr = i_paddr;
           o_pwrite = i_pwrite;
           o_pwdata = i_pwdata;

           @(posedge pclk);
           o_psel = 1;
           o_pen  = 1;
           o_paddr = i_paddr;
           o_pwrite = i_pwrite;
           o_pwdata = i_pwdata;
         end
       end


endmodule 
           



    
