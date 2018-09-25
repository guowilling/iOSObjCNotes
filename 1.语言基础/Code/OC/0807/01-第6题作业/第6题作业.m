
#import "Point2D.h"
#import "Circle.h"

int main()
{
    Circle *c1 = [Circle new];
    [c1 setRadius:1];
    Point2D *p1 = [Point2D new];
    [p1 setX:15 andY:15];
    [c1 setPoint:p1];
 
    Circle *c2 = [Circle new];
    [c2 setRadius:2];
    Point2D *p2 = [Point2D new];
    [p2 setX:12 andY:19];
    [c2 setPoint:p2];
    
    // BOOL b = [c1 isInteractWithOther:c2];
    BOOL b = [Circle isInteractBetweenCircle1:c1 andCircle2:c2];
    NSLog(@"%d", b);
    
    
    Point2D *p1 = [Point2D new];
    [p1 setX:10 andY:15];
    
    Point2D *p2 = [Point2D new];
    [p2 setX:13 andY:10];
    
    // double distance = [p1 distanceWithOther:p2];
    double distance = [Point2D distanceBetweenPoint1:p1 andPoint2:p2];
    NSLog(@"%f", distance);
    
    return 0;
}