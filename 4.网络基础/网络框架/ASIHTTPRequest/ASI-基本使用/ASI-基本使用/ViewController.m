//
//  ViewController.m
//  ASI-基本使用
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"

@interface ViewController () <ASIHTTPRequestDelegate>

@property (nonatomic, strong) ASIHTTPRequest *request;

@end

@implementation ViewController

- (void)dealloc {
    
    if (_request) {
        [_request clearDelegatesAndCancel];
        _request = nil;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self asynGet];
    //[self synGet];
}

#pragma mark - 异步请求

- (void)asynGet {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    request.timeOutSeconds = 15;
    request.delegate = self;
    [request startAsynchronous];
    _request = request;
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
    
    NSLog(@"requestStarted request: %@", request);
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
    NSLog(@"didReceiveResponseHeaders responseHeaders: %@", responseHeaders);
}

// Note: 如果实现了此代理方法, responseData 和 responseString 为 nil.
//- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
//
//    NSLog(@"didReceiveData data: %@", data);
//}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSLog(@"requestFinished responseData: %@", [request responseData]);
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    NSLog(@"requestFailed request: %@", request);
}

#pragma mark - 同步请求

- (void)synGet {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    request.timeOutSeconds = 15;
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        NSLog(@"error: %@", error);
    } else {
        NSData *data = [request responseData];
        NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"respData: %@", respData);
    }
}

@end
