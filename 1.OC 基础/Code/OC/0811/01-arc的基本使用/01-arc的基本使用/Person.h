/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>

@class Dog;

@interface Person : NSObject

@property (nonatomic, strong) Dog *dog;


@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int age;

@end
