`timescale 1ns/1ns
`include "covergroups.sv"
`include "mod_covergroups.sv"
`include "random.sv"

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;

parameter CYCLE = 100; 

reg clk, reset_n;
reg start, done;
reg [31:0] a_in, b_in; 
reg [31:0] result;

//clock generation for write clock
initial begin
  clk <= 0; 
  forever #(CYCLE/2) clk = ~clk;
end

gcd gcd_0(.*); 	  // Instantiate the gcd unit
Random cts = new; // Instantiate randomizer

// Instantiate Covergroups
cg_ss cgss = new;
cg_out cgout = new;
cg_fsmtrans cgfsm = new;
cg_reg 	cgreg = new;

// Instantiate Modified Covergroups
cg_ss_2 cgss2 = new;
cg_out_2 cgout2 = new;
cg_fsmtrans_2 cgfsm2 = new;
cg_reg_2 	cgreg2 = new;

// Define cover property
property cvr_rst;
    @(posedge tb.clk) $fell(reset_n) |->##2 $rose(start) |->##[70:80] $rose(done);
endproperty

cover property(cvr_rst);

property cvr_silly;
    @(posedge tb.clk) $rose(done);
endproperty

cover property(cvr_silly);

initial begin
//********************** Part 2 *********************************************
if($test$plusargs ("two")) begin
	$display("Running Test on Part 2...");
    input_file  = $fopen("post_input_data", "rb");
    if (input_file==0) begin 
      $display("ERROR : CAN NOT OPEN input_file"); 
    end
    output_file = $fopen("output_data", "wb");
    if (output_file==0) begin 
      $display("ERROR : CAN NOT OPEN output_file"); 
    end
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
	
  #(CYCLE*4);
  while(! $feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   //$display ("a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   #(CYCLE*2);
  end
$stop;
$fclose(input_file);
end
//********************** Part 3 *********************************************
if($test$plusargs ("three")) begin
	$display("Running Test on Part 3...");
    input_file  = $fopen("mod_input_data", "rb");
    if (input_file==0) begin
      $display("ERROR : CAN NOT OPEN input_file");
    end
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; 

  #(CYCLE*4);  
  while (!$feof(input_file)) begin
    $fscanf(input_file, "%d %d", a_in, b_in);
    start = 1'b1;
    #(CYCLE);
    start = 1'b0;
    while (done != 1'b1) #(CYCLE);
    #(CYCLE*2);
  end
$stop;
$fclose(input_file);
end
//********************** Part 5 *********************************************
if($test$plusargs ("five")) begin
	$display("Running Test on Part 5...");
    input_file  = $fopen("rp_input_data", "rb");
    if (input_file==0) begin
      $display("ERROR : CAN NOT OPEN input_file");
    end
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; 

  #(CYCLE*4);  
  while (!$feof(input_file)) begin
    $fscanf(input_file, "%d %d", a_in, b_in);
    //$display("a_in=%d b_in=%d", a_in, b_in);
    start = 1'b1;
    #(CYCLE);
    start = 1'b0;
    while (done != 1'b1) #(CYCLE);
    #(CYCLE*2);
  end
$stop;
$fclose(input_file);
end
end
endmodule
