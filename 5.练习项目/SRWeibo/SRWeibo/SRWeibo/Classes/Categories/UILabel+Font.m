//
//  UILabel+Font.m
//  SRWeibo
//
//  Created by 郭伟林 on 16/11/15.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import "UILabel+Font.h"
#import <objc/runtime.h>

@implementation UILabel (Font)

+ (void)load  {
    Method oldImp = class_getInstanceMethod([self class], @selector(setFont:));
    Method newImp = class_getInstanceMethod([self class], @selector(hook_setFont:));
    method_exchangeImplementations(oldImp, newImp);
}

- (void)hook_setFont:(UIFont *)font {
    CGFloat fontSize = font.pointSize;
    fontSize = fontSize / 375.0 * [UIScreen mainScreen].bounds.size.width;
    [self hook_setFont:[UIFont fontWithName:@"PingFangSC-Light" size:fontSize]]; // font.fontName
}

@end
