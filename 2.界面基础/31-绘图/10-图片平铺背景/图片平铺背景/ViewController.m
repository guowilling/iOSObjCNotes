//
//  ViewController.m
//  图片平铺背景
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CATransition *transition;

@end

@implementation ViewController

- (CATransition *)transition {
    
    if (!_transition) {
        _transition = [[CATransition alloc] init];
        _transition.type = @"pageCurl";
    }
    return _transition;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.contentView.text = @"第0页";
    
    // 生成小图片
    CGSize size = CGSizeMake(self.view.frame.size.width, 44);
    UIGraphicsBeginImageContextWithOptions(size , NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat height = 44;
    CGContextAddRect(ctx, CGRectMake(0, 0, self.view.frame.size.width, height));
    [[UIColor redColor] set];
    CGContextFillPath(ctx);
    CGFloat lineWidth = 2;
    CGContextMoveToPoint(ctx, 0, height - lineWidth);
    CGContextAddLineToPoint(ctx, 320, height - lineWidth);
    [[UIColor blackColor] set];
    CGContextStrokePath(ctx);
    
    // 使用小图片平铺背景
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIColor *imageColor = [UIColor colorWithPatternImage:image];
    self.contentView.backgroundColor = imageColor;
}

- (IBAction)previousBtnClick:(UIButton *)sender {
    
    self.index--;
    self.contentView.text = [NSString stringWithFormat:@"第%zd页", self.index];
    [self.contentView.layer addAnimation:self.transition forKey:nil];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    
    self.index++;
    self.contentView.text = [NSString stringWithFormat:@"第%zd页", self.index];
    [self.contentView.layer addAnimation:self.transition forKey:nil];
}

@end
