
#import <Foundation/Foundation.h>

/*
 super作用:
     1.子类调用父类的某个方法
     2.super用在对象方法中调用父类的对象方法, super用在类方法中调用父类的类方法
 
 使用场合: 子类重写父类的方法时保留父类的行为
 */

// 基类僵尸
@interface Zoombie : NSObject
- (void)walk;

+ (void)test;
- (void)test;

@end

@implementation Zoombie
- (void)walk
{
    NSLog(@"挪两步******");
}

+ (void)test
{
    NSLog(@"Zoombie+test");
}

- (void)test
{
    NSLog(@"Zoombie-test");
}
@end

// 跳跃僵尸
@interface JumpZoombie : Zoombie
+ (void)haha;
- (void)haha2;
@end


@implementation JumpZoombie

+ (void)haha
{
    [super test];
}

- (void)haha2
{
    [super test];
}

- (void)walk
{
    [super walk];
    
    NSLog(@"跳两下");
}
@end

int main()
{
    [JumpZoombie haha];
    
    JumpZoombie *jz = [JumpZoombie new];
    [jz haha2];
    
    return 0;
}