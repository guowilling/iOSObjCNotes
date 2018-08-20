//
//  main.m
//  04-Category-分类
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 分类作用: 不改变类内容, 为类增加方法
 使用注意:
 1.分类通常用于增加方法
 2.分类可以访问原类中声明的成员变量
 3.分类可以重新实现原来类中的方法(不推荐)
 4.方法调用的优先级：分类(最后被编译的分类优先) -> 原类 -> 父类
 */

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+MJ.h"
#import "Person+JJ.h"

int main()
{
    Person *p = [[Person alloc] init];
    p.age = 10;
    
    [p test];
    [p study];
    
    return 0;
}

