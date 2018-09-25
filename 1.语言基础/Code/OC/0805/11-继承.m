
#import <Foundation/Foundation.h>

/********Animal的声明*******/
@interface Animal : NSObject
{
    int _age;
    double _weight;
}

- (void)setAge:(int)age;
- (int)age;

- (void)setWeight:(double)weight;
- (double)weight;
@end
/********Animal的实现*******/
@implementation Animal
- (void)setAge:(int)age
{
    _age = age;
}
- (int)age
{
    return _age;
}

- (void)setWeight:(double)weight
{
    _weight = weight;
}
- (double)weight
{
    return _weight;
}
@end

/********Dog*******/
@interface Dog : Animal
@end

@implementation Dog
@end

/********Cat*******/
@interface Cat : Animal
@end

@implementation Cat
@end

int main()
{
    Dog *d = [Dog new];
    
    [d setAge:10];
    
    NSLog(@"age=%d", [d age]);
    return 0;
}