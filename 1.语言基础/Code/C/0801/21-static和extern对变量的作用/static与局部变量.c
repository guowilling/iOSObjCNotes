#include <stdio.h>

void test()
{
    static double pi = 3.14;
    
    double zc = 2 * pi * 10;
    
    int a = 0;
    
    a++;
    
    printf("a的值是%d\n", a); // 1
    
    /*static修饰局部变量作用：
                            延长局部变量的生命周期：程序结束局部变量才会销毁
                            没有改变局部变量的作用域
                            变量b只赋值一次*/
    static int b = 0;
    b++;
    printf("b的值是%d\n", b); // 3
}

int main()
{
    for (int i = 0; i<100; i++) {
        test();
    }
    
    test();
    
    test();
    
    test();
    
    return 0;
}
