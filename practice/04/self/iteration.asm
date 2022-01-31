//computes: RAM[1]=1+2+3...n
//usage: put a number(n) in RAM[0]

//init
@sum
M=0    //sum=0

@i
M=1    //i=1

@R0
D=M
@n
M=D    //n=RAM[0]

(LOOP)
@i
D=M
@n
D=D-M 
@STOP
D;JGT   //if i>n goto STOP

@sum
D=M
@i 
D=D+M
@sum
M=D    //sum=sum+i

@i 
M=M+1  //i=i+1

@LOOP
0;JMP


(STOP)
@sum
D=M 
@R1
M=D    //RAM[1]=sum

(END)
@END
0;JMP



