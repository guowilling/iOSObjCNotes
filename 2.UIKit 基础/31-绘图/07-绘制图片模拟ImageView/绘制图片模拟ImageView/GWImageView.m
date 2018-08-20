//
//  GWImageView.m
//  绘制图片模拟ImageView
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "GWImageView.h"

@implementation GWImageView

- (void)drawRect:(CGRect)rect {
    
    [self.image drawInRect:rect];
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    [self setNeedsDisplay];
}

@end
