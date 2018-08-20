//
//  ViewController.m
//  文件压缩
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

#define kFileBoundary  @"SR"
#define kNewLien       @"\r\n"
#define kEncode(str)   [str dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

- (NSString *)MIMEType:(NSURL *)URL {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *videosPath = [caches stringByAppendingPathComponent:@"videos"]; // 源文件路径
    NSString *zipVideosPath = [caches stringByAppendingPathComponent:@"videos.zip"]; // 压缩文件路径
    BOOL result = [SSZipArchive createZipFileAtPath:zipVideosPath withContentsOfDirectory:videosPath]; // 压缩文件
    if (result) { // 上传文件
        NSString *MIMEType = [self MIMEType:[NSURL fileURLWithPath:zipVideosPath]];
        NSData *data = [NSData dataWithContentsOfFile:zipVideosPath];
        [self upload:@"videos.zip" mimeType:MIMEType fileData:data params:@{@"username": @"gwl"}];
    }
}

- (void)upload:(NSString *)filename mimeType:(NSString *)mimeType fileData:(NSData *)fileData params:(NSDictionary *)params {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    
    NSMutableData *body = [NSMutableData data];
    // 文件参数
    [body appendData:kEncode(@"--")];
    [body appendData:kEncode(kFileBoundary)];
    [body appendData:kEncode(kNewLien)];
    
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"", filename];
    [body appendData:kEncode(disposition)];
    [body appendData:kEncode(kNewLien)];
    
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@", mimeType];
    [body appendData:kEncode(type)];
    [body appendData:kEncode(kNewLien)];
    
    [body appendData:kEncode(kNewLien)];
    [body appendData:fileData];
    [body appendData:kEncode(kNewLien)];
    
    // 普通参数
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [body appendData:kEncode(@"--")];
        [body appendData:kEncode(kFileBoundary)];
        [body appendData:kEncode(kNewLien)];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
        [body appendData:kEncode(disposition)];
        [body appendData:kEncode(kNewLien)];
        
        [body appendData:kEncode(kNewLien)];
        [body appendData:kEncode([obj description])];
        [body appendData:kEncode(kNewLien)];
    }];
    
    // 结束标记
    [body appendData:kEncode(@"--")];
    [body appendData:kEncode(kFileBoundary)];
    [body appendData:kEncode(@"--")];
    [body appendData:kEncode(kNewLien)];
    request.HTTPBody = body;
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kFileBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSLog(@"%@", respData);
                           }];
}

@end
