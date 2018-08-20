//
//  ViewController.m
//  大文件下载-断点下载
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startOrPauseBtn;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) NSFileHandle *fileHandle;

@property (nonatomic, strong) NSURLConnection *downloadRequest;

@property (nonatomic, assign) NSInteger currentLength;
@property (nonatomic, assign) NSInteger totalLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)startOrPause:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", (long long)_currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"]; // 设置请求头从已下载位置继续下载
        _downloadRequest = [NSURLConnection connectionWithRequest:request delegate:self];
    } else {
        if (_downloadRequest) {
            [_downloadRequest cancel];
            _downloadRequest = nil;
        }
    }
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"didReceiveResponse");
    
    if (_currentLength != 0) { // 不等于0说明是继续下载直接返回
        return;
    }
    
    _totalLength = response.expectedContentLength;
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videos.zip"];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_fileHandle seekToEndOfFile];
    [_fileHandle writeData:data];
    
    _currentLength += data.length;
    _progressView.progress = _currentLength / _totalLength * 1.0;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectionDidFinishLoading");
    
    if (_fileHandle) {
        [_fileHandle closeFile];
        _fileHandle = nil;
    }
    
    _startOrPauseBtn.selected = NO;
    _currentLength = 0;
    _totalLength = 0;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
}

@end
