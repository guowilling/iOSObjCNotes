
#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)test;

@end

@implementation Person

//- (void)test
//{
//    NSLog(@"哈哈哈");
//}

@end

// 运行过程中才会检测对象有没有实现方法
// -[Person test]: unrecognized selector sent to instance 0x7fd2ea4097c0
int main()
{
    Person *p = [Person new];
    [p test];
    return 0;
}