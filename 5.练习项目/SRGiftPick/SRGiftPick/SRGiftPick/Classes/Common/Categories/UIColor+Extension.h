//
//  UIColor+Extension.h
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/2.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  16进制字符串对应的RGB颜色
 *
 *  @param hexString 16进制字符串
 *
 *  @return RGB颜色
 */
+ (instancetype)colorWithHexString:(NSString *)hexString;

@end
