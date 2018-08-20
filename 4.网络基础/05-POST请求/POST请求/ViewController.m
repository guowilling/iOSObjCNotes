//
//  ViewController.m
//  POST请求
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)login {
    
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
    
    NSLog(@"正在登录中...");
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.timeoutInterval = 15;
    requestM.HTTPMethod = @"POST"; // 设置请求方式
    requestM.HTTPBody = [[NSString stringWithFormat:@"username=%@&pwd=%@", username, password] dataUsingEncoding:NSUTF8StringEncoding]; // 设置请求参数
    [requestM setValue:@"iPhone 6" forHTTPHeaderField:@"User-Agent"]; // 设置请求头
    [NSURLConnection sendAsynchronousRequest:requestM
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSHTTPURLResponse *HTTPURLResponse = (NSHTTPURLResponse *)response;
                               NSString *localizedString = [NSHTTPURLResponse localizedStringForStatusCode:HTTPURLResponse.statusCode];
                               NSLog(@"statusCode: %zd", HTTPURLResponse.statusCode);
                               NSLog(@"localizedStringForStatusCode: %@", localizedString);
                               NSLog(@"allHeaderFields: %@", HTTPURLResponse.allHeaderFields);
                               if (connectionError || !data) {
                                   NSLog(@"网络错误");
                                   return;
                               }
                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSString *success = dict[@"success"];
                               if (success) {
                                   NSLog(@"success: %@", success);
                                   return;
                               }
                               NSString *error = dict[@"error"];
                               NSLog(@"error: %@", error);
                           }];
}

@end
