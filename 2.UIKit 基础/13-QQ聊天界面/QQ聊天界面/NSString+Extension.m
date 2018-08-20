//
//  NSString+Extension.m
//  YX
//
//  Created by 郭伟林 on 15/11/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font {
   return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxW {
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
