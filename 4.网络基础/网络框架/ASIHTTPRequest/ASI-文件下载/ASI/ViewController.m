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

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, assign, getter=isDownloading) BOOL downloading;

@property (nonatomic, strong) ASIHTTPRequest *request;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self download];
}

- (void)download {
    
    if (self.isDownloading) {
        [self.request clearDelegatesAndCancel];
        self.downloading = NO;
        return;
    }
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [caches stringByAppendingPathComponent:@"videos.zip"];
    request.downloadDestinationPath = filepath; // 保存路径
    //request.downloadProgressDelegate = self // 下载进度代理
    request.downloadProgressDelegate = self.progressView; // UIProgressView 自带 setProgress: 方法
    request.allowResumeForFileDownloads = YES; // 断点下载
    request.temporaryFileDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"videos.zip"]; // 断点下载需要临时文件路径
    [request startAsynchronous];
    self.request = request;
    self.downloading = YES;
}

- (void)setProgress:(float)progress {

    NSLog(@"progress: %f", progress);
    self.progressView.progress = progress;
}

@end
