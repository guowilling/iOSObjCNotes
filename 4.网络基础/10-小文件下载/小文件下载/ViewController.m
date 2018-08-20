//
//  ViewController.m
//  小文件下载
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self downloadWithNSURLConnection];
    //[self downloadWithDataWithContentsOfURL];
}

- (void)downloadWithNSURLConnection {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSLog(@"data: %@", data);
                           }];
}

- (void)downloadWithDataWithContentsOfURL {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"currentThread: %@", [NSThread currentThread]);
        NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        NSLog(@"data: %@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            // ...
        });
    });
}

@end
