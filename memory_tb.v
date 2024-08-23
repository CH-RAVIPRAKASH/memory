module memory_tb;
parameter SIZE=1024;//1KB
parameter WIDTH=16;
parameter DEPTH=512;
parameter ADDR_WIDTH=$clog2(DEPTH);
reg clk_i,rst_i,valid_i,wr_rd_i;
reg [ADDR_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]wdata_i;
wire [WIDTH-1:0]rdata_o;
wire ready_o;
//reg[WIDTH-1:0] mem[DEPTH-1:0];
integer i;
memory #(.SIZE(SIZE),.WIDTH(WIDTH),.DEPTH(DEPTH),.ADDR_WIDTH(ADDR_WIDTH)) dut(clk_i,rst_i,addr_i,wdata_i,wr_rd_i,valid_i,ready_o,rdata_o);
initial begin
clk_i=0;
forever #1 clk_i = ~clk_i;
end
initial begin
rst_i=1;
addr_i=0;
valid_i=0;
wr_rd_i=0;
wdata_i=0;
#3;
rst_i=0;
for(i=0;i<DEPTH;i=i+1)begin
  @(posedge clk_i)begin
  addr_i=i;
  valid_i=1;
  wdata_i=$random;
  wr_rd_i=1;
  wait(ready_o==1);
  end
end
addr_i=0;
valid_i=0;
wr_rd_i=0;
wdata_i=0;
for(i=0;i<DEPTH;i=i+1) begin
@(posedge clk_i)begin
 addr_i=i;
 valid_i=1;
 wr_rd_i=0;
 wait(ready_o==1);
end
end
addr_i=0;
valid_i=0;
wr_rd_i=0;
wdata_i=0;
@(posedge clk_i) begin
$finish();
end
end
endmodule

