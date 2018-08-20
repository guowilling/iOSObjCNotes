//
//  ViewController.m
//  大文件下载-内存不合理
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) NSMutableData *fileData;

@property (nonatomic, assign) long long totalLength;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self download];
}

- (void)download {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // 自动发送异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
    //[[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    // 手动发送异步请求
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    //[connection start];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"didReceiveResponse");
    
    self.fileData = [NSMutableData data];
    
    // 目标文件的总大小
    self.totalLength = response.expectedContentLength;
    
    //NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    //long long fileLength = [resp.allHeaderFields[@"Content-Length"] longLongValue];
    //self.totalLength = fileLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSLog(@"didReceiveData");
    
    [self.fileData appendData:data];
    
    self.progressView.progress = (double)self.fileData.length / self.totalLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectionDidFinishLoading");
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachesDirectory stringByAppendingPathComponent:@"videos.zip"];
    [self.fileData writeToFile:filePath atomically:YES];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
}

@end
