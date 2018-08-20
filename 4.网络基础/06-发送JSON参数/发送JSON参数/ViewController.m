//
//  ViewController.m
//  发送JSON参数
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/order"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.HTTPMethod = @"POST";
    NSDictionary *orderInfo = @{@"shop_id": @"55",
                                @"shop_name": @"gwl",
                                @"user_id": @"123"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    requestM.HTTPBody = jsonData; // 设置请求体
    [requestM setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; // 设置请求头
    [NSURLConnection sendAsynchronousRequest:requestM
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!data|| connectionError) {
                                   return;
                               }
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSString *error = respData[@"error"];
                               if (error) {
                                   NSLog(@"error: %@", error);
                                   return;
                               }
                               NSString *success = respData[@"success"];
                               NSLog(@"success: %@", success);
                           }];
}

@end
