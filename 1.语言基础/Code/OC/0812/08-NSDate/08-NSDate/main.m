//
//  main.m
//  08-NSDate
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

int main()
{	
	// string2date
    NSString *time = @"2011/09/10 18:56";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    
    NSDate *date = [formatter dateFromString:time];
    NSLog(@"%@", date);
    return 0;
}


void date2string()
{
    NSDate *date = [NSDate date];
    // 日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // y年 M月 d日
    // m分 s秒 H(24)时 h(12)时
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *str = [formatter stringFromDate:date];
    NSLog(@"%@", str);
}

void use()
{
    // 创建时间对象
    NSDate *date1 = [NSDate date];
    // 0时区的时间（北京-东8区）
    NSLog(@"%@", date1);
    
	// 晚5秒
    NSDate *date2 = [NSDate dateWithTimeInterval:5 sinceDate:date1];
    
    [date2 timeIntervalSinceNow];
    
    NSTimeInterval seconds = [date2 timeIntervalSince1970];
}