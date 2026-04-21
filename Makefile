TOP := fifo
OBJDIR := build
RTL := rtl
TB := tb

all:
	mkdir -p $(OBJDIR)
	verilator --sv --cc $(RTL)/$(TOP).sv --exe $(TB)/tb_$(TOP).cpp --trace --build -Mdir $(OBJDIR)

.PHONY: run,clean

run: all
	./$(OBJDIR)/V$(TOP) > $(OBJDIR)/sim.out 2>&1

wave: run
	gtkwave $(OBJDIR)/wave.vcd

clean:
	rm -rf $(OBJDIR)