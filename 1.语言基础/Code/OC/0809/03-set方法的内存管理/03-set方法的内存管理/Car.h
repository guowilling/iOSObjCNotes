/*
 作者：MJ
 描述：
 时间：
 文件名：Car.h
 */
#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    int _speed;
}

- (void)setSpeed:(int)speed;
- (int)speed;
@end
