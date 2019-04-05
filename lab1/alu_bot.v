`timescale 1ns/1ps

module alu_bot(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               set,
               overflow
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        overflow;
output        set;

reg           result;
reg           overflow;
reg           set;
reg           cout;

always@( * ) begin
    // init
    if (A_invert) src1 = !src1;
    if (B_invert) src2 = !src2;
    assign {cout, result} = src1 + src2 + cin;
    assign set = result;
    assign overflow = 0;
    
    if (ALU_control == 2'b00) // AND
        assign result = src1 & src2;
    else if (ALU_control == 2'b01) // OR
        assign result = src1 | src2;
    else if (ALU_control == 2'b10) begin // ADD
        assign {cout, result} = src1 + src2 + cin;
        if (src1 == 1 && src2 == 1 && result != 1)
           assign overflow = 1;
        if (src1 == 0 && src2 == 0 && result != 0)
           assign overflow = 1;
    end
    else if (ALU_control == 4'b11) // LESS
        assign result = less;
end

endmodule
