// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

@R0
D=M

@a 
M=D  //a=RAM[0]


@R1
D=M

@b 
M=D   //b=RAM[1]


@sum
M=0    //sum=0


@i   
M=0    //i=0

//check for zero, conditional jump
@a
D=M
@STOP
D;JEQ

//check for zero, conditional jump
@b
D=M
@STOP
D;JEQ

(LOOP)
    @i
    D=M
    @b
    D=D-M
    @STOP
    D;JEQ    //if i==b goto STOP

    @a 
    D=M
    @sum
    M=M+D    //sum=sum+a 

    @i
    M=M+1    //i=i+1

    @LOOP
    0;JMP

(STOP)
    @sum
    D=M
    @R2
    M=D    //RAM[2]=sum

    @END
    0;JMP

(END)
    @END
    0;JMP



