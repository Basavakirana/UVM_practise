module apb_slave(
    input pclk,
    input prst_n,
    input [31:0] i_prdata,
    input [31:0] paddr,
    input [31:0] pwdata,
    input pwrite,
    input pen,
    input psel,
    output reg [31:0]o_prdata,
    output reg o_pready

);

   logic [31:0] mem[31:0];

  always @(posedge pclk)
    begin
        if(!prst_n)
        begin
            o_prdata = 0;
            o_pready = 0;
        end

    end
       
       always@(pen)
         begin
            if(psel && pen)
              o_pready = 1;
            else
              o_pready = 0;
         end

       always@(o_pready)
         begin
            if(pwrite && pen && psel && o_pready)
                begin
                  mem[paddr]  = pwdata;
                end
              else if(!pwrite && pen && psel && o_pready)
              begin
                   o_prdata = mem[paddr];
              end
         end


   endmodule              
