// Experiment 3: 1-bit full adder - dataflow, behavioral (truth table) and structural styles
// Top-level: lab1ex3 (DE2-115: SW[0..2] = A, B, Cin -> LEDG[0] = S, LEDG[1] = Cout)

module full_adder_DF(input a, b, cin, output S, Cout);
  assign S = a ^ b ^ cin;
  assign Cout = (a & b) | (b & cin) | (a & cin);
endmodule

module full_adder_BH1 (input wire A, B, Cin, output reg S, output reg Cout);
  always @(A or B or Cin)
  begin 
    case ({A, B, Cin}) // concatenate the inputs into a 3-bit selector
      3'b000: begin S = 0; Cout = 0; end 
      3'b001: begin S = 1; Cout = 0; end 
      3'b010: begin S = 1; Cout = 0; end 
      3'b011: begin S = 0; Cout = 1; end 
      3'b100: begin S = 1; Cout = 0; end 
      3'b101: begin S = 0; Cout = 1; end 
      3'b110: begin S = 0; Cout = 1; end 
      3'b111: begin S = 1; Cout = 1; end 
    endcase 
  end
endmodule

module full_adder_STRU(A, B, Cin, Sum, Carry); // gate-level netlist
  output Sum, Carry;
  input A, B, Cin;
  wire x, y, z;
  
  xor g1(x, A, B);
  xor g2(Sum, x, Cin);
  and g3(y, x, Cin);
  and g4(z, A, B);
  or  g5(Carry, y, z);
endmodule

module lab1ex3 (SW, LEDR, LEDG);
  input [17:0] SW;
  output [7:0]  LEDG;
  output [17:0] LEDR;
  
  assign LEDR = SW;          
  assign LEDG[7:2] = 6'b0; // unused green LEDs off
  
  full_adder_BH1 DUT (
    .A(SW[0]), 
    .B(SW[1]), 
    .Cin(SW[2]),
    .S(LEDG[0]), 
    .Cout(LEDG[1])
  );
endmodule
