//
//  main.m
//  01-结构体
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

int main()
{
    BOOL b1 = CGPointEqualToPoint(CGPointMake(10, 10), CGPointMake(10, 10));
    // CGRectEqualToRect(<#CGRect rect1#>, <#CGRect rect2#>)
    // CGSizeEqualToSize(<#CGSize size1#>, <#CGSize size2#>)
    
    BOOL b2 = CGRectContainsPoint(CGRectMake(50, 40, 100, 50), CGPointMake(60, 45));
    
    NSLog(@"%d", b2);
    
    return 0;
}


// NSRange(location, length)
// NSPoint\CGPoint
// NSSize\CGSize
// NSRect\CGRect(CGPint, CGSize)
void point()
{
    CGPoint p1 = NSMakePoint(10, 10);
    NSPoint p2 = CGPointMake(20, 20); // 掌握
    
    NSSize s1 = CGSizeMake(100, 50);
    CGSize s2 = NSMakeSize(100, 50);
    
    CGRect r1 = CGRectMake(0, 0, 100, 50);
    CGRect r2 = { {0, 0}, {100, 90}};
    CGRect r3 = {p1, s2};
    CGRect r4 = {CGPointZero, CGSizeMake(100, 90)};
    
    
    // CGSizeZero
    // CGRectZero
    // CGPointZero == CGPointMake(0, 0)
    
    
    // NSString *str = NSStringFromPoint(p1);
    // NSString *str = NSStringFromSize(s3);
    NSString *str = NSStringFromRect(r1);
    NSLog(@"%@", str);
    
    NSLog(@"x=%f, y=%f, width=%f, height=%f", r1.origin.x, r1.origin.y, r1.size.width, r1.size.height);
}

void range()
{
    // NSRange r1 = {2, 4};
    // NSRange r2 = {.location = 2, .length = 4};
    // NSRange r3 = NSMakeRange(2, 4); // 掌握
    
    NSString *str = @"i love oc";
    NSRange range = [str rangeOfString:@"love"];
    NSLog(@"loc = %ld, length=%ld", range.location, range.length);
}