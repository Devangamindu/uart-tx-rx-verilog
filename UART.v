`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2026 12:56:02
// Design Name: 
// Module Name: UART
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


module UART(
input clk,rst,tx_start,
input [7:0]data_in,
output rx_done,
output [7:0]data_out
    );
 wire uart_line;
UART_TX uart1(.clk(clk),.rst(rst),.tx_start(tx_start),
.data_in(data_in),.tx(uart_line),.tx_done());
UART_RX uart2(.clk(clk),.rst(rst),.rx(uart_line),
.data_out(data_out),.rx_done(rx_done));
endmodule
