//
//  ViewController.m
//  文件上传-基础
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

#define kFileBoundary  @"SR"
#define kNewLien       @"\r\n"
#define kEncode(str)   [str dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self upload];
}

- (void)upload {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/upload"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.HTTPMethod = @"POST";
    
    NSMutableData *bodyData = [NSMutableData data];
    {
        // 文件参数
        [bodyData appendData:kEncode(@"--")];
        [bodyData appendData:kEncode(kFileBoundary)];
        [bodyData appendData:kEncode(kNewLien)];
        
        [bodyData appendData:kEncode(@"Content-Disposition: form-data; name=\"file\"; filename=\"stayreal.png\"")];
        [bodyData appendData:kEncode(kNewLien)];
        
        [bodyData appendData:kEncode(@"Content-Type: image/png")];
        [bodyData appendData:kEncode(kNewLien)];
        
        [bodyData appendData:kEncode(kNewLien)];
        UIImage *image = [UIImage imageNamed:@"stayreal"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [bodyData appendData:imageData];
        [bodyData appendData:kEncode(kNewLien)];
    }
    
    {
        // 普通参数
        [bodyData appendData:kEncode(@"--")];
        [bodyData appendData:kEncode(kFileBoundary)];
        [bodyData appendData:kEncode(kNewLien)];
        
        [bodyData appendData:kEncode(@"Content-Disposition: form-data; name=\"username\"")];
        [bodyData appendData:kEncode(kNewLien)];
        
        [bodyData appendData:kEncode(kNewLien)];
        [bodyData appendData:kEncode(@"gwl")];
        [bodyData appendData:kEncode(kNewLien)];
    }
    
    {
        // 结束标记
        [bodyData appendData:kEncode(@"--")];
        [bodyData appendData:kEncode(kFileBoundary)];
        [bodyData appendData:kEncode(@"--")];
        [bodyData appendData:kEncode(kNewLien)];
    }
    requestM.HTTPBody = bodyData; // 设置请求体
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kFileBoundary];
    [requestM setValue:contentType forHTTPHeaderField:@"Content-Type"]; // 设置请求头
    [NSURLConnection sendAsynchronousRequest:requestM
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSLog(@"%@", respData);
                           }];
}

@end
