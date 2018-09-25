/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>
#import "Book.h"

@interface Person : NSObject

@property int age;

// retain: 生成的setter方法里面，release旧值，retain新值
@property (retain) Book *book;

@property (retain) NSString *name;

@end
