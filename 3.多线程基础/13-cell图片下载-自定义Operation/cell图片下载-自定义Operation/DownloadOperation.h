//
//  DownloadOperation.h
//  cell图片下载-自定义Operation
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownloadOperation;

@protocol DownloadOperationDelegate <NSObject>

- (void)downloadOperation:(DownloadOperation *)downloadOperation didFinishedDownload:(UIImage *)image;

@end

@interface DownloadOperation : NSOperation

@property (nonatomic, strong) NSString    *URLString;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<DownloadOperationDelegate> delegate;

@end
