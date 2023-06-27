// Define covergroup 1
covergroup cg_ss_2 @(posedge tb.clk);
	cp_ns 	: coverpoint tb.gcd_0.gcd_ctrl_0.ps;
	cp_ps 	: coverpoint tb.gcd_0.gcd_ctrl_0.ns;
	cp_both	: cross cp_ps, cp_ns
	{ 
		ignore_bins	ignorecomb1 = binsof(cp_ps) intersect {2} && binsof(cp_ns) intersect {3};
		ignore_bins	ignorecomb2 = binsof(cp_ps) intersect {1} && binsof(cp_ns) intersect {3};
		ignore_bins	ignorecomb3 = binsof(cp_ps) intersect {3} && binsof(cp_ns) intersect {2};
		ignore_bins	ignorecomb4 = binsof(cp_ps) intersect {2} && binsof(cp_ns) intersect {2};
		ignore_bins	ignorecomb5 = binsof(cp_ps) intersect {1} && binsof(cp_ns) intersect {2};
		ignore_bins	ignorecomb6 = binsof(cp_ps) intersect {3} && binsof(cp_ns) intersect {1};
		ignore_bins	ignorecomb7 = binsof(cp_ps) intersect {1} && binsof(cp_ns) intersect {1};
		ignore_bins	ignorecomb8 = binsof(cp_ps) intersect {0} && binsof(cp_ns) intersect {1};
		ignore_bins	ignorecomb9 = binsof(cp_ps) intersect {0} && binsof(cp_ns) intersect {0};
	}
endgroup

// Define covergroup 2
covergroup cg_out_2 @(posedge tb.clk);
	cp_out : coverpoint tb.gcd_0.result 
	{
		bins outbins1 = {[0:500]};
		bins outbins2 = {[500:999]};
		bins outbins3 = {[1000:2000]};
		bins outbins4 = {[3000:3500]};
		bins outbins5 = {[7000:8000]};
		bins outbins6 = {5000};
	}
endgroup

// Define covergroup 3
covergroup cg_fsmtrans_2 @(posedge tb.clk);
	cp_ps : coverpoint tb.gcd_0.gcd_ctrl_0.ps
	{ 
		illegal_bins  bad_trans = (2'h3 => 2'h1);
	}
endgroup

// Define covergroup 4
covergroup cg_reg_2 @(posedge tb.clk);
	cp_swap	: coverpoint tb.gcd_0.gcd_ctrl_0.swap_registers;
	cp_sub	: coverpoint tb.gcd_0.gcd_ctrl_0.subtract_registers;
	cp_both : cross cp_swap, cp_sub
	{ 
		ignore_bins	ignorecomb = binsof(cp_swap) intersect {1} && binsof(cp_sub) intersect {1};
	}
endgroup