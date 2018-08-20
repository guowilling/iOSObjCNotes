/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>

/*
 1.setter方法内存管理相关的参数
 * retain : release旧值，retain新值（适用于OC对象类型）
 * assign : 直接赋值（适用于非OC对象类型）（默认）
 * copy   : release旧值，copy新值
 
 2.是否要生成set方法
 * readwrite : 同时生成setter和getter的声明、实现(默认)
 * readonly  : 只生成getter的声明、实现
 
 3.多线程管理
 * nonatomic : 性能高 (一般用这个)
 * atomic    : 性能低（默认）
 
 4.setter和getter
 * setter : 决定了set方法的名称
 * getter : 决定了get方法的名称
 */

@interface Person : NSObject

@property (getter = isRich) BOOL rich;


@property (nonatomic, assign, readwrite) int weight;
// setWeight:
// weight

@property (readwrite, assign) int height;

@property (nonatomic, assign) int age;

@property (retain) NSString *name;

@end
