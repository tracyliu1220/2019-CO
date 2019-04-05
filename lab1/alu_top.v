`timescale 1ns/1ps

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout        //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;
reg           _src1;
reg           _src2;
reg           cout;

always@( * ) begin
    // init
    _src1 = src1;
    _src2 = src2;
    if (A_invert) _src1 = ~src1;
    if (B_invert) _src2 = ~src2;
    {cout, result} = _src1 + _src2 + cin;
    
    if (operation == 2'b00) // AND
        result = _src1 & _src2;
    else if (operation == 2'b01) // OR
        result = _src1 | _src2;
    else if (operation == 2'b10) // ADD
        {cout, result} = _src1 + _src2 + cin;
    else if (operation == 2'b11) // LESS
        result = less;
end

endmodule
