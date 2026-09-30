# UART Transmitter and Receiver in Verilog

## Overview

Designed and verified a UART communication system in Verilog HDL consisting of transmitter and receiver modules.

## Features

- UART transmitter
- UART receiver
- Start and stop bit handling
- 8-bit data transmission
- Baud-rate timing
- Serial data shifting
- TX/RX loopback verification

## Architecture

Data
 |
UART_TX
 |
UART Line
 |
UART_RX
 |
Received Data

## Verification

Verified UART TX/RX functionality using Xilinx Vivado simulation with loopback-based testing.

## Concepts

- FSM design
- Baud-rate generation
- Shift registers
- Serial communication
- RTL timing control
