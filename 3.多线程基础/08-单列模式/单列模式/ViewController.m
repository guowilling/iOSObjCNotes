//
//  ViewController.m
//  单列模式
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "SingleTon1.h"
#import "SingleTon2.h"
#import "SingleTon3.h"

/**
 * static 修饰全局变量, 全局变量的作用域限于当前文件.
 *
 * static 修饰局部变量, 改变局部变量的生命周期但不改变作用域, 保证局部变量只初始化1次.
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    SingleTon1 *one1   = [[SingleTon1 alloc] init];
    SingleTon1 *two1   = [[SingleTon1 alloc] init];
    SingleTon1 *three1 = [SingleTon1 sharedSingleTon1];
    NSLog(@"\n%@\n%@\n%@", one1, two1, three1);
    
    SingleTon2 *one2   = [[SingleTon2 alloc] init];
    SingleTon2 *two2   = [[SingleTon2 alloc] init];
    SingleTon2 *three2 = [SingleTon2 sharedSingleTon2];
    NSLog(@"\n%@\n%@\n%@", one2, two2, three2);
    
    SingleTon3 *one3   = [[SingleTon3 alloc] init];
    SingleTon3 *two3   = [[SingleTon3 alloc] init];
    SingleTon3 *three3 = [SingleTon3 sharedSingleTon3];
    NSLog(@"\n%@\n%@\n%@", one3, two3, three3);
}

@end
