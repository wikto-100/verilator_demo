#include "Vfifo.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>
#include <cassert>
#include <cstdint>

vluint64_t sim_time = 0;

void tick(Vfifo &dut, VerilatedVcdC &tfp)
{
    dut.clk = 0;
    dut.eval();
    tfp.dump(sim_time++);

    dut.clk = 1;
    dut.eval();
    tfp.dump(sim_time++);
}

void write_fifo(Vfifo &dut, VerilatedVcdC &tfp, int data)
{
    dut.wr_data = data;
    dut.wr_en = 1;
    tick(dut, tfp);
    dut.wr_en = 0;
    dut.eval();
    tfp.dump(sim_time++);
}

void read_fifo(Vfifo &dut, VerilatedVcdC &tfp)
{
    dut.rd_en = 1;
    tick(dut, tfp);
    dut.rd_en = 0;
    dut.eval();
    tfp.dump(sim_time++);
}

constexpr int DEPTH = 10;

int main(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vfifo dut;
    VerilatedVcdC tfp;

    dut.trace(&tfp, 99);
    tfp.open("build/wave.vcd");

    dut.clk = 0;
    dut.rst = 1;
    dut.wr_data = 0;
    dut.wr_en = 0;
    dut.rd_en = 0;

    tick(dut, tfp);
    tick(dut, tfp);

    dut.rst = 0;
    dut.eval();
    tfp.dump(sim_time++);
    std::cout << "TESTRUN\n";
    std::cout << "empty = " << int(dut.empty) << '\n';
    std::cout << "full = " << int(dut.full) << '\n';

    assert(dut.empty == 1);
    assert(dut.full == 0);

    for (int i = 0; i < DEPTH; i++)
    {
        write_fifo(dut, tfp, i);
    }

    assert(int(dut.full) == 1);

    for (int i = 0; i < DEPTH; i++)
    {
        read_fifo(dut, tfp);
        std::cout << "rd_data = " << int(dut.rd_data) << '\n';
        assert(int(dut.rd_data) == i);
    }

    assert(int(dut.empty) == 1);

    tfp.close();

    std::cout << "PASS\n";
    return 0;
}