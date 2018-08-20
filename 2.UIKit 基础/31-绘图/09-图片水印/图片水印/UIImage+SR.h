//
//  UIImage+SR.h
//  剪切
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SR)

/**
 *  水印图片
 *
 *  @param bgName  背景图片
 *  @param logName 水印图片
 *
 *  @return 合成图片
 */
+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName logImageName:(NSString *)logName;

/**
 *  水印文字
 *
 *  @param bgName  背景图片
 *  @param str     水印文字
 *
 *  @return 合成文字
 */
+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName string:(NSString *)str;

@end
