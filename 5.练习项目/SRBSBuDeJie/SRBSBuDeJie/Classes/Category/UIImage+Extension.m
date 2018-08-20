//
//  UIImage+Extension.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)circleImageWithImage:(UIImage *)originalImage borderWidth:(NSInteger)borderWidth borderColor:(UIColor *)borderColor {
    
    CGSize size = CGSizeMake(originalImage.size.width + borderWidth, originalImage.size.height + borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(contextRef, CGRectMake(0, 0, size.width, size.height));
    [borderColor set];
    CGContextFillPath(contextRef);
    
    CGFloat smallX = borderWidth * 0.5;
    CGFloat smallY = borderWidth * 0.5;
    CGFloat smallW = originalImage.size.width;
    CGFloat smallH = originalImage.size.height;
    CGContextAddEllipseInRect(contextRef, CGRectMake(smallX, smallY, smallW, smallH));
    [[UIColor greenColor] set];
    CGContextClip(contextRef);
    [originalImage drawInRect:CGRectMake(smallX, smallY, smallW, smallH)];
    
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}

@end
