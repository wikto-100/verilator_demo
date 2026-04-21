# Verilator FIFO Demo

## Overview

A small learning project built around testing a SystemVerilog FIFO with Verilator, a C++ testbench, GTKWave, and a Bash watchdog for simulation logging.

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

Start the watchdog, run the simulation, and open waveforms when needed:

```bash
./scripts/verilator_watchdog.sh &
make run
make wave
```

The testbench drives and checks the FIFO, `make wave` opens GTKWave, and the watchdog appends run output to `logs/sim.log`.

## Purpose

This project is meant to practice a minimal RTL verification flow with SystemVerilog, Verilator, C++, waveforms, and simple Bash tooling.