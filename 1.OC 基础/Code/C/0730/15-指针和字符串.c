
#include <stdio.h>

/*
 1.常量区
 存放常量字符串
 
 2.堆
 存放对象
 
 3.栈
 存放局部变量
 
 定义字符串的两种方式：
 利用数组
 char name[] = "itcast";
  * 特点：字符串，里面的字符可以修改
  * 使用场合：字符串的内容需要修改
 
 利用指针
  char *name = "itcast";
  * 特点：常量字符串，里面的字符不能修改
  * 使用场合：字符串的内容不需要修改
 */

int main()
{
    char name[20];
    
    printf("请输入姓名：\n");
    
    scanf("%s", name);
    
    // 'j' 'a' 'c' 'k' '\0'
    
    // printf("%c\n", name[3]);
    
    // printf("刚才输入的字符串：%s\n", name);
    
    return 0;
}

// 字符串数组
void test2()
{
    char *name = "jack";
    
    // int ages[5];
    
    // 指针数组（字符串数组）
    char *names[5] = {"jack", "rose", "jake"};
    
    // 二维字符数组（字符串数组）
    char names2[2][10] = {"jack", "rose"};
}

// 字符串
void test()
{
    // 字符串变量
    char name[] = "it";
    name[0] = 'T';
    
    // printf("%s\n", name);
    
    
    // "it" == 'i' + 't' + '\0'
    // name2指向字符串的首字符，字符串常量
    char *name2 = "it";
    
    char *name3 = "it";
    
    // *name2 = 'T';
    
    // printf("%c\n", *name2);
    
    printf("%p\n%p\n", name2, name3);
    
    // printf("%s\n", name2);
}