module apb_slave(
    input pclk,
    input prst_n,
    input i_pready,
    input [31:0] i_prdata,
    input [31:0] paddr,
    input [31:0] pwdata,
    input pwrite,
    input pen,
    input psel,
    output reg [31:0]o_prdata,
    output reg o_pready

    Hai Bro 

);

reg memory[*];
  always @(posedge pclk)
    begin
        if(!prst_n)
        begin
            o_prdata = 0;
            o_pready  = 0;
        end

        else
        begin
          if(psel)
            begin
              @(posedge pclk);
                o_pready = i_pready;
            end
          if(psel && pen)
            begin
              if(pwrite && i_pready)
                begin
                  mem[paddr]  = pwdata;
                end
              else if(!pwrite && i_pready)
              begin
                o_prdata = i_prdata;
              end
        end
        end
        end
                
