//
//  ViewController.m
//  NSThread
//
//  Created by 郭伟林 on 15/9/23.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [self createThread1];
//    [self createThread2];
//    [self createThread3];
    
    NSThread *aThread = [[NSThread alloc] initWithTarget:self selector:@selector(subThreadDownload) object:nil];
    [aThread start];
    
    NSLog(@"mainThread: %@ continue", [NSThread currentThread]);
}

- (void)subThreadDownload {
    
    NSLog(@"subThread: %@ begin", [NSThread currentThread]);
    
    [NSThread sleepForTimeInterval:2];
    //[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    for (int i = 0; i < 30; i++) {
        NSLog(@"%d", i);
        if (i == 15) {
            //[NSThread exit];
        }
    }
    
    NSLog(@"subThread: %@ end", [NSThread currentThread]);
}

- (void)createThread1 {
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self
                                               selector:@selector(download:)
                                                 object:@"http://xx.png"];
    thread.name = @"下载图片线程";
    [thread start];
}

- (void)createThread2 {
    
    [NSThread detachNewThreadSelector:@selector(download:)
                             toTarget:self
                           withObject:@"http://xx.jpg"];
}

- (void)createThread3 {
    
    // 会创建新线程
    [self performSelectorInBackground:@selector(download:) withObject:@"http://xx.gif"];
    
    // 不会创建新线程
    [self performSelector:@selector(download:) withObject:@"http://xx.gif"];
}

- (void)download:(NSString *)URLString {
    
    NSLog(@"currentThread: %@\n正在下载: %@", [NSThread currentThread], URLString);
}

@end
