
/*
 外部函数：定义的函数能被其他文件访问
    默认所有的函数都是外部函数
    不允许同名的外部函数
 
 内部函数：定义的函数不能被其他文件访问
    允许不同文件中有同名的内部函数
 
 static作用于函数：
    定义一个内部函数
    声明一个内部函数
 
 extern作用于函数： (extern可以省略)
    完整地定义一个外部函数
    完整地声明一个外部函数
 */

void test();

void test2();

int main()
{
    test();
    
    test2();
    
    return 0;
}

void test()
{
    
}

static void test2()
{
    
}

