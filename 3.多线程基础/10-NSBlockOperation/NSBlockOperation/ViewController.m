//
//  ViewController.m
//  NSBlockOperation
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self operationTest1];
    //[self operationTest2];
}

- (void)operationTest2 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@下载图片1", [NSThread currentThread]);
    }];
    [operation1 addExecutionBlock:^{
        NSLog(@"thread: %@下载图片2", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@下载图片3", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@下载图片4", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@下载图片5", [NSThread currentThread]);
    }];
    
    // 主队列
    //NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    // 非主队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 添加操作到队列中
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
}

- (void)operationTest1 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@下载图片1", [NSThread currentThread]);
    }];
    [operation1 start];
    
    // 任务数大于1才会创建新线程
    NSBlockOperation *operation2 = [[NSBlockOperation alloc] init];
    [operation2 addExecutionBlock:^{
        NSLog(@"thread: %@下载图片1", [NSThread currentThread]);
    }];
    [operation2 addExecutionBlock:^{
        NSLog(@"thread: %@下载图片2", [NSThread currentThread]);
    }];
    [operation2 addExecutionBlock:^{
        NSLog(@"thread: %@下载图片3", [NSThread currentThread]);
    }];
    [operation2 start];
}

@end
