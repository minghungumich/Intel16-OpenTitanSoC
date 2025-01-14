module prim_ram_1p 
import prim_ram_1p_pkg::*;
#(

  parameter  int Width           = 32, // bit
  parameter  int Depth           = 128,
  parameter  int DataBitsPerMask = 1, // Number of data bits per bit of write mask
  parameter      MemInitFile     = "", // VMEM file to initialize the memory width

  localparam int Aw              = $clog2(Depth)  // derived parameter

) (
  input  logic             clk_i,
  input  ram_1p_cfg_t      cfg_i,

  input  logic             req_i,
  input  logic             write_i,
  input  logic [Aw-1:0]    addr_i,
  input  logic [Width-1:0] wdata_i,
  input  logic [Width-1:0] wmask_i,
  output logic [Width-1:0] rdata_o // Read data. Data is returned one cycle after req_i is high.
);

if( Depth == 1024 & Width==22 ) begin
  // $info("otp_ctrl MEM init");
  sram_1024x22_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      (addr_i             ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 128 & Width==312 ) begin
  // $info("otbn DMEM init");
  logic [3:0]           ren_sram;
  logic [3:0]           wen_sram;
  logic [3:0][8:0]      adr_sram;
  logic [3:0][79:0]     din_sram;
  logic [3:0][79:0]     wmask_sram;
  logic [3:0][79:0]     rdata_sram;
  logic [3:0][79:0]     wbeb_sram; 

  assign rdata_o    = {rdata_sram[3][71:0], rdata_sram[2], rdata_sram[1], rdata_sram[0]};;
  assign ren_sram   = {4{req_i & (~write_i)}};
  assign wen_sram   = {4{req_i & write_i}};
  assign adr_sram   = {4{2'b0, addr_i}};
  assign din_sram   = {8'b0, wdata_i};
  assign wbeb_sram  = {8'b1, ~wmask_i};

  sram_512x80_be u_sram [3:0] (
    .clk      (clk_i      ),    //Input Clock
    .ren      (ren_sram   ),    //Read Enable
    .wen      (wen_sram   ),    //Write Enable
    .adr      (adr_sram   ),    //Input Address
    .mc       (3'b0       ),    //Controls extending write duration
    .mcen     (1'b0       ),    //Enable read margin control 
    .clkbyp   (1'b0       ),    //clock bypass enable  
    .din      (din_sram   ),    //Input Write Data 
    .wbeb     (wbeb_sram  ),    //Write Bit enable
    .wa       (2'b0       ),
    .wpulse   (2'b0       ),
    .wpulseen (1'b1       ),
    .fwen     (1'b0       ),
    .q        (rdata_sram )
  );
end else if ( Depth == 256 & Width == 28 ) begin
  // $info("rv_core ibex DMEM & IMEM init");
  sram_512x28_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      ({1'b0,addr_i}      ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 1024 & Width == 39 ) begin
  // $info("sram_ctrl_ret_aon, otbn IMEM init");
  sram_1024x39_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      (addr_i             ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 65536 & Width == 76 ) begin
  // $info("flash_ctrl MEM init");
  // logic [15:0]          ren_sram;
  // logic [15:0]          wen_sram;
  // logic [15:0][11:0]    adr_sram;
  // logic [15:0][75:0]    din_sram;
  // logic [15:0][75:0]    wmask_sram;
  // logic [15:0][75:0]    rdata_sram;
  // logic [15:0][75:0]    wbeb_sram; 
  // logic [15:0]          idx;

  // assign idx      = addr_i[15:12];
  // assign rdata_o  = rdata_sram[idx];

  // for (genvar k = 0; k < 16; k++) begin 
  //   assign ren_sram[k]  = (idx==k) ? (req_i & (~write_i)) : 0;
  //   assign wen_sram[k]  = (idx==k) ? (req_i & write_i) : 0;
  //   assign adr_sram[k]  = (idx==k) ? addr_i[11:0] : 0;
  //   assign din_sram[k]  = (idx==k) ? wdata_i : 0;
  //   assign wbeb_sram[k] = (idx==k) ? (~wmask_i) : {76{1'b1}};
  // end
  // sram_4096x76_be u_sram [15:0] (
  //   .clk      (clk_i      ),  //Input Clock
  //   .ren      (ren_sram   ),  //Read Enable
  //   .wen      (wen_sram   ),  //Write Enable
  //   .adr      (adr_sram   ),  //Input Address
  //   .mc       (3'b0       ),  //Controls extending write duration
  //   .mcen     (1'b0       ),  //Enable read margin control 
  //   .clkbyp   (1'b0       ),  //clock bypass enable  
  //   .din      (din_sram   ),  //Input Write Data 
  //   .wbeb     (wbeb_sram  ),  //Write Bit enable
  //   .wa       (2'b0       ),
  //   .wpulse   (2'b0       ),
  //   .wpulseen (1'b1       ),
  //   .fwen     (1'b0       ),
  //   .q        (rdata_sram )
  // );
  sram_4096x76_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      (addr_i[11:0]       ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 2560 & Width == 76 ) begin
  // $info("flash_ctrl MEM init");
  sram_4096x76_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      (addr_i             ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 32768 & Width == 39 ) begin
  // $info("sram_ctrl_main MEM init");
  // logic [3:0]         ren_sram;
  // logic [3:0]         wen_sram;
  // logic [3:0][12:0]   adr_sram;
  // logic [3:0][38:0]   din_sram;
  // logic [3:0][38:0]   wmask_sram;
  // logic [3:0][38:0]   rdata_sram;
  // logic [3:0][38:0]   wbeb_sram; 
  // logic [1:0]         idx;

  // assign idx      = addr_i[14:13];
  // assign rdata_o  = rdata_sram[idx];

  // for (genvar k = 0; k < 4; k++) begin 
  //   assign ren_sram[k]  = (idx==k) ? (req_i & (~write_i)) : 0;
  //   assign wen_sram[k]  = (idx==k) ? (req_i & write_i) : 0;
  //   assign adr_sram[k]  = (idx==k) ? addr_i[12:0] : 0;
  //   assign din_sram[k]  = (idx==k) ? wdata_i : 0;
  //   assign wbeb_sram[k] = (idx==k) ? (~wmask_i) : {39{1'b1}};
  // end

  // sram_8192x39_be u_sram [3:0] (
  //   .clk      (clk_i      ),    //Input Clock
  //   .ren      (ren_sram   ),    //Read Enable
  //   .wen      (wen_sram   ),    //Write Enable
  //   .adr      (adr_sram   ),    //Input Address
  //   .mc       (3'b0       ),    //Controls extending write duration
  //   .mcen     (1'b0       ),    //Enable read margin control 
  //   .clkbyp   (1'b0       ),    //clock bypass enable  
  //   .din      (din_sram   ),    //Input Write Data 
  //   .wbeb     (wbeb_sram  ),    //Write Bit enable
  //   .wa       (2'b0       ),
  //   .wpulse   (2'b0       ),
  //   .wpulseen (1'b1       ),
  //   .fwen     (1'b0       ),
  //   .q        (rdata_sram )
  // );
  sram_8192x39_be u_sram (
    .clk      (clk_i              ),  //Input Clock
    .ren      (req_i & (~write_i) ),  //Read Enable
    .wen      (req_i & write_i    ),  //Write Enable
    .adr      (addr_i[12:0]       ),  //Input Address
    .mc       (3'b0               ),  //Controls extending write duration
    .mcen     (1'b0               ),  //Enable read margin control 
    .clkbyp   (1'b0               ),  //clock bypass enable  
    .din      (wdata_i            ),  //Input Write Data 
    .wbeb     (~wmask_i           ),  //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else if ( Depth == 256 & Width == 78 ) begin
  // $info("rv_core_ibex MEM init");
  sram_512x78_be u_sram (
    .clk      (clk_i              ),    //Input Clock
    .ren      (req_i & (~write_i) ),    //Read Enable
    .wen      (req_i & write_i    ),    //Write Enable
    .adr      ({1'b0,addr_i}      ),    //Input Address
    .mc       (3'b0               ),    //Controls extending write duration
    .mcen     (1'b0               ),    //Enable read margin control 
    .clkbyp   (1'b0               ),    //clock bypass enable  
    .din      (wdata_i            ),    //Input Write Data 
    .wbeb     (~wmask_i           ),    //Write Bit enable
    .wa       (2'b0               ),
    .wpulse   (2'b0               ),
    .wpulseen (1'b1               ),
    .fwen     (1'b0               ),
    .q        (rdata_o            )
  );
end else begin
  $error("SRAM Depth = %d, Width = %d doesn't exist", Depth, Width);
end

endmodule
