#!/bin/bash
make clean
make SCHED_POLICY=MLFQ_SCHED TEST_NUM=3 CPUS=1 qemu-nox
