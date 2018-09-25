#include <stdio.h>

int main()
{
    enum Sex{
        Man,
        Woman,
        Unkown
    };
    
    // int sex = 3;
    // enum Sex s = Unkown;
    
    // 定义枚举类型
    enum Season{
        spring = 1,
        summer,
        autumn,
        winter
    };
    
    // 定义枚举变量
    enum Season s = summer;
    
    printf("%d\n", s);
    
    return 0;
}