#include <stdio.h>

int main()
{
    // char name[] = {'i', 't', 'c', 'H', 's', 't', '\0'};
    char name[] = "itcast";
    
    name[3] = 'H';
    
    /*
    int size = sizeof(name);
    printf("%d\n", size);
     */
    printf("我在%s上课\n", name);
    
    return 0;
}

// 字符串初始化
void test2()
{
    // \0的ASCII码值是0
    // 以下都是字符串
    char name1[8] = "it";
    char name2[8] = {'i', 't', '\0'};
    char name3[8] = {'i', 't', 0};
    char name4[8] = {'i', 't'};
    
    // 不算字符串（只能算字符数组）
    char name5[] = {'i', 't'};
}

/*
void test()
{
    // 'a' 'b' 'A'
    // "jack" == 'j' + 'a' + 'c' + 'k' + '\0'
    
    char name[10] = "jack888\n";
 
    printf(name);
    
    printf(name);
    
    printf(name);
    
    printf("578435");
}
 */