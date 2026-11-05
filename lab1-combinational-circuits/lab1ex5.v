// Experiment 5: 2-to-1 multiplexer - dataflow, behavioral and structural styles
// Top-level: lab1ex5 (DE2-115: SW[1] = i0, SW[2] = i1, SW[3] = sel -> LEDG[0] = y)

module mux21_data_flow(i0,i1,sel,y);
	input i0,i1,sel;
	output y;
	assign y =(i0&(~sel))|(i1&sel);
endmodule

module mux21_Behavioural (i0,i1,sel,y);
	input i0,i1,sel;
	output y;
	reg y;
	always@(*)
 begin
 	if(sel==0) y=i0;
	if(sel==1)y=i1;
 	end
endmodule

module mux21_structural(i0,i1,sel,y);
	input i0,i1,sel;
	output y;
	wire net1,net2,net3;
	not g1(net1,sel);
	and g2(net2,i1,sel);
	and g3(net3,i0,net1);
	or g4(y,net3,net2);
endmodule

module lab1ex5 (SW, LEDR, LEDG);
  input [17:0] SW;
  output [7:0]  LEDG;
  output [17:0] LEDR;
  
  assign LEDR = SW;          
  assign LEDG[7:1] = 7'b0;
  mux21_structural DUT(.i0(SW[1]), .i1(SW[2]), .sel(SW[3]),
                       .y(LEDG[0]));
endmodule
