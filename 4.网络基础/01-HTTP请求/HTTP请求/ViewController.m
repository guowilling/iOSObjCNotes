//
//  ViewController.m
//  HTTP请求
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)login {
    
    NSString *username = self.username.text;
    if (username.length == 0) {
        NSLog(@"请输入用户名");
        return;
    }
    
    NSString *password = self.password.text;
    if (password.length == 0) {
        NSLog(@"请输入密码");
        return;
    }
    
    NSString *URLString = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login?username=%@&pwd=%@", username, password];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    {
        // 异步请求
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError || !data) {
                                       NSLog(@"请求失败");
                                       return;
                                   }
                                   NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                   NSString *success = respData[@"success"];
                                   NSString *error = respData[@"error"];
                                   if (success) {
                                       NSLog(@"%@", success);
                                   } else {
                                       NSLog(@"%@", error);
                                   }
                               }];
    }

    {
        // 同步请求
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSLog(@"data: %@", data);
    }
}

@end
