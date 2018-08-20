#include <stdio.h>
/*
 参数注意点
    1.形式参数：定义函数时函数名后面括号中的参数,简称形参
    2.实际参数：调用函数时传入的参数，简称实参
    3.实参个数必须等于形参个数
    4.函数体内部不能定义和形参一样的变量
    5.基本数据类型作为函数形参，修改函数内部形参的值，不会影响外面实参的值（值传递）
    6.函数可以没有形参，可以有n个形参
 */

// 形参 num1,num2
int sum(int num1, int num2)
{
    // 内部不能定义和形参一样的变量
    // int num1;

    num1 = 50;
    return num1 + num2;
}

/*
 return的作用：
    1> 退出函数
    2> 返回一个值给函数调用者
 
 返回值注意点
    1> void代表没有返回值
    2> 如果没有明确声明返回值类型，默认返回int类型
    3> 就算明确声明返回值类型，也可以不返回任何值
 */

char test()
{
    return 'A';
}

/*
void test(int a, int b)
{
 
}
 */

void test5()
{
    
}

/* 伪代码
void login(QQ, 密码)
{
 
    if (QQ没有值) return;
    if (密码没有值) return;
    
    // 发送到服务器
}
 */

int test3()
{
    printf("999999\n");
}

// 如果不明确声明返回值类型，默认int类型
test2()
{
    printf("88888\n");
    return 10;
}

int main()
{
    int c = test2();
    printf("c=%d\n", c);
    
    test3();
    
    /*
    int a = 100;
    int b = 27;
    
    // a、b称为函数的实际参数
    int c = sum(a, b);
    printf("a=%d, b=%d, c=%d\n", a, b, c);
     */
    return 0;
}