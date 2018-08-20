//
//  ViewController.m
//  AFNetWorking-基本使用
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [self getJSON];
//    [self getXML];
//    [self getData];
//    [self requestOperationManager];
//    [self sessionManager];
}

- (void)sessionManager {
    
    // AFHTTPSessionManager 基于 NSURLSession
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    [manager GET:@"http://localhost:8080/MJServer/login"
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"responseObject: %@", responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}

- (void)requestOperationManager {
    
    // AFHTTPRequestOperationManager 基于 NSURLConnection
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    [manager POST:@"http://localhost:8080/MJServer/login"
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"responseObject: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error: %@", error);
          }];
}

- (void)getData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 服务器返回 JSON 数据, AFN 不自动解析
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    [manager GET:@"http://localhost:8080/MJServer/login"
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"responseObject: %@", responseObject);
             NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
             NSLog(@"%@", respData);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}

- (void)getXML {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer]; // 服务器返回 XML 数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    params[@"type"] = @"XML";
    [manager GET:@"http://localhost:8080/MJServer/login"
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"responseObject: %@", responseObject);
             //responseObject.delegate = self;
             //[responseObject parse];
             //...
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}

- (void)getJSON {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; // 服务器返回 JSON 数据, AFN 自动解析
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    [manager GET:@"http://localhost:8080/MJServer/login"
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"responseObject: %@", responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}

@end
