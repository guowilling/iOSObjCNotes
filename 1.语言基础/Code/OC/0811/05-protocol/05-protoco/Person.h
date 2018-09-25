/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>

//#import "MyProtocol3.h"
//#import "MyProtocol2.h"

@class Hashiqi;


@protocol MyProtocol2;
@protocol MyProtocol3;

//  :  继承父类
// < > 遵守协议
@interface Person : NSObject <MyProtocol3, MyProtocol2>

@property (nonatomic, strong) id<MyProtocol2> obj;

@property (nonatomic, strong) Hashiqi *dog;

@end
