//
//  ViewController.m
//  NSURLSession-基本使用
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDownloadDelegate>

@end

@implementation ViewController

// 任务 == 请求
// NSURLSessionDataTask     : GET / POST
// NSURLSessionDownloadTask : 文件下载请求
// NSURLSessionUploadTask   : 文件上传请求

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

//    [self dataTask];
//    [self downloadTask1];
//    [self downloadTask2];
}

#pragma mark - 可以监听下载进度

- (void)downloadTask2 {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    NSURLSessionDownloadTask *sessionDownloadTask = [session downloadTaskWithURL:URL];
    [sessionDownloadTask resume];

    // Note: 如果同时实现了 completionHandler 和代理方法只会执行 block
//    session downloadTaskWithURL:<#(nonnull NSURL *)#> completionHandler:<#^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)completionHandler#>
//    session downloadTaskWithRequest:<#(nonnull NSURLRequest *)#> completionHandler:<#^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)completionHandler#>
}

#pragma mark - NSURLSessionDownloadDelegate

/**
 *  Periodically informs the delegate about the download’s progress.
 *
 *  @param bytesWritten              本次写了多少
 *  @param totalBytesWritten         累计写了多少
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"下载进度: %f", progress);
}

// Tells the delegate that a download task has finished downloading.
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // location 是保存下载文件的临时路径, 沙盒的 tmp 中
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"filePath: %@", filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:location.path toPath:filePath error:nil];
}

// Sent when a download has been resumed
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    NSLog(@"fileOffset: %f", (double)fileOffset);
}

#pragma mark - 无法监听下载进度

- (void)downloadTask1 {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    NSURLSessionDownloadTask *sessionDownloadTask = [session downloadTaskWithURL:URL
                                                               completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                   if (error) {
                                                                       NSLog(@"error: %@", error);
                                                                       return;
                                                                   }
                                                                   NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                                                   NSString *filePath = [caches stringByAppendingPathComponent:response.suggestedFilename];
                                                                   [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:filePath error:nil];
                                                               }];
    [sessionDownloadTask resume];
}

#pragma mark - GET/POST

- (void)dataTask {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    {
        // GET请求
        NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
        NSURLSessionDataTask *getTask = [session dataTaskWithURL:URL
                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                   NSLog(@"%@", respData);
                                               }];
        [getTask resume];
    }
    
    {
        // POST请求
        NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
        NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
        requestM.HTTPMethod = @"POST";
        requestM.HTTPBody = [@"username=123&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDataTask *postTask = [session dataTaskWithRequest:requestM
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                        NSLog(@"%@", respData);
                                                    }];
        [postTask resume];
    }
}

@end
