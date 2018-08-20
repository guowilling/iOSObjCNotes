//
//  DownloadOperation.m
//  cell图片下载-自定义Operation
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

- (void)main {
    
    @autoreleasepool {
        
        if (self.isCancelled) { // 下载未开始被取消了
            return;
        }
        
        NSURL *url = [NSURL URLWithString:self.URLString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        if (self.isCancelled) { // 下载期间被被取消了
            return;
        }
        
        // 注意需要回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishedDownload:)]) {
                [self.delegate downloadOperation:self didFinishedDownload:image];
            }
        }];
        
    }
}

@end
