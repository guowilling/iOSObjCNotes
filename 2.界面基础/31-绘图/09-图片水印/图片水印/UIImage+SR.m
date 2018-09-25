//
//  UIImage+SR.m
//  剪切
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "UIImage+SR.h"

@implementation UIImage (SR)

+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName logImageName:(NSString *)logName {
    
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

+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName string:(NSString *)str {
    
    UIImage *image = [UIImage imageNamed:bgName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    [str drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

@end
