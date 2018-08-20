
#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    @public
    int speed;
}
- (void)run;
@end

@implementation Car

- (void)run
{
    NSLog(@"速度为%d的车子跑起来了", speed);
}

@end


int main()
{

//    Car *c;
//    c = [Car new];
//    c->speed = 250;
//    [c run];

    [Car new]->speed = 300;
    
    [[Car new] run];
    
    return 0;
}
