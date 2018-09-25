
#import <Foundation/Foundation.h>


//self:
//	* self出现在对象方法中, self代表当前对象
//	* self出现在类方法中, self代表当前类


@interface Dog : NSObject
- (void)bark;
- (void)run;
@end

@implementation Dog
- (void)bark
{
    NSLog(@"汪汪汪");
}
- (void)run
{
    [self bark];
    NSLog(@"跑跑跑");
}
@end

int main()
{
    Dog *d = [Dog new];
    
    [d run];
    
    return 0;
}