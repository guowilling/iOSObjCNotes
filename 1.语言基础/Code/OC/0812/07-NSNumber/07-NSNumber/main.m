//
//  main.m
//  07-NSNumber
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

int main()
{
    // 20包装成一个NSNumber对象
    // @(20) == [NSNumber numberWithInt:20]
    
    NSArray *array = @[
    @{@"name" : @"jack", @"age" : @20},
    @{@"name" : @"rose", @"age" : @25},
    @{@"name" : @"jim", @"age" : @27}
    ];
    
    @10.5;
    @YES;
	
    @'A'; // NSNumber对象
    @"A"; // NSString对象
    
    int age = 100;
    @(age); // == [NSNumber numberWithInt:age];
    
    
    NSNumber *num = [NSNumber numberWithDouble:10.5];
    int d = [num doubleValue];
    
    int a = 20;
    NSString *str = [NSString stringWithFormat:@"%d", a]; // == @"20"
    
    NSLog(@"%d", [str intValue]);
    
    return 0;
}

void test()
{
    NSNumber *num = [NSNumber numberWithInt:10];

    NSDictionary *dict =  @{@"name" : @"jack", @"age" : num};
    
    NSNumber *num3 =[dict objectForKey:@"age"];
    NSNumber *num2 = dict[@"age"];
    
    int a = [num2 intValue];
    
    NSLog(@"%d" , a);
}