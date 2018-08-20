//
//  ViewController.m
//  touches拖拽View
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "TouchesView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TouchesView *touchesView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    self.touchesView.center = point;
}

@end
