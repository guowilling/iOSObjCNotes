
#import <Foundation/Foundation.h>

@interface JiSusnQi : NSObject
+ (int)sumOfNum1:(int)num1 andNum2:(int)num2;

+ (int)averageOfNum1:(int)num1 andNum2:(int)num2;
@end

@implementation JiSusnQi
+ (int)sumOfNum1:(int)num1 andNum2:(int)num2
{
    return num1 + num2;
}

+ (int)averageOfNum1:(int)num1 andNum2:(int)num2
{
    // 类方法中, self代表类
    int sum = [self sumOfNum1:num1 andNum2:num2];
    return sum / 2;
}
@end

int main()
{
    int a = [JiSusnQi averageOfNum1:10 andNum2:12];
    
    NSLog(@"a=%d", a);
    
    return 0;
}