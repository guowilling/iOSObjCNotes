//
//  Dog.h
//  06-@property和@synthesize
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
{
    // 如果想子类可以直接访问, 手动生成_age, 指明@protected修饰
//	@protected
//	int _age;
}

// 1.自动生成_age成员变量(@private)
// 2.setAge和age方法的声明
// 3.setAge和age方法的实现
@property int age;

@end