/*
 设计一个类Point2D，用来表示二维平面中某个点
 属性
 * double _x
 * double _y
 
 方法
 * 属性相应的set和get方法
 * 设计一个对象方法同时设置x和y
 * 设计一个对象方法计算与其他点的距离
 * 设计一个类方法计算两个点之间的距离
 */

#import "Point2D.h"
#import <math.h>

@implementation Point2D

- (void)setX:(double)x
{
    _x = x;
}
- (double)x
{
    return _x;
}


- (void)setY:(double)y
{
    _y = y;
}
- (double)y
{
    return _y;
}


- (void)setX:(double)x andY:(double)y
{
    /**
     _x = x;
     _y = y;
     */
    
    /**
     self->_x = x;
     self->_y = y;
	 */
    [self setX:x];
    [self setY:y];
}

- (double)distanceWithOther:(Point2D *)other
{

// return [Point2D distanceBetweenPoint1:self andPoint2:other];
    

    double xDelta = [self x] - [other x];
    double xDeltaPF = pow(xDelta, 2);
    
    double yDelta = [self y] - [other y];
    double yDeltaPF = pow(yDelta, 2);
    
    return sqrt(xDeltaPF + yDeltaPF);
}

+ (double)distanceBetweenPoint1:(Point2D *)p1 andPoint2:(Point2D *)p2
{
    return [p2 distanceWithOther:p1];
    
// return [p1 distanceWithOther:p2];
    
}
@end