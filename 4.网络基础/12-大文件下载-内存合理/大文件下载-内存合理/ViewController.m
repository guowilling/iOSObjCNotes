//
//  ViewController.m
//  大文件下载-内存合理
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/** 文件的句柄 */
@property (nonatomic, strong) NSFileHandle *fileHandle;

/** 文件总大小 */
@property (nonatomic, assign) long long totalLength;

/** 已下载大小 */
@property (nonatomic, assign) long long currentLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _totalLength = 0;
    _currentLength = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    _totalLength = response.expectedContentLength;
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"videos.zip"];
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_fileHandle seekToEndOfFile]; // 移动到文件末尾
    [_fileHandle writeData:data];
    
    _currentLength += data.length;
    _progressView.progress = _currentLength / _totalLength * 1.0;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (_fileHandle) {
        [_fileHandle closeFile];
        _fileHandle = nil;
    }
    
    _totalLength = 0;
    _currentLength = 0;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
}

@end
