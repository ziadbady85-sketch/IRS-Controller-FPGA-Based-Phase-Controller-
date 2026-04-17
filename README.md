# IRS Controller (FPGA-Based Phase Controller)

## Overview
This project implements an IRS (Intelligent Reflecting Surface) Controller.

It takes phase data from an AI model and converts it into control signals for hardware pins.

## Features
- FSM-based design
- Parallel phase loading
- Phase decomposition into control signals
- Synchronization between AI and hardware

## FSM States
- IDLE
- LOAD
- DIVIDE

## Inputs
- clk
- rst
- AI_start
- AI_PHASES

## Outputs
- PINA
- PINB
- UPDATE_IRS
- DONE_AI

## How It Works
1. IDLE:
   - Waits for AI_start signal

2. LOAD:
   - Stores AI_PHASES into internal registers

3. DIVIDE:
   - Splits phase data into:
     - PINA (bit 0)
     - PINB (bit 1)
   - Sends update signal to IRS
   - Signals completion

## Simulation
- Apply reset
- Trigger AI_start
- Provide phase data
- Observe:
  - PINA / PINB outputs
  - DONE_AI signal

## Applications
- Smart Antenna Systems
- Beamforming
- Wireless Communication Optimization
