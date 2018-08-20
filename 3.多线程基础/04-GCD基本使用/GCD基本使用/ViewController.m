//
//  ViewController.m
//  GCD基本使用
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

/**
 Foundation      :  OC
 Core Foundation :  C
 桥接: Foundation 和 Core Foundation 的数据类型可以相互转换
 
 NSString *str1 = @"123";                        // Foundation
 CFStringRef str2 = (__bridge CFStringRef)str;   // Core Foundation
 NSString *str3 = (__bridge NSString *)str2;     // Foundation
 
 CFArrayRef         <-->    NSArray
 CFDictionaryRef    <-->    NSDictionary
 CFNumberRef        <-->    NSNumber

 如果函数名中带有 create\copy\new\retain 等创建的 Core Foundation 数据类型, 即使是 ARC 环境也必须手动释放.
 CFArrayRef array = CFArrayCreate(NULL, NULL, 10, 10);
 CFRelease(array);
 
 CGPathRef path = CGPathCreateMutable();
 CGPathRelease(path);
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
// dispatch_async  :  异步函数，具备创建新线程的能力
// dispatch_sync   :  同步函数，不具备创建新线程的能力
// 并发队列 : 多个任务同时执行
// 串行队列 : 多个任务顺序执行
    
//    [self syncSerialQueue];
//    [self syncGlobalQueue];
//    [self syncMainQueue];
    
//    [self asyncMainQueue];
//    [self asyncSerialQueue];
    [self asyncGlobalQueue];
}

/**
 *
 *  dispatch_async + 并发队列(最常用)
 *  执行方式      : 并发执行
 *  是否创建新线程 : 是(多条)
 */
- (void)asyncGlobalQueue {
    
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片5---%@", [NSThread currentThread]);
    });
    
    // MRC 环境需要手动释放队列
    //dispatch_release(queue);
}

/**
 *  dispatch_async + 串行队列
 *  执行方式      : 串行执行
 *  是否创建新线程 : 是(一条)
 */
- (void)asyncSerialQueue {
    
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  dispatch_async + 主队列
 *  执行方式      : 串行执行
 *  是否创建新线程 : 否
 */
- (void)asyncMainQueue {
    
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---下载图片5---%@", [NSThread currentThread]);
    });
}

/**--------------------------------------华丽的分割线--------------------------------------**/

/**
 *  dispatch_sync + 主队列(死锁)
 */
- (void)syncMainQueue {
    
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"syncMainQueue: %@ start", [NSThread currentThread]);
    
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMainQueue: %@ ended", [NSThread currentThread]);
}

/**
 *  dispatch_sync + 并发队列
 *  执行方式      : 串行执行
 *  是否创建新线程 : 否
 */
- (void)syncGlobalQueue {
    
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
}

/**
 *  dispatch_sync + 串行队列
 *  执行方式      : 串行执行
 *  是否创建新线程 : 否
 */
- (void)syncSerialQueue {
    
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---下载图片3---%@", [NSThread currentThread]);
    });
}

@end
