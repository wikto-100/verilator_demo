#!/bin/bash

if [ ! -d ./logs ]; then
	mkdir -p ./logs
fi

timestamp() {
	date +"%H:%M:%S:%3N"
}

cleanup() {
	: > ./logs/sim.log
}
trap cleanup EXIT INT TERM
test_num=0

echo "Verilator watchdog started..."

tail -n0 -F ./build/sim.out 2>/dev/null | while read -r line; do
	if [[ $line == *"TESTRUN"* ]]; then
		test_num=$((test_num + 1))
		echo ""$(timestamp)" [TEST "$test_num"]" >>./logs/sim.log
	else
	echo "$(timestamp)" "$line" >>./logs/sim.log
	fi
done