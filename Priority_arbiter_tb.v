`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 19:04:28
// Design Name: 
// Module Name: Priority_arbiter_tb
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


module Priority_arbiter_tb();
reg req0,req1,req2,req3,req4,reset,clock;
wire gnt0,gnt1,gnt2,gnt3,gnt4;
integer i;
arbiter n1(clock,reset,req0,req1,req2,req3,req4,gnt0,gnt1,gnt2,gnt3,gnt4);
always #5 clock=~clock;

initial begin
clock=1;
#10 reset=1;
#380 $finish;
end
initial begin
for(i=0;i<32;i=i+1)begin
reset=0;
{req0,req1,req2,req3,req4}=i;
#10;
end
{req0,req1,req2,req3,req4}=0;#50;
{req0,req1,req2,req3,req4}=5'b00110;#10;
end
endmodule
