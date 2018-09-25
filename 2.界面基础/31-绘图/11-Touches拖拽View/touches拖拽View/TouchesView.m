//
//  TouchesView.m
//  touches拖拽View
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TouchesView.h"

@implementation TouchesView

// 触摸事件调用过程: touchesBegan -> touchesMoved -> touchesEnded

// 手指触摸view的时候调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __func__);
    // 一次触摸过程中touch是同一个对象
//     UITouch *touch = [touches anyObject];
//     NSLog(@"touch: %p", touch);
}

// 手指在view上移动的时候调用
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __func__);
    UITouch *touch = [touches anyObject];
    NSLog(@"touch: %p", touch);
    
    // 上一次的位置
    CGPoint prePoint = [touch previousLocationInView:self];
    // 当前的位置
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat moveX = currentPoint.x - prePoint.x;
    CGFloat moveY = currentPoint.y - prePoint.y;
    CGPoint temp =  self.center;
    temp.x += moveX;
    temp.y += moveY;
    self.center = temp;
}

// 手指离开view的时候调用
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __func__);
//    UITouch *touch = [touches anyObject];
//    NSLog(@"touch: %p", touch);
}

@end
