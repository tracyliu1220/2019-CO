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
               overflow,
               cout
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
output        cout;

reg           result;
reg           overflow;
reg           set;
reg           cout;
reg           _src1;
reg           _src2;

always@( * ) begin
    // init
    _src1 = src1;
    _src2 = src2;
    if (A_invert) _src1 = !src1;
    if (B_invert) _src2 = !src2;
    {cout, result} = _src1 + _src2 + cin;
    set = result;
    overflow = 0;
    
    if (operation == 2'b00) // AND
        result = _src1 & _src2;
    else if (operation == 2'b01) // OR
        result = _src1 | _src2;
    else if (operation == 2'b10) begin // ADD
        {cout, result} = _src1 + _src2 + cin;
        if (_src1 == 1 && _src2 == 1 && result != 1)
            overflow = 1;
        else if (_src1 == 0 && _src2 == 0 && result != 0)
            overflow = 1;
        else
            overflow = 0;
    end
    else if (operation == 4'b11) // LESS
        result = less;
end

endmodule
