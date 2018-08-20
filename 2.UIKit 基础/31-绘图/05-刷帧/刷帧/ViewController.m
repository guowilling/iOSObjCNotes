//
//  ViewController.m
//  刷帧
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CircleView *circleView;

@end

@implementation ViewController

- (IBAction)valueChange:(UISlider *)sender {
    
    self.circleView.radius = sender.value;
}

@end
