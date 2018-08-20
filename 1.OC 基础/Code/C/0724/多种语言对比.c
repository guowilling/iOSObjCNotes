使用3种语言在屏幕上输出“哈哈”并换行

1.C语言
#include <stdio.h>
int main()
{
    printf("哈哈\n");
    return 0;
}

2.Objective-C(OC)
#import <Foundation/Foundation.h>
int main()
{
    NSLog(@"哈哈");
    return 0;
}

3.Java
class Test
{
    public static void main(String[] args)
    {
        System.out.println("哈哈");
    }
}