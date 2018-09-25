//
//  Person.h
//  05-成员变量的作用域
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 @public    : 任何地方都能直接访问
 @private   : 只有在当前类中才能直接访问（@implementation中默认是@private）
 @protected : 可以在当前类及其子类中才能直接访问（@interface中默认是@protected）
 @package   : 处于同一个框架中就能直接访问
 
 @interface和@implementation中不能声明同名的成员变量
 */

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _no;
    
    @public
    int _age;
    
    @private
    int _height;
    
    @protected
    int _weight;
    int _money;
}

- (void)setHeight:(int)height;
- (int)height;

- (void)test;

@end
