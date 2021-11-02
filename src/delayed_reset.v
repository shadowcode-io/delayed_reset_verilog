`timescale 1ns / 1ps
`default_nettype	none


module delayed_reset #(
    parameter [ 0:0] RESETLOW = 1,
    parameter [31:0] DELAY_LENGTH = 32'h 0000_2710, 
    parameter [ 7:0] RESET_LENGTH = 8'h 64          
    ) (
    input wire i_clk,   
    output reg o_reset
);

reg [ 7:0] rst_len = RESET_LENGTH;
reg [31:0] counter = DELAY_LENGTH;

initial o_reset = RESETLOW ? 1'b1 : 1'b0;

always @(posedge i_clk ) begin    
    if (counter == 1'b0 && rst_len == 1'b0)
        
        o_reset <= RESETLOW ? 1'b1 : 1'b0;  
              
    else if (counter == 1'b0) begin    
    
            o_reset <= RESETLOW ? 1'b0 : 1'b1;            
            rst_len <= rst_len - 1'b1;                
        end
        
    else    
        counter <= counter - 1'b1;
end

endmodule