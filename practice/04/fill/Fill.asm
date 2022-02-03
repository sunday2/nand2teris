// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

@8192
D=A
@count 
M=D     //count=8192


(READ_KEYBOARD)
                @i
                M=0       //reset i=0

                @KBD 
                D=M 
                @PAINT_BLACK
                D;JNE       //kbd !=0, goto PAINT_BLACK     
                


(PAINT_WHITE)
            @color
            M=0             //color=0
            @PAINT_LOOP
            0;JMP


(PAINT_BLACK)
            @color
            M=-1            //color=-1
            @PAINT_LOOP
            0;JMP    


(PAINT_LOOP)
            @i
            D=M
            @count
            D=D-M
            @READ_KEYBOARD
            D;JEQ      //if i==count, goto READ_KEYBOARD

            @SCREEN
            D=A 
            @i
            D=D+M

            @addr
            M=D      //addr = SCREEN+i

            @color
            D=M

            @addr
            A=M
            M=D     //RAM[addr]=color

            @i
            M=M+1   //i=i+1

            @PAINT_LOOP
            0;JMP    //goto PAINT_LOOP

  