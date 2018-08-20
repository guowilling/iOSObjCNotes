//
//  UIImage+SR.m
//  剪切
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "UIImage+SR.h"

@implementation UIImage (SR)

+ (instancetype)imageWithName:(NSString *)name border:(NSInteger)border color:(UIColor *)color
{
    UIImage *oldImage = [UIImage imageNamed:name];
    CGFloat margin = border;
    CGSize size = CGSizeMake(oldImage.size.width + margin, oldImage.size.height + margin);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctr, CGRectMake(0, 0, size.width, size.height));
    [color set];
    CGContextFillPath(ctr);
    CGFloat smallX = margin * 0.5;
    CGFloat smallY = margin * 0.5;
    CGFloat smallW = oldImage.size.width;
    CGFloat smallH = oldImage.size.height;
    CGContextAddEllipseInRect(ctr, CGRectMake(smallX, smallY, smallW, smallH));
    [[UIColor greenColor] set];
    CGContextClip(ctr);
    [oldImage drawInRect:CGRectMake(smallX, smallY, smallW, smallH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}


+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName log:(NSString *)logName
{
    UIImage *image = [UIImage imageNamed:bgName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    UIImage *logImage = [UIImage imageNamed:logName];
    CGFloat margin = 0;
    CGFloat logY = margin;
    CGFloat logX = image.size.width - logImage.size.width - margin;
    [logImage drawAtPoint:CGPointMake(logX, logY)];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

+ (instancetype)imageWithBackgroundString:(NSString *)bgName string:(NSString *)str
{
    UIImage *image = [UIImage imageNamed:bgName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    [str drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

+ (UIImage *)captureImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

@end
