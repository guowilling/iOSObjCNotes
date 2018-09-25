一、基本数据类型
1.int
    long int、long            ：8个字节    %ld
    short int、short          ：2个字节    %d或者%i
    unsigned int、unsigned    ：4个字节    %zd
    signed int、signed、int  ：4个字节    %d或者%i

2.float\double
    float   ：   4个字节 %f
    double  ：   8个字节 %f

3.char
    char    ：   1个字节 %c或者%d
    char类型在内存中是ASCII值
    'A' --> 65

二、构造类型
1.数组
    同一种类型的数据组成
    定义：数据类型 数组名[元素个数];

2.结构体
    不同类型的数据组成
    先定义类型，再利用类型定义变量

三、指针类型
    int a = 10;
    int *p = &a;
    *p = 20;

四、枚举类型
使用场合：变量只有几个固定取值