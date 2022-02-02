//rectangle drawing: the rectangel is 16 pixels wide, the simulated screen each row has 512 pixels.
//usage: put the number(length of the rectangle) in RAM[0]

//pseudo code

@SCREEN
D=A
@addr
M=D   //addr=SCREEN

@R0
D=M 
@n
M=D   //n=RAM[0]

@i 
M=0   //i=0

(LOOP)
    @i
    D=M
    @n
    D=D-M
    @END
    D;JEQ    //if i==n, goto END

    @addr
    A=M
    M=-1   //RAM[addr]=-1

    @32
    D=A
    @addr
    M=M+D   //addr=addr+32

    @i
    M=M+1   //i=i+1

    @LOOP
    0;JMP    //goto LOOP


(END)
    @END
    0;JMP

