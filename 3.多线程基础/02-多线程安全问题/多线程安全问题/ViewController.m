//
//  ViewController.m
//  多线程安全问题
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;

@property (nonatomic, assign) NSInteger leftTickets;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.leftTickets = 100;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread1.name = @"1号窗口";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2.name = @"2号窗口";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread3.name = @"3号窗口";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}

- (void)saleTicket {
    
    while (1) {
        @synchronized(self) { // 加锁
            NSInteger count = self.leftTickets;
            if (count > 0) {
                [NSThread sleepForTimeInterval:0.05];
                self.leftTickets = count - 1;
                NSLog(@"%@ 卖了一张票, 剩余 %zd 张票", [NSThread currentThread].name, self.leftTickets);
            } else {
                break;
            }
        } // 解锁
    }
}
@end
