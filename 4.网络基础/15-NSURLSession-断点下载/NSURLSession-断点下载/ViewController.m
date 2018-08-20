//
//  ViewController.m
//  NSURLSession-断点下载
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation ViewController

- (NSURLSession *)session {
    
    if (!_session) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                 delegate:self
                                            delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)startOrPause:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    if (_downloadTask) {
        [self pauseTask];
        return;
    }
    if (_resumeData) {
        [self resumeTask];
        return;
    }
    [self startTask];
}

- (void)startTask {
    
    NSString *URLString = @"http://baobab.wdjcdn.com/1442142801331138639111.mp4";
    _downloadTask = [_session downloadTaskWithURL:[NSURL URLWithString:URLString]];
    [_downloadTask resume];
}

- (void)resumeTask {
    
    // Creates a download task to resume a previously canceled or failed download
    _downloadTask = [_session downloadTaskWithResumeData:_resumeData];
    [_downloadTask resume];
    _resumeData = nil;
}

- (void)pauseTask {
    
    __weak typeof(self) weakSelf = self;
    [_downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        weakSelf.resumeData = resumeData;
        weakSelf.downloadTask = nil;
    }];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    //NSLog(@"%s", __func__);
    //NSLog(@"currentThread: %@", [NSThread currentThread]);
    //NSLog(@"下载进度: %.2f", (double)totalBytesWritten / totalBytesExpectedToWrite);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    NSLog(@"%s", __func__);
    NSLog(@"fileOffset: %zd", fileOffset);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSLog(@"%s", __func__);
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:filePath error:nil];
}

@end
