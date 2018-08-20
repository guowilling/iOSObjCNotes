#import "Point2D.h"
#import <Foundation/Foundation.h>

@interface Circle : NSObject
{
    // 半径
    double _radius;
    // 圆心
    // double _x;
    // double _y;
    Point2D *_point;
}

- (void)setRadius:(double)radius;
- (double)radius;

- (void)setPoint:(Point2D *)point;
- (Point2D *)point;

- (BOOL)isInteractWithOther:(Circle *)other;

+ (BOOL)isInteractBetweenCircle1:(Circle *)c1 andCircle2:(Circle *)c2;

@end