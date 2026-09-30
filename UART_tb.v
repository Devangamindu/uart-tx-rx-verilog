`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2026 13:05:10
// Design Name: 
// Module Name: UART_tb
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


module UART_tb;
reg clk,rst,tx_start;
reg [7:0]data_in;
wire rx_done;
wire [7:0]data_out;
UART uut(.clk(clk),.rst(rst),.tx_start(tx_start),.data_in(data_in),
.rx_done(rx_done),.data_out(data_out));
initial begin
   repeat(1000)
     begin
       clk=1'b0;#5;
       clk=1'b1;#5;
    end
end
initial begin
  rst=1'b1;
  tx_start=1'b0;
  data_in=0;
  #10;
  data_in = 0;#10;
   rst = 0;
data_in = 8'b10110010;
   tx_start = 1;#10;
   tx_start = 0;#2000;   // wait for transmission
data_in = 8'b10111011;
   tx_start = 1;
   #10;
   tx_start = 0;
 #3000;
 $finish;
end
initial
begin
   $monitor("t=%0t data_in=%h data_out=%h rx_done=%b",
             $time,data_in,data_out,rx_done);
end
endmodule
