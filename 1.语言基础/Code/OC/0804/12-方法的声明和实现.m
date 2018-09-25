
#import <Foundation/Foundation.h>

@interface JiSuanQi : NSObject 

- (double)pi;

- (int)pingFang:(int)num;

// 一个参数对应一个冒号
// 方法名：sumWithNum1:andNum2:
- (int)sumWithNum1:(int)num1 andNum2:(int)num2;

@end

@implementation JiSuanQi

- (double)pi
{
    return 3.14;
}

- (int)pingFang:(int)num
{
    return num * num;
}

- (int)sumWithNum1:(int)num1 andNum2:(int)num2
{
    return num1 + num2;
}
@end

int main()
{
    JiSuanQi *jsq = [JiSuanQi new];
    
    // int a =  [jsq pingFang:10];
    // double a = [jsq pi];
    int a = [jsq sumWithNum1:20 andNum2:5];
    NSLog(@"%i", a);
    
    return 0;
}
