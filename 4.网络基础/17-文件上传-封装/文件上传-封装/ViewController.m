//
//  ViewController.m
//  文件上传-封装
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

- (NSString *)MIMEType:(NSURL *)URL {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self upload];
}

- (void)upload {
    
    // 普通参数
    NSDictionary *params = @{@"username" : @"gwl",
                             @"pwd" : @"123",
                             @"age" : @25,
                             @"height" : @"168"};
    // 文件参数
//    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"txt"];
//    NSString *MIMEType = [self MIMEType:URL];
//    NSData *data = [NSData dataWithContentsOfURL:URL];
//    [self upload:@"abc.txt" mimeType:MIMEType fileData:data params:params];
    UIImage *image = [UIImage imageNamed:@"stayreal"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [self upload:@"sr.png" mimeType:@"image/png" fileData:imageData params:params];
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
