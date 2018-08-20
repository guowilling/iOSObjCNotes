//
//  ViewController.m
//  GCD线程间通信
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // 子线程执行耗时操作
        NSLog(@"currentThread: %@", [NSThread currentThread]);
        NSURL *URL = [NSURL URLWithString:@"http://p1.bqimg.com/4851/112faa5cf03658c9.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{ // 主线程更新 UI
            NSLog(@"currentThread: %@", [NSThread currentThread]);
            self.imageView.image = image;
        });
    });
}

@end
