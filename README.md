# Verilator FIFO Demo

## Overview

A small learning project that demonstrates a simple RTL verification flow with Verilator, a C++ testbench, GTKWave, and a Bash watchdog for simulation logging.

## Structure
```text
.
├── logs
│   └── sim.log
├── Makefile
├── README.md
├── rtl
│   └── fifo.sv
├── scripts
│   └── verilator_watchdog.sh
└── tb
    └── tb_fifo.cpp
```
## Workflow

Write RTL, build and run with Verilator, verify behavior in the C++ testbench, inspect waveforms in GTKWave, and monitor simulation output through the Bash watchdog.

Start the watchdog in the background, then run the simulation:

```bash
./scripts/verilator_watchdog.sh &
make run
```

The watchdog appends simulation log entries to `logs/sim.log` while the Verilator testbench runs.

## Purpose

This project is a learning demo meant to showcase a minimal development workflow in Verilator, including basic C++ testbench verification, waveform debugging, and Bash logging.