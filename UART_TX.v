`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2026 14:40:17
// Design Name: 
// Module Name: UART_TX
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


module UART_TX(
input clk,rst,tx_start,
input [7:0] data_in,
output reg tx,tx_done
    );
wire baud_tick;
reg [1:0]ps,ns;
reg [2:0] bit_count;
reg [7:0] shift_reg;
reg[12:0] baud_count;
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
      idle : ns=(tx_start)?start:idle;
      start : ns=(baud_tick)? data :start;
      data :
begin
   if(baud_tick)
   begin
      if(bit_count == 3'b111)
         ns = stop;
      else
         ns = data;
         end
   else
      ns = data;
end
      stop : ns=(baud_tick) ? idle:stop;
      default :ns=idle;
   endcase
end 
always @(posedge clk) begin
  if(rst) begin
     shift_reg <= 0;
      bit_count <= 0;
      baud_count<= 0;
  end
  else 
     begin
       if(ps==idle && tx_start==1) begin
         shift_reg<=data_in;
         bit_count<=0;
       end
       if(ps==data && baud_tick) begin
         shift_reg<=shift_reg>>1;
         bit_count<=bit_count+1;
       end 
       if(ps != idle)
            begin
             if(baud_tick)
                 baud_count <= 0;
             else
                 baud_count <= baud_count + 1;
             end
        else
              baud_count <= 0;
end
end
always @(*) begin
 case(ps)
   idle: begin
      tx=1'b1;
      tx_done=1'b0;
     end
     start: begin
      tx=1'b0;
      tx_done=1'b0;
     end
     data: begin
      tx=shift_reg[0];
      tx_done=1'b0;
     end
     stop : begin
      tx=1'b1;
      tx_done=1'b1;
     end
     default: begin
      tx=1'b1;
      tx_done=1'b0;
     end
 endcase
end
assign baud_tick=(baud_count==9);
endmodule
