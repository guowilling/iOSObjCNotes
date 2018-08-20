//
//  ViewController.m
//  密码加密
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)login {
    
    NSString *username = self.usernameField.text;
    if (username.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    NSString *password = self.passwordField.text;
    if (password.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登录中..."];
    
    NSURL *URL = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/login"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.timeoutInterval = 10;
    requestM.HTTPMethod = @"POST";
    NSString *param = [NSString stringWithFormat:@"username=%@&pwd=%@", username, [NSString MD5Reorder:password]];
    requestM.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setValue:@"iPhone 6" forHTTPHeaderField:@"User-Agent"];
    [NSURLConnection sendAsynchronousRequest:requestM
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               [MBProgressHUD hideHUD];
                               if (connectionError || data == nil) {
                                   [MBProgressHUD showError:@"请求失败"];
                                   return;
                               }
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSString *error = respData[@"error"];
                               if (error) {
                                   [MBProgressHUD showError:error];
                               } else {
                                   NSString *success = respData[@"success"];
                                   [MBProgressHUD showSuccess:success];
                               }
                           }];
}

@end
