// Experiment 2: Half adder - dataflow, behavioral and structural styles
// Top-level: lab1ex2 (DE2-115: SW[1], SW[2] -> LEDG[0] = sum, LEDG[1] = carry)

module half_adder_dataflow(input a, b, output s, Cout);
  assign s = a ^ b;
  assign Cout = a & b;
endmodule

module half_adder_behavior(sum,carry,a,b );
	output sum,carry;
	input a,b;
	reg sum,carry;
	always @(a,b) 
	begin
		sum   <= a ^ b;
		carry <= a&b  ;
	end
endmodule

module half_adder_structeral(input a, b, output s, Cout);
  xor G1(s,a,b);
  and G2(Cout,a,b);
endmodule

module lab1ex2 (SW, LEDR, LEDG);
  input [17:0] SW;
  output [7:0]  LEDG;
  output [17:0] LEDR;
  
  assign LEDR = SW;          
  assign LEDG[7:2] = 1'b0; 
  
  half_adder_dataflow DUT (.a(SW[1]), .b(SW[2]),
									.s(LEDG[0]), .Cout(LEDG[1]));
endmodule
