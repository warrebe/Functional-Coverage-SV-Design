#!/bin/bash
vlib work
vlog tb.sv gcd*.sv #-cover sbcef +cover=f -O0 
vsim tb -c -do run.do +two #-coverage
