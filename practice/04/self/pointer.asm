//suppose that arr=100 and n=10
//for(i=0;i<n;++i){
//   arr[i]=-1 
//}

//usage: put a number(arr) in the RAM[0]; put a number(n) in RAM[1]

@R0
D=M
@arr
M=D  //arr=RAM[0]

@R1
D=M
@n
M=D   //n=RAM[1]

@i
M=0    //i=0

(LOOP)
@i
D=M
@n
D=D-M
@END
D;JEQ     //if i==n, goto END

@arr
D=M
@i
A=D+M
M=-1    //arr[i]=-1


@i
M=M+1   //i=i+1

@LOOP
0;JMP


(END)
@END
0;JMP




