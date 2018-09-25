/*
 作者：MJ
 描述：
 时间：
 文件名：Book.h
 */
#import <Foundation/Foundation.h>

@interface Book : NSObject
{
    int _price;
}

- (void)setPrice:(int)price;
- (int)price;


@end
