`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 19:02:57
// Design Name: 
// Module Name: Priority_arbiter
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


module Priority_arbiter(
clock , // Clock
reset , // Active high reset
req_0 , // Active high request from agent 0
req_1 , // Active high request from agent 1
req_2 , // Active high request from agent 2
req_3 , // Active high request from agent 3
req_4 , // Active high request from agent 4
gnt_0 , // Active high grant to agent 0
gnt_1 , // Active high grant to agent 1
gnt_2 , // Active high grant to agent 2
gnt_3 , // Active high grant to agent 3
gnt_4   // Active high grant to agent 4
);
// Port declaration here
input clock ; // Clock
input reset ; // Active high reset
input req_0 ; // Active high request from agent 0
input req_1 ; // Active high request from agent 1
input req_2 ; // Active high request from agent 2
input req_3 ; // Active high request from agent 3
input req_4 ;
output gnt_0 ; // Active high grant to agent 0
output gnt_1 ; // Active high grant to agent 1
output gnt_2 ; // Active high grant to agent 2
output gnt_3 ; // Active high grant to agent 3
output gnt_4 ; // Active high grant to agent 4

// Internal Variables
reg gnt_0 ; // Active high grant to agent 0
reg gnt_1 ; // Active high grant to agent 1
reg gnt_2 ; // Active high grant to agent 2
reg gnt_3 ; // Active high grant to agent 3
reg gnt_4 ; // Active high grant to agent 4

parameter [2:0] IDLE = 3'b000;
parameter [2:0] GNT0 = 3'b001;
parameter [2:0] GNT1 = 3'b010;
parameter [2:0] GNT2 = 3'b011;
parameter [2:0] GNT3 = 3'b100;
parameter [2:0] GNT4 = 3'b101;

reg [2:0] state, next_state;

always@(req_0 or req_1 or req_2 or req_3 or req_4)
begin
case({req_0,req_1,req_2,req_3,req_4})
           'b00000:next_state=IDLE;
           'b00001:next_state=GNT4;
           'b00010:next_state=GNT3;
           'b00011:next_state=GNT3;
           'b00100:next_state=GNT2;
           'b00101:next_state=GNT2;
           'b00110:next_state=GNT2;
           'b00111:next_state=GNT2;
           'b01000:next_state=GNT1;
           'b01001:next_state=GNT1;
           'b01010:next_state=GNT1;
           'b01011:next_state=GNT1;
           'b01100:next_state=GNT1;
           'b01101:next_state=GNT1;
           'b01110:next_state=GNT1;
           'b01111:next_state=GNT1;
           'b10000:next_state=GNT0;
           'b10001:next_state=GNT0;
           'b10010:next_state=GNT0;
           'b10011:next_state=GNT0;
           'b10100:next_state=GNT0;
           'b10101:next_state=GNT0;
           'b10110:next_state=GNT0;
           'b10111:next_state=GNT0;
           'b11000:next_state=GNT0;
           'b11001:next_state=GNT0;
           'b11010:next_state=GNT0;
           'b11011:next_state=GNT0;
           'b11100:next_state=GNT0;
           'b11101:next_state=GNT0;
           'b11110:next_state=GNT0;
           'b11111:next_state=GNT0;
         endcase

end


always @ (posedge(clock))
begin
case(state)
IDLE :  begin
            gnt_0='b0;
            gnt_1='b0;
            gnt_2='b0;
            gnt_3='b0;
            gnt_4='b0;
            $display($time,"nano sec there is no request ");
            break;
        end

GNT0 :  if  (req_0&&((req_1||~req_1)||(req_2||~req_2)||(req_3||~req_3)||(req_4||~req_4))) begin
            gnt_0='b1;
            gnt_1='b0;
            gnt_2='b0;
            gnt_3='b0;
            gnt_4='b0;
            $display($time,"nano sec req0 is granted ");
            break;
            end 


GNT1 :   if (req_1&&((req_0||~req_0)||(req_2||~req_2)||(req_3||~req_3)||(req_4||~req_4))) begin
            gnt_0='b0;
            gnt_1='b1;
            gnt_2='b0;
            gnt_3='b0;
            gnt_4='b0;
            $display($time,"nano sec req1 is granted ");
            break;
            end 

GNT2 :   if (req_2&&((req_1||~req_1)||(req_0||~req_0)||(req_3||~req_3)||(req_4||~req_4))) begin
            gnt_0='b0;
            gnt_1='b0;
            gnt_2='b1;
            gnt_3='b0;
            gnt_4='b0;
            $display($time,"nano sec req2 is granted ");
            break;

            end 

            
GNT3 :   if (req_3&&((req_1||~req_1)||(req_2||~req_2)||(req_0||~req_0)||(req_4||~req_4))) begin
            gnt_0='b0;
            gnt_1='b0;
            gnt_2='b0;
            gnt_3='b1;
            gnt_4='b0;
            $display($time,"nano sec req3 is granted ");
            break;
            end 

            
GNT4 :   if (req_4&&((req_1||~req_1)||(req_2||~req_2)||(req_0||~req_0)||(req_3||~req_3))) begin
            gnt_0='b0;
            gnt_1='b0;
            gnt_2='b0;
            gnt_3='b0;
            gnt_4='b1;
            $display($time,"nano sec req4 is granted ");
            break;
             end 

default : $display($time,"nano sec invalid request");

endcase
end


always@(posedge clock)  //for transition of states
  begin
  if(reset)
    state <=IDLE;
  else
   state <= next_state;
  end 

endmodule
