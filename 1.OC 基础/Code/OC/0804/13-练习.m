
#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    @public
    int speed;
}

- (int)compareSpeedWithOther:(Car *)other;

@end

@implementation Car

- (int)compareSpeedWithOther:(Car *)other
{
    return speed - other->speed;
}

@end

int main()
{
    Car *c1 = [Car new];
    c1->speed = 300;
    
    Car *c2 = [Car new];
    c2->speed = 250;
    
    int a = [c1 compareSpeedWithOther:c2];
    
    NSLog(@"a=%d", a);
    
    return 0;
}