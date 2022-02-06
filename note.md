###  01

#### 15 particular gates

##### Elementary gates

* Not
* And
* Or
* Xor
* Mux
* DMux

##### 16-bit variants

* Not16

* And16

* Or16

* Mux16

##### Multi-way variants

* Or8Way

* Mux4Way16

* Mux8Way16

* DMux4Way

* DMux8Way

  

```
计算机科学离不开数学，显然boolean algebra是实现这些逻辑门的前提。
如何学好 boolean algebra，搜索了一些idea。
(1)Go over.
(2)draw it out.
(3)speak it out loud.
(4)practice.

因为Nand门是作为primative gate, 也就是与非门可以构建任意门，这点很重要！我们无需知道与非门是如何实现的，只需用它来构建任意门。下面是一些推导(deduce)过程(prefix notation)。

buse: Computer hardware is typically designed to operate on multi-bit arrays called
“buses.”

For example, a basic requirement of a 32-bit computer is to be able to
compute (bit-wise) an And function on two given 32-bit buses.

To implement this operation, we can build an array of 32 binary And gates, each operating
separately on a pair of bits. In order to enclose all this logic in one package, we
can encapsulate the gates array in a single chip interface consisting of two 32-bit
input buses and one 32-bit output bus

总线的概念参考:1.2.3节。
```

* Nand

| a    | b    | Nand(a,b) |
| ---- | ---- | --------- |
| 0    | 0    | 1         |
| 1    | 0    | 1         |
| 0    | 1    | 1         |
| 1    | 1    | 0         |

* Not

```
Not(in)=Nand(in,in)
```

| in  | Not(in) | Nand(in,in) |
| ---- | --------- | --------- |
| 0    |  1         |1|
| 1    |  0         |0|

* And

```
And(a,b)=Not(Nand(a,b))
```

| a    | b    | And(a,b) | Not(Nand(a,b)) |
| ---- | ---- | -------- | -------------- |
| 0    | 0    | 0        | 0              |
| 1    | 0    | 0        | 0              |
| 0    | 1    | 0        | 0              |
| 1    | 1    | 1        | 1              |

* Or

```
Or(a,b)=Nand(Not(a),Not(b))
```

| a    | b    | Or(a,b) | Nand(Not(a),Not(b)) |
| ---- | ---- | ------- | ------------------- |
| 0    | 0    | 0       | 0                   |
| 1    | 0    | 1       | 1                   |
| 0    | 1    | 1       | 1                   |
| 1    | 1    | 1       | 1                   |

* Xor

```
Xor(a,b)=And(Or(a,b),Nand(a,b))=Or(And(a,Not(b)),And(Not(a),b))
```

| a    | b    | Xor(a,b) | And(Or(a,b),Nand(a,b)) | Or(And(a,Not(b)),And(Not(a),b)) |
| ---- | ---- | -------- | ---------------------- | ------------------------------- |
| 0    | 0    | 0        | 0                      | 0                               |
| 1    | 0    | 1        | 1                      | 1                               |
| 0    | 1    | 1        | 1                      | 1                               |
| 1    | 1    | 0        | 0                      | 0                               |

* Mux

```
Mux(a,b,sel)=Or(And(Not(sel), a), And(sel, b))
```

| a    | b    | sel  | Mux(a,b,sel) | Or(And(Not(sel), a), And(sel, b)) |
| ---- | ---- | ---- | ------------ | --------------------------------- |
| 0    | 0    | 0    | 0            | 0                                 |
| 0    | 1    | 0    | 0            | 0                                 |
| 1    | 0    | 0    | 1            | 1                                 |
| 0    | 0    | 1    | 0            | 0                                 |
| 1    | 1    | 0    | 1            | 1                                 |
| 1    | 0    | 1    | 0            | 0                                 |
| 0    | 1    | 1    | 1            | 1                                 |
| 1    | 1    | 1    | 1            | 1                                 |

* DMux

```
DMux(in, sel)={a, b}={And(Not(sel), in), And(sel, in)}
```

| in   | sel  | a    | b    | And(Not(sel), in) | And(sel, in) |
| ---- | ---- | ---- | ---- | ----------------- | ------------ |
| 0    | 0    | 0    | 0    | 0                 | 0            |
| 1    | 0    | 1    | 0    | 1                 | 1            |
| 0    | 1    | 0    | 0    | 0                 | 0            |
| 1    | 1    | 0    | 1    | 0                 | 1            |

 

* Not16

```
对bus上的每一个bit应用Not运算，也就是需要总共16个Not门。bus各个bit是通过数组来表示的，bus上的各个bit从右往左，从0到大索引到数组中。 复用之前已经实现的Not门.
```

* And16

```
对16-bit的a bus和b bus各个位分别进行And运算，所以总共需要16个And门。 复用之前已经实现的And门.
```

* Or16

```
对16-bit的a bus和b bus各个位上分别进行Or运算，所以总共需要16个Or门。 复用之前已经实现的Or门.
```

* Mux16

```
对16-bit的a bus和b bus各个位上分别进行Mux操作，所以总共需要16个Mux门. 复用之前已经实现的Mux门.
```

* Or8Way

```
Or8Way(in[8])=in[0] Or in[1] Or in[2] Or in[3] Or in[4] Or in[5] Or in[6] Or in[7]

注意和multi-bit的区别，multi-bit的话output也是multi-bit，而multi-way不会影响output的位数.

复用之前已经实现的Or门.
```

* Mux4Way16

```
因为已经实现过Mux16, 所以第一个想法是应该可以复用之前实现的Mux16.

先当作Mux4Way 1个bit来看, a, b, c, d 4 way是通过两个selection bit来决定哪一个way.

可以发现Mux4Way=Mux(Mux(a,b,sel[0]), Mux(c,d,sel[0]), sel[1])
```

* Mux8Way16

```
因为已经实现过Mux4Way16, Mux16, 所以第一个想法是是否能够复用之前实现的Mux4Way16和Mux16.

同理,当作Mux8Way 1个bit来看, a, b, c, d, e, f, g, h共8个way是通过三个selection bit来决定哪一个way.

可以发现, Mux8Way=Mux(Mux4Way(a,b,c,d,sel[0],sel[1]), Mux4Way(e,f,g,h,sel[0],sel[1]), sel[2])
```

* DMux4Way

```
因为已经实现过DMux, 所以第一个想法是是否能复用.
```

| sel[0] | sel[1] | a    | b    | c    | d    |
| ------ | ------ | ---- | ---- | ---- | ---- |
| 0      | 0      | in   | 0    | 0    | 0    |
| 0      | 1      | 0    | in   | 0    | 0    |
| 1      | 0      | 0    | 0    | in   | 0    |
| 1      | 1      | 0    | 0    | 0    | in   |



* DMux8Way

```
因为已经实现过DMux4Way, 所以第一个想法是否能复用.
```



```
为什么建议按顺序实现门？因为Nand与非门可以实现任意门。
当用Nand实现了Not门之后, Not门可以作为部件被后续的其它门使用；
于是，用Not门和Nand门实现了And门；
接着，用Not门和Nand门实现了Or门；
...
发现Not门依赖Nand门，And门依赖Not门和Nand门, 如果不先实现Not门，则无法发现和证明：通过Nand门，就可以实现任意门！

实现复合门的时候回顾一下之前实现的哪些门可以作为part直接使用.

注意各个门之间pin互联的感觉，脑海中想象画面。

chipset API:
see HDL Survival Guide on officail website.
```






### 02

#### 6 particular chips

* HalfAdder
* FullAdder
* Add16
* Inc16
* ALU

```
基于project 1中实现的gates，按顺序实现上述chip。

第二章的主题是布尔算术和ALU. ALU是CPU的核心组件，其基本功能就是算术运算。算术运算包括加，减，乘，除。
一般硬件级别上实现的是加，减法；乘法和除法是软件级别上实现的，因为更简单，成本更低。硬件级别上的加法是通过布尔运算实现的(也就是算术逻辑通过布尔逻辑实现)，减法运算又可以转换为加法运算。所以，使用布尔逻辑实现算术逻辑中的加法是关键，因为基本的加法，其它算术逻辑都可以实现。加法从最简单的1-bit加法器到multi-bit加法器。

其中，加法算术中的overflow，计算机实际实现中一般不会发告警，所以，要注意overflow的情况，此时获取的运算结果是不正确的。

如何表示二进制数是首先要解决的问题。
正数原码表示，负数补码表示(2's complement representation). 思考为什么？
-x=2^n-x

4-bit的word，2^4=16 possibilities
0000 0
0001 0
0010 2
0011 3
0100 4
0101 5
0110 6
0111 7
1000 -8 (8)
1001 -7 (9)
1010 -6 (10)
1011 -5 (11)
1100 -4 (12)
1101 -3 (13)
1110 -2 (14)
1111 -1 (15)

 -2          
+
 -3
--------
 -5


 14
+
 13
--------
 11
 



 1110
+
 1101
------
11011（溢出舍弃）

11011(ten)=27
1011(ten)=11

1011使用补码表示法进行解读的时候，其表示-5.
可以发现，二进制补码表示法表示负数的情况下，负数的加法和正数的加法是一样的。硬件级别上加法适用于正数的加法和二进制补码表示的负数加法。

再来看一个正数和一个负数的加法：
 2
+
-3
------
-1


 2
+
 13
--------
 15

 0010
+
 1101
-------
 1111
 
 1111(ten)=15
 
 以二进制补码表示法解读，则等于-1.可以发现一个正数和一个负数(in 2's complement representation)的加法用之前硬件级别上实现的加法器同样适用。



减法的实现基础：computing -x
前面已经证实，当使用二进制补码表示法表示负数的时候，正数和负数的加法可以使用同一个加法器。
那么减法又该如何实现呢? 可以发现，a-b=a+(-b).
减法运算就转换为加法运算了，可以已经实现的加法器。所以减法问题转换为如何computing -x。

input: x 
output: -x

idea: 2^n-x = 1+(2^n-1)-x


input: 4
output:-4

2^4-4=12

 1111
-
 0100
-----
 1011
+
 0001
------
 1100

1100使用原码表示法解读为12，使用补码表示法解读为-4.

可以发现上面求负数分为两步，
第一步是(2^n-1)-x, 这个其实可以转换为逻辑运算，异或运算。
第二步是1+?, 因为加法器已经实现了，所以用回实现的加法器就行。

综上，逻辑运算->加法运算->减法运算。(负数需要使用二进制补码表示)

为什么CPU核心部件叫ALU也就能够理解了，算术逻辑单元， 算术运算是基于逻辑运算实现的，逻辑运算又是基于门电路实现的，所以Nand组装计算机成为了可能。
```



* HalfAdder

```
二元加法，并且是1-bit的二元加法，输出也是二元，分别是sum的LSB和MSB(carry bit)。

二元1-bit的加法，可以发现sum的LSB(lowest significant bit)可以通过a和b进行Xor运算得到; MSB(most significant bit)可以通过And运算得到。

所以，可以发现，二元1-bit加法转化为了布尔运算，也就是计算中的算术运算本质也是逻辑运算。
```

* FullAdder

```
FullAdder是三元1-bit的加法运算，从名字可以发现，其应该可以由两个HalfAdder实现。

输入是三元，输出是二元，分别是sum的LSB和MSB(carry bit), 其最大值是三个一相加: 1+1+1=3=(11)binary.

可以发现最大值是11，所以两次HalfAdder只可能最多有一次carry位是1，但是不确定是第一次HalfAdder还是第二次HalfAdder，所以分别对两次HalfAdder的carry位作了Xor操作。
```

* Add16

```
Add16从外部看是二元16-bit的加法运算，其输出是一元16-bit，溢出直接ignore。

从内部来看，相当于二元16-bit对应的每个bit作了三元1-bit的加法运算(FullAdder)，其中第叁元是carry bit，特殊情况是16-bit的第一bit由于其没有前一位加法运算携带的carry 位, 所以只需二元运算, 所以, 其实用HalfAdder chip即可.

```

* Inc16

```
16-bit加法器, 进行加一运算,  二元运算, 第二元为16-bit的常量1, 输出为一元16-bit.

其相当于Add16运算, 只不过第二元是常量的16-bit的1.
```

* ALU

```
入参是两个16-bit的二进制数, 以及6个1-bit的控制位, 实现18中可能的运算; 出参为16-bit的二进制数, 以及两个1-bit的表示位, 分别是zr, ng.

注意的是入参的6个1-bit控制位是有执行顺序, 也就是依次执行zx, nx, zy, ny, f, no就是最终的output.

这些控制位其实就是一个个flag, 类似编程语言中的if-else逻辑(Mux门). 关键是熟悉各个门的一些特性, 比如Mux有if-else逻辑, Or对true敏感, And对false敏感.

输出的两个表示位有点意思, 其组合起来分别表示out的16-bit的二进制数是等于零, 小于零, 还是大于零.

zr,ng分别有以下可能:
0,0: 表示output大于零
1,0: 表示output等于零
0,1: 表示output小于零

1,1的情况只是理论上可能, 实际不会出现.
```



### 03

```
搞懂sequential logic和combinational logic的区别.

前面研究的各种门可以认为输入和输出是即时发生的, 也就是给了门对应的输入, 立刻有了其对应的输出.(或者说input和output是在同一个时间单元发生)。
而计算机不仅要能计算, 还需要能够mantain state, 维护状态, 也就是计算机需要一些记忆单元, 能够存储数据.

计算机中的这些存储设备都是通过时序芯片实现的.

memory element/device: 从名字上可以看出指的是有记忆功能的单元/设备, 包括register, memeory(RAM), counter.

memory在英文里更常用的是记住,记忆的意思, 在计算机领域, 其指的是存储.

说到记忆, 那么就和时间有关系, 计算机是对现实世界的模拟, 那么首先就得解决如何模拟现实中的时间概念.

所有时序芯片都有一个clock input, 用来接收时钟信号!!!

Memory:
(1)main memory: RAM, ...
(2)secondary memory: disks, ...
(3)volatile/non-volatile

FF->DFF->sigle-bit register(load bit as input)->16-bit register->RAM(address as input)

how read and write to the register: by set the load bit.
```

* The clock(时钟)

```
时间的衡量: 计算中使用的是the clock(时钟)来表示时间的流逝, 其会发出连续的交流信号(类似0-1, low-high voltage, tick-tock,一般通过oscillator实现). 

time unit: 这类信号固定是两种信号连续交替出现, 定义从tick开始到tock结束的这段时间为一个时间周期, 也叫作time unit.
所以, 现实中连续的时间在计算机中就被抽象一个个离散的时间单元. 这类时钟信号会通过硬件中的电子回路, 同步传递到所有的时序芯片. 那么, 有了时钟的概念, 在描述门的input和output的时候, 相当于就有了时间限定. 比如, 对于同一个芯片门Not, time unit 1的时候input为a, time unit 2的input为b; 同理output亦是如此.

时间离散而非连续的目的:
为了稳定性. 一个芯片的输入或输出在达到目标状态的时候肯定是有时间消耗的. 而离散的时间, input或ouput只需要在一个时间单元的结束达到目标状态(正确状态)即可, 相当于在时间的开始可以不需要达到目标状态, 给了其达到目标状态的缓冲时间. 所以, 在离散的时间中, 我们可以认为其达到目标状态的时间消耗为0, 或者说是没有延迟的.
```

* Flip flop(触发器)

```
计算机中最基础的时序单元是flip flop, 其有几种变体, 该教程使用的是一种叫做data flip flop(DFF)作为primitive. 所谓触发器, 指的是其只有有时钟信号过来的时候才会触发其执行.

DFF(data flip flop): 拥有一个single-bit的input和一个single-bit的output. (还有一个clock input, 用来接收时钟传递来的时钟信号. 所有时序芯片必须要有的, 毕竟得接收时钟信号.)

其功能相当于: out(t)=in(t-1)

remember one bit of information from t-1, so it can be used at time t.

gate that can flip between two states.

t这里表示的是time unit的序号, 也就是一个时钟周期. DFF做的事情很简单, 就是输出前一个time unit的数据(有了离散的时间概念后, 数据自然有了时间属性, 描述数据就得带上时间属性).



每接收到一个时钟信号, FDD产生一次output.(所有时序芯片都是如此, 在初始状态下, 刚通电的时候, 也就是时间单元1的时候, FDD由于通电前input没有值, 此时相当于无output.).

注意, FDD的关键功能在于数据时间差上(深刻理解其功能公式). 假如, 最开始的时候, FDD的input在时间单元1的时候到达目标状态, 这时候FDD并不会像combinational chip那样立刻有output(时间单元1之前的input相当于空了), 其得等下一个时钟信号传递过来的时候, 才会有output, 所以相当于时间单元t+1, 也就是时间单元为2的时候才会有output, 这样就造成了后续每一个时钟信号过来的时候, input都是前一个时间单元到达的. 故对于FDD来说, 从数值来看, 其input和output的数值是一样的, 但是数据有了时间属性, 其input和output值相等, 但是其input是上一个时间单元的, 通过时钟信号控制, 才会有output.

观察下图, 可知, FDD在time unit 1时无output, 在下一个时间周期时, output前一个时间周期的数值, 相当于记住了前一个时间周期的数值, 即平时我们所说的存储了前一个时间周期的数据.
```

| time unit | 1    | 2    | 3    | 4    |
| --------- | ---- | ---- | ---- | ---- |
| in        | 1    | 0    | 1    | 1    |
| out       |      | 1    | 0    | 1    |

* sequential logic implementation

```
仔细理解下教授视频上的那张图, 理解前一个时间单元的数据是怎么表示的, 所谓的记忆状态是怎么记忆的.

时序芯片: 组合逻辑+时序逻辑

state[t]=f(input, state[t-1]).

基本的思想是将combinational chip的output的各个bit, 分别作为FDD的input(所以需要的是一组FDD),然后将这组FDD的output又作为combinatinal chip的多元input之一.
```

* 1-bit register

```
if load(t-1) then out(t)=in(t-1); else out(t)=out(t-1).

remember state for ever.

1-bit register其实就是1-bit memory了, 理解其实如何记住1-bit的数据, 这个很重要, 是后面更复杂memory的基础.

其和FDD的区别在于, FDD每个时钟周期都会output前一个时钟周期的input; 1-bit register则多了一个load bit输入, 其根据load bit判断是否用input的数据, 还是原FDD output的数据.

Mux+DFF实现.

!!!1-bit register的读写逻辑:
可以发现，每个间单元中，output都会有输出(除了第一个时间单元)，而且输出的都是前一个时间单元保存的数据。其区别在于前一个时间单元存储数据的来源是input，还是旧值。从宏观来看，就是写和读操作。毕竟，先有写，才有读。写在读操作之前，两者是有时间顺序的。

操作序列是这样，
写->读->读：这样子最近一次读的数据其实是最近一次写入的数据，写少读多，说明数据不常变化。
写->读->写->读->写->读: 频繁写入，说明数据频繁变化。

其实每一个时钟周期内芯片都有input和output，区别在于使用者想要的，强调的是什么。
如果你需要最新的输入值，那么必然得先写入最新的，即等一个时间周期，然后才能读到；如果是旧值，那么直接读，不用等一个时间周期，因为前面已经写入过了。
```

* register

```
register's state: the value which is currently stored inside the register.

t时间周期下register的状态, 相当于是t-1时钟周期下register的output.(1-bit register是通过Mux和FDD实现, 状态其实存储在Mux的output).

1-bit register,或者说register, 是最简单的存储单元. 既然是存储单元, 那么肯定有读写功能.

register的读和写：

load bit其实就相当于控制是对其进行读操作, 还是写操作(看着1-bit register的实现图思考).

当load bit是0时, 相当于register的读操作, 读出其前一个时间周期的数据; 
当load bit是1时, 相当于是对register进行写操作, 将新的input(其实是t-1时钟周期时的input)写入到register中(存储到Mux的output, 下次可读).

可以发现，对register进行写的时候，是存在时间周期差的，t-1时钟周期写入到register的数据，在t时钟周期的时候register才能output(t-1时钟周期output的又是前一个时钟周期的数据，想不明白可以看看时序图)。

这一点，和高级程序语言中线程并发场景读写一致性相关，值得细品。
```

* RAM 

```
random access memory. RAM is a sequential chip with a clocked behavior.
一般存储： data, instruction.

可以抽象为:
a sequence of n addressable registers, with addresses 0 to n-1.

at any given of time, only one register in the RAM is selected.

k(width of the address input): k=log2n.

w(word width): no impact on the RAM logic.

RAM的读和写：
因为RAM的内部是由多个register组成，本质上是register的读和写。 

   RAM多了一个寻址入参，其位数和register的数目有关，相当于为每个register编了号，其得能够表示所有register，这就是存储设备上经常说到的寻址，所有存储设备都是时序芯片。
   RAM内部是如何寻址的？也就是如何选中哪个Register？通过Multiplexor和DMultiplexor芯片。

```

* Counter

```
Programme Counter: 程序计数器，一个芯片，一个硬件设备，告诉计算机下一条要执行的指令的地址值。

primitive operations: load, reset, increment.

所以程序计数器有三个控制位，分别是load，reset，increment.(某一时刻只有其中一个能生效)

load: 设置couter的值.
reset: 重置counter的值为0.
increment: counter的值在原值基础上加一。

三个控制位都是对counter进行写操作。

当三个控制位同时为0的时候，则是对counter的读操作。
```



#### Build the following sequential chips

* Bit
* Register
* RAM8
* RAM64
* RAM512
* RAM4K
* RAM16K
* PC

```
基于之前实现的芯片，加上data flip flop(DFF)实现上述的chip。（都是sequential chip
```

* Bit

```
1-bit register。只存储一个bit的信息。
从外部来看，输入包括1-bit的in，load bit， 输出包括1-bit的out。

load bit的作用是控制对register做读操作，还是写操作。load bit为0的时候相当于对register读，load bit为1相当于对register写。

写入的值，在下一个时间周期才能读到。

Mux+FDD实现。
```

* Register

```
16-bit的register，显然，可以通过1-bit register实现。存储16-bit的信息。

其输入包括16-bit的in，load bit， 输出包括16-bit的out。

CPU芯片内部一般都有几个Register,包括data register，address register。
```

* RAM8

```
名字中的8指的是Register的数量(或者说8的单位是Register)，也就是RAM8最多能存储: 8*16-bit的数据量。
RAM作为计算机中的主存，其存储的数据量肯定比单个Register多。
存储设备基本的就是读写功能，但是在一个时钟周期内，无法对其进行全部的读和写。
所以，在一个时钟周期内，对RAM8的读和写是以一个Register的粒度进行的，也就是16-bit。
因此在输入角度上，RAM比Register多了个一个address，其宽度由register的数量决定: k=log2n. 用于寻址，决定对哪块地址，也就是哪个register进行读或写。
```

* RAM64

```
名字中的64的单位是Register，也就是RAM64最多存储的信息量: 64*16-bit.
在一个时钟周期内能读或写的数据量： 16-bit。

发现RAM64=8*RAM8.
```

* PC

```
Program Counter: 程序计数器. 顾名思义， 其存储的是下一次执行的instruction的地址值(非负整数)。

其输入参数除了常规的16-bit的in，还包括了一些control bits.
一些控制位为1时表示,
reset: 重置PC为0.
load:  将in的值写入到PC。
inc: 对PC进行自增1的写入。

同ALU, 依次判断控制位。需要注意的是控制位的顺序，理论上只有一个控制位可以是1(实际只有一个控制位能生效)，但是实际控制位可能同时是1，这时候相当于有了优先级(覆盖了)。

可以发现HLD中的文档注释中三者控制位使用的if-else描述，也就是某个控制位生效，也就是进入了某个if之后，后面的else是不会进入的。

相当于在后面的优先级较低，也就是在控制位同时是1的情况下，inc<load<reset.
所以，使用Mux传递的时候，优先级低优先执行。
```

* RAM512

```
名字中的512单位是Register，也就是RAM512最多能够存储数据量为: 512*16-bit.
在一个时钟周期内能够读或写的数据量: 16-bit.

可以发现，RAM512=8*RAM64.
```



### 04 Machine Language

```
machine language: 关注的是对硬件的direct control(牺牲了可读性，易用性)，是硬件和软件的接口。(It is the interface between hardware and software.It is exactly the way that software can control the hardware)

high-level language: 关注的是generality and power of expression. 

所以，machine language是直接给硬件平台的(其只认二进制码)， high-level language除了控制计算机，更重要的目的是同时提高可读性，更加human readable，是给人看的。

不同的硬件(CPU)都有其固定的指令集，软件级别上的操作，最终都会被翻译为这套指令集中的指令。低级语言更多在一些对程序性能要求很高，需要自定义优化机制的程序上使用。否则高级语言自带的性能优化机制能够满足需求。

assembly language: 汇编语言，低级语言，可读性比二进制机器码强，给人类看的。通过assembler最终翻译回机器指令二进制码。 
```



#### machines language

```
A machine language can be viewed as an agreed-upon formalism, designed to
manipulate a memory using a processor and a set of registers.

机器语言可以认为是一种约定的形式，设计用来通过处理器和一组寄存器来操纵(读和写)内存的目的.

machine language既然是操纵硬件设备，那么主要是哪些设备呢？
主要是三大类：processor, memory(包括了data memory，instruction memory，主要指RAM), register(一组，reside在cpu内部)。
```



#### language

```
A machine language program is a series of coded instructions.

由于machine language是用来对硬件平台direct control，显然，不同硬件平台有不同语法的指令集(通用功能差不多)。 即machine language依赖硬件平台。

理解硬件中word的概念：其是一个数据单元，比如16-bit的cpu架构，那么相当于每次只能操纵的数据只能是16-bit。
不能直接操纵某一个bit，只能先操纵16-bit，然后再操纵16-bit中的某一个bit。也就是从memory读或写入数据，只能是以16-bit作为粒度。读也只能是一次性读出16-bit，写也只能是一次性写入16-bit.

machine language中的一条instruction最终都是被translate成一串二进制数据，在16-bit的cpu架构中，一条instruction的长度是16-bit, 每一个bit或几个bit其都设计有对应表示的含义.
```

##### command

* arithmetic and logic operation



* memory access

```
1.direct addressing
2.immediate addressing
3.indirect addressing:

```



* flow of control

```
1.conditional jump和unconditional jump:

```



##### specification

* 1.Working with registers and memory

```java
//RAM[2]=RAM[0]+RAM[1]
@0
D=M  //D=M[0]

@1
D=D+M  //D=D+M[1]

@2
M=D    //M[2]=D
```

```
可以发现，加法运算，先从主存读取数据到寄存器中，然后再把计算结果从寄存器写入到主存。
所以，在高级语言中，看似是原子操作的操作并非原子的，它需要多条机器指令一起执行才能完成目标。
```

* 2.Branching

```
机器语言中，本身并没有直接的分支逻辑(if)，但是有地址跳转逻辑。

对于计算机而言，分支本质上就是指令的跳转，也就是指令地址值的跳转！！！

这个意识很重要，因为各种高级语言中都会有分支逻辑，虽然它们语法上各不相同，但是得意识到最终它们在机器语言层面上都是通过地址跳转实现的。

高级语言->低级语言->机器语言。

学习课程中的demo，仔细体会。

当然，为了提高可读性，assembly language提供了一些语法糖，使汇编语言的分支语法可读性更高。
引用了Donald Knuth(美国计算机科学家,现代计算机科学先驱人物，图灵奖得主)的一个观点:
Instead of imagining that our main task as programmer is to instruct a computer what to do, let us concentrate rather on explaining to human beings what we want a computer to do.

symbolic references.(assembly language中的语法糖，提高了可读性)

(1)declare label
(2)use label

@label translate to @n by the assembler, where n is the instruction number following the label declaration.



symbol program(符号化编程)的好处之一，地址的具体值交给assember和loader处理，而不需要hardcode。
计算机最终是一条一条instruction执行(执行program counter存储的地址值指向的指令)，每条instruction在ROM中都有其对应的地址值。

符号化编程的应用: label和variable。



hardcode意味着写assembly或者machine language的人得提前假设指令的地址(事实上无法知道加载这段指令序列到ROM时的起始地址/base address是什么，所以hard code的写法相当于起始地址为0，也就是ROM的起始位置)。
```



* 3.Variables

```
variable is an obstruction of a container that has a name and a value.

In higher language, there are different types of variables and different types of values.

In Hack machine language, there is only one type of variable and only need to worry about the 16-bit value. So we use a single register in RAM to implements the variable.

@temp: find some available memory register(say register n) and use it to represent the variable temp.(no need to declaration).

@temp->@n

指在data memory临时找的一个availabe的register，可以看作是一个拥有name和value的container。这个负责找available的空间是loader负责的事情，不是写language的人需要考虑的(毕竟在写程序的时候也不知道哪块空间是available的，只有loader加载程序的那刻其知道)。
```



* 4.Iteration

```
迭代(循环)也是高级语言中的基本语法，不同高级语言语法上有细微差异。理解机器语言上迭代如何实现，有助于快速上手高级语言中的循环语法。机器语言中的迭代(循环)和branching一样，也是通过指令地址跳转实现的。

课程中也说到程序设计时(技术面试题也是如此)的一套最佳实践理论:
(1)提问，确定需求
(2)设计算法
(3)pseudo code(伪代码)
(4)implement
(5)test(trace table,etc.)
```

```
//computes:RAM[1]=1+2+3...+n
//usage: put a number(n) in RAM[0]

//pseudo code
sum=0
i=1
n=RAM[0]

LOOP:
	if i>n goto STOP
	sum=sum+i
	i=i+1
	goto LOOP
STOP:
	RAM][1]=sum
END:
    infinite loop
```



* 5.Pointers

```
pointers: variables that store memory addresses like arr and i are called pointers.

typical pointer semantics:
set the address register to the contents of some the memory register.

从计算机角度，存储的都是二进制码，但是其表示的含义是人为赋予的。对于指针，就是特指存储了表示地址值含义数据的空间，指针是从人的角度定义，可以理解为存储了特殊值(主存地址值)的变量。

何为地址？内存被以固定的大小为单位，划分为一块块区域并从0开始编号，这些编号就是地址。

如何使用指针？得先将指针的值加载到CPU的地址寄存器中，然后再寻址，获取指向的内存区域的值。

比如数组，我们知道数组是内存(主存)中的一块连续的空间，那么如何表示数组arr呢?

因为地址连续，所以只需要知道起始地址，以及数组长度即可，所以需要以下变量:
arr: 存储了数组起始地址值的变量
n: 存储了数组长度的变量

所以你可以发现，在java中，声明数组必须给出数组长度。(ArrayList是通过数组实现的，所以默认隐式的给了长度)。
```

```java
//suppose that arr=100 and n=10
//pseudo code
for(i=0; i<n; i++){
    arr[i]=-1
}
```

```java
//pseudo code
arr=RAM[0]
n=RAM[1]
i=0
    
LOOP:
	if i==n goto END
	arr[i]=-1
    i=i+1
END:
	infinite loop
```



* 6.Input/Output

```
output: screen
input: keyboard
```

```
   用户无法直接操控IO设备，但是CPU是通过memory map来与IO设备交互的，所以可以通过操控IO设备对应的memory map，间接操控IO设备。
   
screen: 显示器是输出设备的基本且典型代表，通过实现操控其对应的memory map，在screen上画一个填充的长方形，相当于计算机图像化的一个hello world程序。(screen每一个pixel对应其memory map的一个bit)。模拟屏幕的一行假设有512 pixels。

分析: 模拟屏幕一行512 pixels=32*16 pixels，相当于一行有32个words.(RAM中是由16-bit register组成)。
```

```java
//pseudo code
addr=SCREEN    //the base address of the screen in RAM.
n=RAM[0]       //the length of the rectangle
i=0            //row number
    
LOOP:
	if i==n goto END
	RAM[addr]=-1   //1111 1111 1111 1111
	addr=addr+32
    i=i+1
    goto LOOP

END:
	goto END
```



```
问题：
1.how can we end the programme safely?
we can end the programme with an infinite loop.

2.assembly code为什么要增加built-in symbols?

硬件对应的二进制指令集是固定的，但是汇编语言是给开发人员使用的，所以可以在可读性上，使用方便性上进行增强，比如将内置一些高频使用的常量，这样人类在阅读和写汇编语言的时候可读性更强，使用更加方便。毕竟这些通过assember最终都会翻译为我们无法改变的二进制指令集。从二进制指令集的角度来讲，汇编语言这些内置符号对于其是透明的，也就是语法糖。对于跟高级的语言同理，例如java每次新版本中也许增加了一些新的语法特性，从字节码角度来讲，这些语法特性对于其也许是透明的，经过javac处理后，这些新的语法特性并没有改变字节码本身。(分层，降维打击).


小思考:
  这个规范指的是在该教程中设计的计算机，名字叫做Hack，设计的其对应的指令集(机器语言)提供的功能。可以发现划分为了6个部分。其实，这也是所有现代化计算机基本会提供的功能。不同计算机(CPU)对应有一套其自己的指令集，基本功能差不多(实现上有区别,所以性能上有差异)，这些都是硬件层面上决定了的。
  因此，所有其它软件层面的高级语言最终都会被翻译为指令集中的对应的指令。区别在于如何翻译(也决定了不同语言在性能上的差异)，可以说是殊途同归。操作系统也是软件，也是某种编程语言实现的，其最终也是翻译为硬件级别上的具体的指令。(不同硬件厂商都遵循一定的标准，除了类似苹果这种封闭的生态，那么其硬件的一些接口和指令没有开放出来，那么在其硬件上就只能装其自己开发的操作系统)。机器语言最终都是一系列二进制指令，设计的时候一般都有设计其对应的符号表示(汇编语言,symbolic code,assembly code)，毕竟低级语言开发者不可能直接使用二进制码进行开发，他们同样得查询汇编语言的规范来使用汇编语言控制计算机，需要知道每条指令的语义(semantics),不能想当然。
  高级语言和低级语言的一个区别就是高级语言帮开发者隐藏了一些东西，使开发者更容易理解。比如，高级语言不会有直接对内存和寄存器操作的语法(虽然底层最终肯定是这样)。从高级语言到最终的机器语言二进制码之间隔了好几层。
```



#### perspective

```
   不管是何种的存储设备，包括RAM, ROM, CACHE, FLASH Memory等，从逻辑角度看，它们看起来是相似的，都可以看作是一组register，而且是可以被寻址的。
   
1.Flip flop实际中是怎么实现的。
2.现代计算机存储设备大多也是基于flip-flop建立的吗。
not always. modern memory chips are usually very carefully optimized, exploiting the unique physical properties of the underlying storage technology. 
现代计算机设计者有了很多可选的技术方案(alternative technologies)，使用哪种方案是一个性价比的问题。
3.除了RAM，计算机还使用了哪些存储设备。
RAM依赖于external power supply，电脑关机后会被erased，所有数据会丢失。
ROM是read only memory，其不依赖外部电源，即使电脑关机数据还是会存在的，而且是只读的不能再次写。一般存放的是用于初始化的启动程序。比如，电脑开机时候的启动程序就放在ROM中，其会去做一些初始化操作，包括从存放操作系统程序的磁盘加载操作系统，从而我们能在屏幕上能看到界面。
4.为什么需要Cache。
存储设备一般越快越小，则越贵。CPU计算速度很快，所以CPU需要用到的数据则放在相对快速的存储设备，较少用到的数据则放在相对较慢的存储设备。需要在各个因素之间取得一个平衡。
```



#### project

* objective

```
   get a taste of low-level programming in machine language, and get acquainted with the Hack computer platform.
```

##### Multiplication Program

```
R2=R0*R1
```

```
  在Hack computer中，硬件级别上只实现了addtition和substraction. 那么，软件级别(assembly language)如何实现乘法器？软件层的功能必然依赖于下一层的功能，所以使用assembly language实现乘法，必然依赖于硬件层已经实现的加法，可以考虑将乘法运算转换为加法运算。(程序要求中R0和R1存储的都是正数,不用考虑负数的场景，难度降低)
  a*b=a+a+...+a
```

* pseudo code

```java
a=RAM[0]
b=RAM[1]
sum=0
i=0

LOOP:
	if i==b goto END
	sum=sum+a
	i=i+1
    goto LOOP
STOP:
	RAM[2]=sum
	goto END
END:
	goto END
```



##### I/O-Handling Program

```
当键盘有有按键时，屏幕变黑;否则屏幕变白。

The Hack computer includes a black-and-white screen organized as 256
rows of 512 pixels per row
模拟屏幕一行有32个words(16-bit), 2^8=256行。模拟屏幕占用的总的words=32*256=8192 words.

思路:
监听(loop实现)键盘对应memory map的值, 0表示无scan code，其余表示有scan code。0的时候screen渲染为白色，即screen对应memory map填充0；1的时候渲染为黑色，即memory map填充1。读取一次键盘，渲染一次，继续下一次读取，如此循环。(相当于每次循环是以一个word为单位来渲染,一次渲染16个pixels)
```

* pseudo code

```
count=32*256=8192     //total words of screen memory map. 

READ_KEYBOARD:
kbd=KBD               //base address of the keyboard in RAM 
i=0					  //reset i

if kbd==0
	goto PAINT_WHITE 
else 
	goto PAINT_BLACK
	
	
PAINT_WHITE:
	color=0
	goto PAINT_LOOP
	

PAINT_BLACK:
	color=-1               //-1: 1111 1111 1111 1111
	goto PAINT_LOOP
	
PAINT_LOOP:
	if i==count goto READ_KEYBOARD
	
	addr=SCREEN+i    //address of the pixel that ready to paint
	
	RAM[addr]=color //paint the pixel
	
	i=i+1	
	goto PAINT_LOOP
```





