//
//  ViewController.m
//  ASI
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    request.delegate = self;
    [request setDidStartSelector:@selector(start:)];
    [request setDidFinishSelector:@selector(finish:)];
    [request startAsynchronous];
}

- (void)start:(ASIHTTPRequest *)request {
    
    NSLog(@"start request: %@", request);
}

- (void)finish:(ASIHTTPRequest *)request {
    
    NSLog(@"finish");
    NSLog(@"responseStatusCode: %zd", [request responseStatusCode]);
    NSLog(@"nresponseStatusMessage : %@", [request responseStatusMessage]);
    NSLog(@"nresponseData: %@", [request responseData]);
}

- (void)asyncBlock {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request setStartedBlock:^{
        NSLog(@"setStartedBlock");
    }];
    [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
        NSLog(@"setHeadersReceivedBlock responseHeaders: %@", responseHeaders);
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock data: %@", data);
    }];
    [request setCompletionBlock:^{
        NSLog(@"setCompletionBlock");
    }];
    [request setFailedBlock:^{
        NSLog(@"setFailedBlock");
    }];
    [request startAsynchronous];
    // Note: 如果同时设置了 block 和实现了代理方法, block 和代理方法都会调用, 先代理方法后执行 block.
}

/**
 ASI 监听请求过程方式:
 1.成为代理, 遵守 ASIHTTPRequestDelegate 协议, 实现协议中的代理方法.
    request.delegate = self;
    - (void)requestStarted:(ASIHTTPRequest *)request;
    - (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
    - (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;
    - (void)requestFinished:(ASIHTTPRequest *)request;
    - (void)requestFailed:(ASIHTTPRequest *)request;

 2.成为代理, 不遵守 ASIHTTPRequestDelegate 协议, 自定义代理方法.
    request.delegate = self;
    [request setDidStartSelector:@selector(start:)];
    [request setDidFinishSelector:@selector(finish:)];

 3.设置 block.
    [request setStartedBlock:^{
        NSLog(@"setStartedBlock");
    }];
    [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
        NSLog(@"setHeadersReceivedBlock--%@", responseHeaders);
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock--%@", data);
    }];
    [request setCompletionBlock:^{
        NSLog(@"setCompletionBlock");
    }];
    [request setFailedBlock:^{
        NSLog(@"setFailedBlock");
    }];
 */

@end
