//
//  main.m
//  05-分类的应用
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Number.h"

int main()
{
    int count1 = [NSString numberCountOfString:@"55gwl6655"];
    
    int count2 = [@"55gwl55" numberCount];
    
    NSLog(@"%d\n%d", count1, count2);
    return 0;
}

