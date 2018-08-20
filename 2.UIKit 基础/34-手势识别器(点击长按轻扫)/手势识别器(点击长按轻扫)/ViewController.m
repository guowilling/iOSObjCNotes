//
//  ViewController.m
//  手势识别器(点击长按轻扫)
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageView.userInteractionEnabled = YES;
    
    // 轻扫事件
    // 向上
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] init];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [swipe addTarget:self action:@selector(swipeView1)];
    [self.imageView addGestureRecognizer:swipe];
    // 向下
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] init];
    swipe2.direction = UISwipeGestureRecognizerDirectionDown;
    [swipe2 addTarget:self action:@selector(swipeView2)];
    [self.imageView addGestureRecognizer:swipe2];
    // 向左
    UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc] init];
    swipe3.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipe3];
    [swipe3 addTarget:self action:@selector(swipeView3)];
    // 向右
    UISwipeGestureRecognizer *swipe4 = [[UISwipeGestureRecognizer alloc] init];
    swipe4.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipe4];
    [swipe4 addTarget:self action:@selector(swipeView4)];
    
    // 长按事件
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
//    longPress.minimumPressDuration = 2;
//    longPress.allowableMovement = 50;
//    [longPress addTarget:self action:@selector(longPress)];
//    [self.imageView addGestureRecognizer:longPress];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPress];
    
    // 点击事件
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//    tap.numberOfTapsRequired = 2;
//    tap.numberOfTouchesRequired = 2;
//    [tap addTarget:self action:@selector(tap:)];
//    [self.imageView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
}

- (void)swipeView4 {
    
    NSLog(@"轻扫事件右");
}

- (void)swipeView3 {
    
    NSLog(@"轻扫事件左");
}

- (void)swipeView2 {
    
    NSLog(@"轻扫事件下");
}

- (void)swipeView1 {
    
    NSLog(@"轻扫事件上");
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"长按事件开始");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"长按事件位置改变");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"长按事件结束");
            break;
        default:
            break;
    }
}

- (void)tap:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    NSLog(@"点击事件");
}

@end
