`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 20:55:10
// Design Name: 
// Module Name: Round_robin_arbiter
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


module Round_robin_arbiter(
      clock,    
      reset,    
      req3,   
      req2,   
      req1,   
      req0,   
      grant3,   
      grant2,   
      grant1,   
      grant0   
    );
    input           clock;    //CLOCK
    input           reset;    //RESET
    input           req3;   //REQUEST SIGNALS
    input           req2;   
    input           req1;   
    input           req0;   
    output          grant3;   //GRANT SIGNALS
    output          grant2;   
    output          grant1;   
    output          grant0;   
    
    wire    [1:0]   grant       ;   
    wire            communication_request    ;    
    wire            beg       ;  // BEGIN SIGNAL
    wire   [1:0]    lgrant      ;  // LATCHED ENCODED GRANT
    wire            lcommunication_request   ;  // BUS STATUS
    reg             lgrant0     ;  // LATCHED GRANTS
    reg             lgrant1     ;
    reg             lgrant2     ;
    reg             lgrant3     ;
    reg             mask_enable   ;
    reg             len0    ;
    reg             len1    ;
    
    assign communication_request = lcommunication_request;
    assign grant    = lgrant;
    
    // Drive the outputs
    
    assign grant3   = lgrant3;
    assign grant2   = lgrant2;
    assign grant1   = lgrant1;
    assign grant0   = lgrant0;      
  
  
    always @ (posedge clock)
      
      if (reset)  //if reset is true
      begin
        lgrant0 <= 0;
        lgrant1 <= 0;
        lgrant2 <= 0;
        lgrant3 <= 0;
      end 
      
      else
        begin
        mask_enable=1;                                     
      lgrant0 <=(~lcommunication_request & ~len1 & ~len0 & ~req3 & ~req2 & ~req1 & req0)
            | (~lcommunication_request & ~len1 &  len0 & ~req3 & ~req2 &  req0)
            | (~lcommunication_request &  len1 & ~len0 & ~req3 &  req0)
            | (~lcommunication_request &  len1 &  len0 & req0  )
            | ( lcommunication_request & lgrant0 );
          
      lgrant1 <=(~lcommunication_request & ~len1 & ~len0 &  req1)
            | (~lcommunication_request & ~len1 &  len0 & ~req3 & ~req2 &  req1 & ~req0)
            | (~lcommunication_request &  len1 & ~len0 & ~req3 &  req1 & ~req0)
            | (~lcommunication_request &  len1 &  len0 &  req1 & ~req0)
            | ( lcommunication_request &  lgrant1);
          
      lgrant2 <=(~lcommunication_request & ~len1 & ~len0 &  req2  & ~req1)
            | (~lcommunication_request & ~len1 &  len0 &  req2)
            | (~lcommunication_request &  len1 & ~len0 & ~req3 &  req2  & ~req1 & ~req0)
            | (~lcommunication_request &  len1 &  len0 &  req2 & ~req1 & ~req0)
            | ( lcommunication_request &  lgrant2);
          
      lgrant3 <=(~lcommunication_request & ~len1 & ~len0 & req3  & ~req2 & ~req1)
            | (~lcommunication_request & ~len1 &  len0 & req3  & ~req2)
            | (~lcommunication_request &  len1 & ~len0 & req3)
            | (~lcommunication_request &  len1 &  len0 & req3  & ~req2 & ~req1 & ~req0)
            | ( lcommunication_request & lgrant3);
    end 
    
     //BEGIN SIGNAL
      
      assign beg = (req3 | req2 | req1 | req0) & ~lcommunication_request;  
      
      always@ (posedge clock) begin
      if(beg) $display($time," ns Bus is ready for request");
      else $display($time,"ns Bus is not free");
      end
      
    
     // communication_request logic (BUS STATUS)
    
    assign lcommunication_request = ( req3 & lgrant3 )
                    | ( req2 & lgrant2 )
                    | ( req1 & lgrant1 )
                    | ( req0 & lgrant0 );
    
    
    // Encoder logic
      
    assign  lgrant =  {(lgrant3 | lgrant2),(lgrant3 | lgrant1)};
    
    
    // enable register.
    
    always @ (posedge clock )
    if( reset ) 
      begin
        len1 <= 0;
        len0 <= 0;
      end 
     else if(mask_enable) 
        begin
          len1 <= lgrant[1];
          len0 <= lgrant[0];
        end 
     else 
        begin
          len1 <= len1;
          len0 <= len0;
        end 
    
      

endmodule
