`timescale 1ns/1ps

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
           bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;

input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire    [32-1:0] result;
wire            zero;
wire             cout;
wire             overflow;

wire    [32-1:0] w_cout;
wire    [32-1:0] set;
wire             less;
wire             equal;

generate
    genvar i;
    alu_top first_alu(
        src1[0], 
        src2[0],
        less, 
        equal, 
        ALU_control[3], 
        ALU_control[2], 
        ALU_control[2], 
        ALU_control[1:0], 
        bonus_control, 
        1'b1, 
        result[0], 
        w_cout[0], 
        set[0]
    );
    for (i = 1; i < 32; i = i + 1) begin
        alu_top alu(
            src1[i],
            src2[i],
            1'b0,  
            1'b0, 
            ALU_control[3], 
            ALU_control[2],
            w_cout[i - 1],
            ALU_control[1:0], 
            bonus_control, 
            1'b0, 
            result[i], 
            w_cout[i], 
            set[i]
        );
    end
endgenerate

assign overflow = w_cout[31] ^ w_cout[30];
assign less = set[31] ^ overflow;
assign equal = (set == 0) & ~overflow;
assign zero = (result == 0);
assign cout = ((ALU_control == 4'b0010 || ALU_control == 4'b0110)? w_cout[31]:0);

endmodule
