//
//  ViewController.m
//  延迟执行和执行一次
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"thread: %@下载图片1", [NSThread currentThread]);
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"thread: %@下载图片2", [NSThread currentThread]);
        });
    });
    
    NSLog(@"flag1");
//    [self delay1];
//    [self delay2];
    [self delay3];
    NSLog(@"flag2");
}

- (void)delay3 {
    
    // 1秒后回到主线程执行 block
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), mainQueue, ^{
        NSLog(@"thread: %@", [NSThread currentThread]);
    });
    
    // 2秒后开启新线程执行 block
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), globalQueue, ^{
        NSLog(@"thread: %@", [NSThread currentThread]);
    });
}

- (void)delay2 {
    
    // 不会阻塞当前线程
    [self performSelector:@selector(download:) withObject:@"http://555.jpg" afterDelay:2];
}

- (void)delay1 {
    
    // 会阻塞当前线程(一般不使用)
    [NSThread sleepForTimeInterval:2];
    
    [self download:@"http://555.jpg"];
}

- (void)download:(NSString *)URLString {
    
    NSLog(@"thread: %@, 下载图片: %@", [NSThread currentThread], URLString);
}

@end
