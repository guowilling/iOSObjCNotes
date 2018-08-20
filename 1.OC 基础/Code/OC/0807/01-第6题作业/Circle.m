/**
 设计一个类Circle，用来表示二维平面中的圆
 属性
 * double _radius
 * Point2D *_point
 
 方法
 * 属性相应的set和get方法
 * 设计一个对象判断跟其他圆是否重叠（重叠返回YES，否则返回NO）
 * 设计一个类方法判断两个圆是否重叠（重叠返回YES，否则返回NO）
 */
 
#import "Circle.h"

@implementation Circle

- (void)setRadius:(double)radius
{
    _radius = radius;
}
- (double)radius
{
    return _radius;
}



- (void)setPoint:(Point2D *)point
{
// [_point setX:[point x]];
// [_point setY:[point y]];
    _point = point;
}
- (Point2D *)point
{
    return _point;
}

- (BOOL)isInteractWithOther:(Circle *)other
{
 
    Point2D *p1 = [self point];
    Point2D *p2 = [other point];
    double distance = [p1 distanceWithOther:p2];
    
    double radiusSum = [self radius] + [other radius];
    
    //    if (distance < radiusSum)
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    
    //    if (distance < radiusSum)
    //    {
    //        return 1;
    //    }
    //    else
    //    {
    //        return 0;
    //    }
    
    return distance < radiusSum;
}

+ (BOOL)isInteractBetweenCircle1:(Circle *)c1 andCircle2:(Circle *)c2
{
    return [c1 isInteractWithOther:c2];
}
@end