//
//  ViewController.m
//  按钮操作形变(storyboard)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, kMovingDir) {
    kMovingDirTop = 1,
    kMovingDirLeft,
    kMovingDirBottom,
    kMovingDirRight,
};

#define kMovingDelta 20.0f

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@end

@implementation ViewController

- (IBAction)move:(UIButton *)sender {
    
    // CGAffineTransformMakeTranslation是相对初始位置
    // CGAffineTransformTranslate是相对上次位置
    /**
     * frame属性通常用于实例化控件时指定初始位置之后一般不要再去修改frame
     * 如果需要改变控件位置可以使用center属性
     * 如果需要改变控件大小可以使用bounds属性
     */
    CGFloat dx;
    CGFloat dy;
    switch (sender.tag) {
        case kMovingDirTop:
            dy = -kMovingDelta;
            break;
        case kMovingDirLeft:
            dx = -kMovingDelta;
            break;
        case kMovingDirBottom:
            dy = kMovingDelta;
            break;
        case kMovingDirRight:
            dx = kMovingDelta;
            break;
        default:
            break;
    }
    self.iconButton.transform = CGAffineTransformTranslate(self.iconButton.transform, dx, dy);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

- (IBAction)zoom:(UIButton *)sender {
    CGFloat dx;
    CGFloat dy;
    dx = sender.tag ? 1.1 : 0.9;
    dy = sender.tag ? 1.1 : 0.9;
    self.iconButton.transform = CGAffineTransformScale(self.iconButton.transform, dx, dy);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

- (IBAction)rotate:(UIButton *)sender {
    CGFloat angle;
    angle = sender.tag ? -M_2_PI / 2 : M_2_PI / 2;
    self.iconButton.transform = CGAffineTransformRotate(self.iconButton.transform, angle);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

@end
