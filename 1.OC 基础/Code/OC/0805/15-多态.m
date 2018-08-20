#import <Foundation/Foundation.h>

// 动物
@interface Animal : NSObject
- (void)eat;
@end

@implementation Animal
- (void)eat
{
    NSLog(@"Animal--吃东西");
}
@end

// 狗
@interface Dog : Animal
- (void)run;
@end

@implementation  Dog
- (void)run
{
    NSLog(@"Dog--跑起来");
}
- (void)eat
{
    NSLog(@"Dog--吃东西");
}
@end

// 猫
@interface Cat : Animal

@end

@implementation Cat
- (void)eat
{
    NSLog(@"Cat--吃东西);
}
@end

//void feed(Dog *d)
//{
//    [d eat];
//}
//
//void feed2(Cat *c)
//{
//    [c eat];
//}
//

void feed(Animal *a)
{
    [a eat];
}

int main()
{
    
	// 编译时看左边, 运行时看右边
    Animal *aa = [Dog new];
   
    // [aa run]; // OC弱语言警告不报错; JAVA强语言直接报错
    Dog *dd = (Dog *)aa;
    [dd run];
    
//    Animal *aa = [Animal new];
//    feed(aa);
//    
//    Dog *dd = [Dog new];
//    feed(dd);
//    
//    Cat *cc = [Cat new];
//    feed(cc);
    
    // 多态: 父类指针指向子类对象
    Animal *a = [Dog new];
    // 调用方法时会检测对象的真实类型(动态绑定)
    [a eat];
    
    return 0;
}