//
//  ViewController.m
//  TomCat
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

/**
 * imageNamed: 与 imageWithContentsOfFile: 的区别: 前者内存由系统负责回收, 后者不使用时即回收.
 * 注意: Images.xcassets中的图片, 不能使用imageWithContentsOfFile加载
 */

/**
 * 重构
 * 1.重复代码抽取成方法
 * 2.根据需要传入参数
 */
- (void)animationWithName:(NSString *)title count:(NSInteger)count {
    if ([self.imageView isAnimating]) return;

    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // 图片名称
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d.jpg", title, i];
        // 根据图片名称得到图片存储的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        // 根据全路径创建图片
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [arrayM addObject:image];
    }
    // 动画图片数组
    self.imageView.animationImages = arrayM;
    self.imageView.animationRepeatCount = 1;
    self.imageView.animationDuration = arrayM.count * 0.088;
    [self.imageView startAnimating];
    // 动画结束之后清空self.imageView.animationImages
    [self.imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imageView.animationDuration];
}

- (IBAction)doAnimation:(UIButton *)sender {
    [self animationWithName:sender.currentTitle count:sender.tag];
}

@end
