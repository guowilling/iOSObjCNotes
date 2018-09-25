//
//  main.m
//  03-NSArray
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

//NSArray ：不可变数组
//NSMutableArray : 可变数组

int main()
{
    // @[]创建的是不可变数组
    // NSMutableArray *array 1= @[@"jack", @"rose"];
    // [array1 addObject:@"jim"];

    NSArray *array2 = @[@"jack", @"rose"];
    NSLog(@"%@", array2);
    
    return 0;
}

void NSMutableArrayUse()
{
    // NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"rose", @"jim", nil];

    [array addObject:[[Person alloc] init]];
    [array addObject:@"jack"];
	
	// 不能放基本数据类型和nil
    // [array addObject:nil];
    // [array addObject:10]
    [array removeAllObjects];
    [array removeObject:@"jack"];
    [array removeObjectAtIndex:0];
    
    NSLog(@"%@", array);
    
    NSLog(@"%ld", array.count);
}

// 遍历数组
void use2()
{
    Person *p = [[Person alloc] init];
    
    NSArray *array = @[p, @"rose", @"jack"];
    
    //    for (int i = 0; i<array.count; i++)
    //    {
    //        NSLog(@"%@", array[i]);
    //    }
    
    // int i = 0;
    //    for (id obj in array)
    //    {
    //        NSUInteger i = [array indexOfObject:obj];
    //
    //        NSLog(@"%ld - %@", i, obj);
    //    }
    
    // 遍历到一个元素调用一次block, 并把当前元素和索引位置当做参数传给block
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSLog(@"%ld - %@", idx, obj);
         
         if (idx == 1)
         {
             *stop = YES;
         }
         
     }];
}

void NSArrayUse()
{
    /*
     int a = 5;
     int ages[10] = {1, 90, 89, 17};
	 
     Person *p = [[Person alloc] init];
     Person *persons[5] = {p, [[Person alloc] init]};
     */
    
    // OC数组不能存放nil值
    // OC数组只能存放OC对象、不能存放非OC对象类型, 比如int、struct、enum等
    
    // 空数组
    NSArray *array1 = [NSArray array];

    NSArray *array2 = [NSArray arrayWithObject:@"jack"];
    
    // nil数组结束标记
    NSArray *array3 = [NSArray arrayWithObjects:@"jack", @"rose", nil];
    
    // @[]快速创建一个数组
    NSArray *array4 = @[@"jack", @"rose", @"gwl"];
    
    NSLog(@"%@", [array3 objectAtIndex:1]);
    NSLog(@"%@", array3[0]);
}