`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2026 20:04:11
// Design Name: 
// Module Name: UART_wrapper
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


module UART_wrapper(
input clk,rst,
input uart_write_enable,
input [7:0]uart_write_data,
output reg [7:0] uart_read_data
    );
    wire [7:0] rx_data;
wire rx_done,tx_done,uart_line;
UART_TX t1(.clk(clk),.rst(rst),.tx_start(uart_write_enable),.data_in(uart_write_data),.tx(uart_line),.
tx_done(tx_done));
UART_RX t2(.clk(clk),.rst(rst),.rx(uart_line),.data_out(rx_data),.rx_done(rx_done));
always @(*) begin
    uart_read_data = rx_data;
end
endmodule
