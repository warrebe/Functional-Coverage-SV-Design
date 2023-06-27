// Define covergroup 1
covergroup cg_ss @(posedge tb.clk);
	cp_ns 	: coverpoint tb.gcd_0.gcd_ctrl_0.ps;
	cp_ps 	: coverpoint tb.gcd_0.gcd_ctrl_0.ns;
	cp_both	: cross cp_ps, cp_ns;
endgroup

// Define covergroup 2
covergroup cg_out @(posedge tb.clk);
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
covergroup cg_fsmtrans @(posedge tb.clk);
	cp_ps : coverpoint tb.gcd_0.gcd_ctrl_0.ps
	{ 
		illegal_bins  bad_trans = (2'h3 => 2'h1);
	}
endgroup

// Define covergroup 4
covergroup cg_reg @(posedge tb.clk);
	cp_swap	: coverpoint tb.gcd_0.gcd_ctrl_0.swap_registers;
	cp_sub	: coverpoint tb.gcd_0.gcd_ctrl_0.subtract_registers;
	cp_both : cross cp_swap, cp_sub;
endgroup