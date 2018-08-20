//
//  main.m
//  02-构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

// 构造方法：用来初始化对象的方法, 对象方法

// 重写构造方法的目的: 初始化成员变量默认值
// 重写构造方法的注意点: 必须先调用父类的构造方法初始化父类的成员变量

int main()
{
    // Person *p = [Person new];
    
    // 完整地创建一个可用的对象的步骤
    // 1.调用 + alloc分配存储空间
    // Person *p1 = [Person alloc];
    // 2.调用 - init进行初始化
    // Person *p2 = [p1 init];
    
    Person *p4 = [[Person alloc] init];
    
    Student *stu = [[Student alloc] init];
    
    
    return 0;
}

