//
//  ViewController.m
//  NSOperationQueue
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"thread: %@, 下载图片", [NSThread currentThread]);
        NSURL *imageURL = [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140919221759.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"thread: %@, 刷新界面", [NSThread currentThread]);
            self.imageView.image = image;
        }];
    }];
    NSLog(@"go~go~go");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [self basicUse];
//    [self maxConcurrentOperationCount];
//    [self dependence];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // 取消队列中的所有操作
//    [queue cancelAllOperations];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 暂停队列中的所有操作
//    [queue setSuspended:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 恢复队列中的所有操作
//    [queue setSuspended:NO];
}

- (void)dependence {
    
    // 假设有A、B、C三个操作, 要求: 3个操作都异步执行, 操作 C 依赖于操作 B, 操作 B 依赖于操作 A
    
    // 创建队列(非主队列)
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A--%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B--%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C--%@", [NSThread currentThread]);
    }];

    // 设置依赖关系
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    
    // 添加操作到队列中
    [queue addOperation:operationC];
    [queue addOperation:operationB];
    [queue addOperation:operationA];
}

- (void)maxConcurrentOperationCount {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片1--%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片2--%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片3--%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片4--%@", [NSThread currentThread]);
    }];
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    [queue addOperation:operation5];
    
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片6--%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片7--%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片8--%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片9--%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片10--%@", [NSThread currentThread]);
    }];
}

- (void)download {
    
    NSLog(@"下载图片5--%@", [NSThread currentThread]);
}

- (void)basicUse {
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@, 下载图片1", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thread: %@, 下载图片2", [NSThread currentThread]);
    }];
    
    // 添加操作到队列中(自动异步并发执行)
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
    // 直接添加 Block, 自动包装成操作
    [queue addOperationWithBlock:^{
        NSLog(@"thread: %@, 下载图片3", [NSThread currentThread]);
    }];
}

@end
