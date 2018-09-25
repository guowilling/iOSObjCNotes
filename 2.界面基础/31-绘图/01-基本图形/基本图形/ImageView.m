//
//  ImageView.m
//  基本图形
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawText];
    
    [self drawImage];
}

- (void)drawText {
    
    NSString *str = @"天气好热";
    // 画矩形
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextAddRect(contextRef, CGRectMake(50, 50, 100, 100));
    CGContextStrokePath(contextRef);
    // 画文字
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    dicM[NSForegroundColorAttributeName] =[UIColor redColor];
    dicM[NSBackgroundColorAttributeName] = [UIColor blueColor];
    dicM[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    // 绘制到指定位置
    //[str drawAtPoint:CGPointMake(10, 10) withAttributes:dicM];
    // 绘制到指定范围自动换行, 不显示超出范围部分.
    [str drawInRect:CGRectMake(50, 50, 100, 100) withAttributes:dicM];
}

- (void)drawImage {
    
    UIImage *image = [UIImage imageNamed:@"mayday happy each day"];
    // 绘制到指定位置
    [image drawAtPoint:CGPointMake(200, 200)];
    // 拉伸方式绘制图片到layer
    //[image drawInRect:CGRectMake(0, 0, 300, 300)];
    // 平铺方式绘制图片到layer
    //[image drawAsPatternInRect:CGRectMake(0, 0, 300, 300)];
}

@end
