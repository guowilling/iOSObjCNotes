/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>
#import "Book.h"

@interface Person : NSObject
{
    Book *_book;
}

- (void)setBook:(Book *)book;
- (Book *)book;

@end
