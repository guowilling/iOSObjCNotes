//
//  main.m
//  02-NSString
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSString : 不可变字符串
// NSMutableString : 可变字符串

int main()
{
    
    NSMutableString *s1 = [NSMutableString stringWithFormat:@"my age is 10"];
    [s1 appendString:@" 11"];
    
    NSRange range = [s1 rangeOfString:@"is"];
	[s1 deleteCharactersInRange:range];
    
    [s1 deleteCharactersInRange:NSMakeRange(0,2)];
    
    NSString *s2 = [NSString stringWithFormat:@"age is 10"];
    NSString *s3 = [s2 stringByAppendingString:@" 11"];
    
    NSLog(@"s1=%@, s2=%@, s3=%@", s1, s2, s3);
    
    return 0;
}

void stringExport()
{
    [@"Jack\nJack" writeToFile:@"/Users/apple/Desktop/my.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];

    NSString *str = @"guoweilin";
    NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/my2.txt"];
    [str writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

void stringCreate()
{
    NSString *s1 = @"jack";
    NSString *s2 = [[NSString alloc] initWithString:@"jack"];
    NSString *s3 = [[NSString alloc] initWithFormat:@"age is %d", 10];
    
    // C字符串转为OC字符串
    NSString *s4 = [[NSString alloc] initWithUTF8String:"jack"];
    // OC字符串转为C字符串
    const char *cs = [s4 UTF8String];
    
    NSString *s5 = [[NSString alloc] initWithContentsOfFile:@"/Users/apple/Desktop/xx.txt" encoding:NSUTF8StringEncoding error:nil];
    
    // 协议头://路径
    // file://（本地文件）
    // ftp:// （网络资源）
    // http://（网络资源）
    
//    NSURL *url = [[NSURL alloc] initWithString:@"file:///Users/apple/Desktop/xx.txt"];
    NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/xx.txt"];
    NSString *s6 = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", s6);
    
    /**
     一般都会有一个类方法跟对象方法配对
     [NSURL URLWithString:<#(NSString *)#>];
     [NSString stringWithFormat:@""];
     [NSString stringWithContentsOfFile:<#(NSString *)#> encoding:<#(NSStringEncoding)#> error:<#(NSError *__autoreleasing *)#>];
     
     */

}