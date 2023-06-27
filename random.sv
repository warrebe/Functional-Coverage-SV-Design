class Random;
	rand bit[15:0] a;
	rand bit[15:0] b;
	constraint a_con {a < 500; a > 0;}  // Cant be 500 as b>0 and a+b = 500
	constraint b_con {b > 0; b < 500;} // Cant be 0 else FSM breaks
	constraint ab_sum {a + b == 500;}	 
endclass