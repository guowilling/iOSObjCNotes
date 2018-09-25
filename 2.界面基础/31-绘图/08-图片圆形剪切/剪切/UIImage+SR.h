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
 *  剪切图片成带有边框的圆形图片
 *
 *  @param name   图片名称
 *  @param border 边框宽度
 *  @param color  边框颜色
 *
 *  @return 圆形图片
 */
+ (instancetype)imageWithName:(NSString *)name border:(NSInteger)border color:(UIColor *)color;

@end
