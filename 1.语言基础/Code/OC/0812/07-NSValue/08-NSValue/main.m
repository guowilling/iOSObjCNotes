//
//  main.m
//  08-NSValue
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSNumber之所以能包装基本数据类型是因为继承了NSValue

int main()
{
    // 结构体 --> OC对象
    CGPoint p = CGPointMake(10, 10);
    NSValue *value = [NSValue valueWithPoint:p];
    NSArray *array = @[value ];
	
    // NSValue --> 结构体
    CGPoint p2 = [value pointValue];
    
    return 0;
}

