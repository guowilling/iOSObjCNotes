//
//  NSString+Number.m
//  05-分类的应用
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)

+ (int)numberCountOfString:(NSString *)str
{
    
    return [str numberCount];
}

- (int)numberCount
{
    int count = 0;
    
    for (int i = 0; i<self.length; i++)
    {
        unichar c = [self characterAtIndex:i];
        
        if ( c>='0' && c<='9' )
        {
            count++;
        }
    }
    
    return count;
}

@end
