`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2026 10:33:42
// Design Name: 
// Module Name: UART_RX
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


module UART_RX(
input clk,rst,rx,
output reg [7:0]data_out,
output reg rx_done
    );
wire baud_tick;
wire half_baud_tick;
reg [2:0]bit_count;
reg [7:0]shift_reg;
reg [12:0]baud_count;
reg [1:0] ps,ns;
parameter idle=2'b00,
           start=2'b01,
           data=2'b10,
           stop=2'b11;
always @(posedge clk) begin
   if(rst) 
      ps<=idle;
    else
      ps<=ns;
   end
always @(*) begin
 ns=ps;
  case(ps)
    idle:ns=(rx)?idle:start;
    start : ns=(half_baud_tick)? data :start;
    data : ns = (baud_tick && bit_count==3'b111) ? stop : data;
    stop : ns=(baud_tick) ? idle:stop;
      default :ns=idle;
  endcase
end
always @(posedge clk) begin
  if(rst) begin
    shift_reg<=0;
    baud_count<=0;
    bit_count<=0;
    data_out<=0;
    rx_done<=0;
  end
 else
   begin
      if(ps==idle && rx==1'b0) begin
        bit_count<=0;
        shift_reg<=0;
        end
      if(ps==data && baud_tick) begin
        shift_reg <= {rx, shift_reg[7:1]};
        bit_count<=bit_count+1;
      end  
      if(ps !=idle) begin
        if(baud_tick)
                 baud_count <= 0;
             else
                 baud_count <= baud_count + 1;
             end
        else
              baud_count <= 0;
   end    
if(ps==stop)
begin
   data_out <= shift_reg;
   rx_done  <= 1;
end
else
   rx_done <= 0;
end

assign baud_tick = (baud_count == 9);
assign half_baud_tick = (baud_count == 4);
endmodule