// Experiment 4: 4-bit ripple-carry adder
// Uses full_adder_STRU from lab1ex3.v
// Top-level: lab1ex4 (DE2-115: SW[3:0] = a, SW[7:4] = b, SW[8] = cin -> LEDG[3:0] = sum, LEDG[4] = cout)

// 4-bit adder built from four 1-bit full adders (structural)
module four_bit_adder_STRU(cin, a, b, s, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] s;
    output cout;
    wire [2:0] w_carry;
    
    full_adder_STRU C1(a[0], b[0], cin,        s[0], w_carry[0]);
    full_adder_STRU C2(a[1], b[1], w_carry[0], s[1], w_carry[1]);
    full_adder_STRU C3(a[2], b[2], w_carry[1], s[2], w_carry[2]);
    full_adder_STRU C4(a[3], b[3], w_carry[2], s[3], cout);
endmodule

// 4-bit adder, dataflow style
module Four_bit_Adder_DF(A, B, Cin, Sum, Cout);
    input [3:0] A, B;
    input Cin;
    output wire [3:0] Sum;
    output wire Cout;
    wire [4:0] temp;
    
    assign temp = A + B + Cin;
    assign Sum  = temp[3:0];
    assign Cout = temp[4];
endmodule

// Top-level module connecting switches and LEDs on the DE2-115 board
module lab1ex4 (SW, LEDR, LEDG);
    input  [17:0] SW;
    output [7:0]  LEDG;
    output [17:0] LEDR;
  
    assign LEDR = SW;  
    assign LEDG[7:5] = 3'b000;
  
    four_bit_adder_STRU DUT (
        .a    (SW[3:0]),   // 4-bit operand a
        .b    (SW[7:4]),   // 4-bit operand b
        .cin  (SW[8]),     // carry in
        .s    (LEDG[3:0]), // 4-bit sum
        .cout (LEDG[4])    // carry out
    );
endmodule
