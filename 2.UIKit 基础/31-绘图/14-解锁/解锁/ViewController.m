//
//  ViewController.m
//  解锁
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"

@interface ViewController () <LockViewDelegate>

@property (weak, nonatomic) IBOutlet LockView *lockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.lockView.delegate = self;
}

- (void)lockViewDidClick:(LockView *)lockView pwd:(NSString *)pwd {
    
    NSLog(@"%@", pwd);
}

@end
