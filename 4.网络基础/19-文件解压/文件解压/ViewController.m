//
//  ViewController.m
//  文件解压
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:URL
                                                                             completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                                 if (error) {
                                                                                     NSLog(@"error: %@", error);
                                                                                     return;
                                                                                 }
                                                                                 NSLog(@"response: %@", response);
                                                                                 NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                                                                 [SSZipArchive unzipFileAtPath:location.path toDestination:cachesDirectory];
                                                                             }];
    [downloadTask resume];
}

@end
