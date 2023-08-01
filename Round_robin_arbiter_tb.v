`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 22:08:13
// Design Name: 
// Module Name: Round_robin_arbiter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Round_robin_arbiter_tb();

reg             clk;    
reg             rst;    
reg             req3;   
reg             req2;   
reg             req1;   
reg             req0;   
wire            gnt3;   
wire            gnt2;   
wire            gnt1;   
wire            gnt0;  
integer i;
// Clock generator
always #1 clk = ~clk;
Round_robin_arbiter r1 (
 clk,    
 rst,    
 req3,   
 req2,   
 req1,   
 req0,   
 gnt3,   
 gnt2,   
 gnt1,   
 gnt0   
);

initial begin
  clk = 0;
  rst = 1;
  req0 = 0;
  req1 = 0;
  req2 = 0;
  req3 = 0;
  #10 rst=0;
  repeat (1) @ (posedge clk);
  req0 <= 1;
  repeat (1) @ (posedge clk);
  req0 <= 0;
  repeat (1) @ (posedge clk);
  req0 <= 1;
  req1 <= 1;
  repeat (1) @ (posedge clk);
  req2 <= 1;
  req1 <= 0;
  repeat (1) @ (posedge clk);
  req3 <= 1;
  req2 <= 0;
  repeat (1) @ (posedge clk);
  req3 <= 0;
  repeat (1) @ (posedge clk);
  req0 <= 0;
  repeat (1) @ (posedge clk);
  req2 <= 1;
  req3 <= 1;
  repeat (1) @(posedge clk);
  req2 <= 0;
  repeat (1) @ (posedge clk)
  #10 $finish;
end 

endmodule
