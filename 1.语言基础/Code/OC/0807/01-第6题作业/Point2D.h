#import <Foundation/Foundation.h>

@interface Point2D : NSObject
{
    double _x;
    double _y;
}

- (void)setX:(double)x;
- (double)x;

- (void)setY:(double)y;
- (double)y;

- (void)setX:(double)x andY:(double)y;


- (double)distanceWithOther:(Point2D *)other;

+ (double)distanceBetweenPoint1:(Point2D *)p1 andPoint2:(Point2D *)p2;

@end