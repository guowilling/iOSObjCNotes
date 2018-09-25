//
//  ViewController.m
//  数据存储-preferences
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData {
    
    NSString *libraryDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", libraryDirectoryPath);
    
    // 偏好设置一般用于保存应用程序的配置信息和用户信息
    // 所有数据保存在同一个文件, 默认存储在 Library/Preferences 文件夹下的对应 plist 文件
    // 优点: 不用关心文件名
    // 使用场景: 通常快速进行键值对存储的时候使用偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"gwl" forKey:@"name"];
    [defaults setObject:@"man" forKey:@"gender"];
    [defaults setInteger:24    forKey:@"age"];
    [defaults setDouble:168.0  forKey:@"height"];
    [defaults synchronize];
}

- (IBAction)readData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name     = [defaults objectForKey:@"name"];
    NSString *gender   = [defaults stringForKey:@"gender"];
    NSInteger age      = [defaults integerForKey:@"age"];
    CGFloat height     = [defaults floatForKey:@"height"];
    NSDictionary *userInfo = @{@"name": name, @"gender": gender, @"age": @(age), @"height": @(height)};
    NSLog(@"userInfo: %@", userInfo);
}

@end
