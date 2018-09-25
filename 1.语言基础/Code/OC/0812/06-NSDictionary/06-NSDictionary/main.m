//
//  main.m
//  06-NSDictionary
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//


/**
 集合总结(不能存放基本数据类型, 不能存放nil)
 
 1.NSArray\NSMutableArray
 * 有序
 * 快速创建（不可变）: @[obj1, obj2, obj3]
 * 快速访问元素: 数组名[i]
 
 2.NSSet\NSMutableSet
 * 无序
 
 3.NSDictionary\NSMutableDictionary
 * 无序
 * 快速创建（不可变）: @{key1 : value1,  key2 : value2}
 * 快速访问元素: 字典名[key]
 */

#import <Foundation/Foundation.h>

int main()
{
    NSArray *persons = @[
    @{@"name" : @"jack", @"qq" : @"432423423", @"books": @[@"5分钟突破iOS编程", @"5分钟突破android编程"]},
    @{@"name" : @"rose", @"qq" : @"767567"},
    @{@"name" : @"jim", @"qq" : @"423423"},
    @{@"name" : @"jake", @"qq" : @"123123213"}
    ];
    
    // NSDictionary *jim = persons[2];
    NSString *bookName = persons[0][@"books"][1];
    NSLog(@"%@", bookName);
	
    NSArray *array = persons[0][@"books"];
    NSLog(@"%@", array);
    
    return 0;
}

void use4()
{
    // 字典不允许有相同的key, 允许有相同的value（Object）
    // 字典是无顺序的
    NSDictionary *dict = @{
                           @"address" : @"北京",
                           @"name1" : @"jack",
                           @"name2" : @"jack",
                           @"name3" : @"jack",
                           @"qq" : @"7657567765"};
    
//    NSArray *keys = [dict allKeys];
//    for (int i = 0; i<dict.count; i++)
//    {
//        NSString *key = keys[i];
//        NSString *object = dict[key];
//
//
//        NSLog(@"%@ : %@", key, object);
//    }
    [dict enumerateKeysAndObjectsUsingBlock:
     ^(id key, id obj, BOOL *stop) {
         NSLog(@"%@ : %@", key, obj);
//          *stop = YES;
     }];
}

void NSMutableDictionaryUse()
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 添加
    [dict setObject:@"jack" forKey:@"name"];
    [dict setObject:@"北京" forKey:@"address"];
    // 覆盖
    [dict setObject:@"rose" forKey:@"name"];
    // 移除
    [dict removeObjectForKey:@"name"];
    // 取出
    NSString *str = dict[@"name"];
    NSLog(@"%@", str);
    
	// NSDictionary{address = "北京";name = rose;}
    NSLog(@"%@", @{@"name" : @"jack", @"address" : @"北京"});
    
    // NSArray(jack,rose)
    NSLog(@"%@", @[@"jack", @"rose"]);
}

void NSDictionaryUse()
{
     // 字典: key --> value
     NSDictionary *dict1 = [NSDictionary dictionaryWithObject:@"jack" forKey:@"name"];
    
     NSArray *keys = @[@"name", @"address"];
     NSArray *objects = @[@"jack", @"北京"];
     NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
     NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"jack", @"name",
                            @"北京", @"address",
                            @"32423434", @"qq", nil];
    
    NSDictionary *dict4 = @{@"name" : @"jack", @"address" : @"北京"};
    
    id obj1 = [dict4 objectForKey:@"name"];
    id obj2 = dict4[@"name"];
    
    NSLog(@"%@", obj2);
    
    NSLog(@"%ld", dict4.count);
}