/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, assign) int age;


+ (id)person;

+ (id)personWithAge:(int)age;

@end
