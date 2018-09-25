//
//  NSString+Extension.m
//  YX
//
//  Created by 郭伟林 on 15/11/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
*  字符串的占位size
*
*  @param font 字符串Font
*
*  @return 字符串的占位size
*/
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  字符串的占位size
 *
 *  @param font 字符串Font
 *  @param maxW 字符串最大占位宽度
 *
 *  @return 字符串的占位size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxW;

@end
