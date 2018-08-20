//
//  NSDate+extension.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [formatter stringFromDate:self];
    NSString *nowStr = [formatter stringFromDate:now];
    return [selfStr isEqualToString:nowStr];
}

- (BOOL)isYesterday {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    NSString *selfStr = [formatter stringFromDate:self];
    // 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSString *nowStr = [formatter stringFromDate:now];
    
    NSDate *selfDate = [formatter dateFromString:selfStr];
    NSDate *nowDate = [formatter dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return (components.year == 0) && (components.month == 0) && (components.day == 1);
}

- (BOOL)isThisYear {
    //NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self];
    //NSDateComponents *nowComps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    //return comps.year == nowComps.year;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:unit fromDate:self toDate:now options:0];
    return components.year == 0;
}

@end
