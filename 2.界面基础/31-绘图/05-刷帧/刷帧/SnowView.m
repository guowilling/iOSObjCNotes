//
//  SnowView.m
//  刷帧
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SnowView.h"

@interface SnowView ()

@property (nonatomic, assign) NSInteger imageY;

@end

@implementation SnowView

- (void)awakeFromNib {
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateImage)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)updateImage {
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    self.imageY += 5;
    if (self.imageY > rect.size.height) {
        self.imageY = 0;
    }
    UIImage *image = [UIImage imageNamed:@"snow"];
    [image drawAtPoint:CGPointMake(180, self.imageY)];
}

@end
