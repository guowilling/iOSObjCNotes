//
//  ViewController.m
//  ASI
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:URL]; // ASIFormDataRequest 默认发送 POST 请求
    [request setPostValue:@"123" forKey:@"username"]; // 设置请求参数自动添加到请求体
    [request setPostValue:@"123" forKey:@"pwd"];
    __weak typeof(request) safeRequest = request; // 设置监听方法
    [request setCompletionBlock:^{
        NSLog(@"%@", [safeRequest responseString]);
    }];
    [request startAsynchronous];
}

@end
