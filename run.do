#coverage exclude -code b -du gcd_ctrl
#coverage exclude -srcfile tb.sv
run -all
coverage save a.ucdb
coverage report -details -output func.low.rpt
coverage report -details -html
exit
