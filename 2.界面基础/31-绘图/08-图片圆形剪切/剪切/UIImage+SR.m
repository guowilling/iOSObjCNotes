//
//  UIImage+SR.m
//  剪切
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "UIImage+SR.h"

@implementation UIImage (SR)

+ (instancetype)imageWithName:(NSString *)name border:(NSInteger)border color:(UIColor *)color {
    
    UIImage *oldImage = [UIImage imageNamed:name];
    CGFloat margin = border;
    CGSize size = CGSizeMake(oldImage.size.width + margin, oldImage.size.height + margin);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    // 绘制大圆
    CGContextAddEllipseInRect(ctr, CGRectMake(0, 0, size.width, size.height));
    [color set];
    CGContextFillPath(ctr);
    
    CGFloat smallX = margin * 0.5;
    CGFloat smallY = margin * 0.5;
    CGFloat smallW = oldImage.size.width;
    CGFloat smallH = oldImage.size.height;
    CGContextAddEllipseInRect(ctr, CGRectMake(smallX, smallY, smallW, smallH));
    
    // 小圆范围
    CGContextClip(ctr);
    
    // 绘制图片(超出小圆部分会被剪切)
    [oldImage drawInRect:CGRectMake(smallX, smallY, smallW, smallH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

@end
