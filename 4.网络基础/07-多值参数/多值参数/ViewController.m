//
//  ViewController.m
//  多值参数
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/weather"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.HTTPMethod = @"POST";
    NSMutableString *paramsString = [NSMutableString string];
    [paramsString appendString:@"place=beijing"];
    [paramsString appendString:@"&place=tianjin"];
    [paramsString appendString:@"&place=meizhou"];
    requestM.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:requestM
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!data|| connectionError) {
                                   return;
                               }
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSLog(@"respData: %@", respData);
                               NSString *error = respData[@"error"];
                               if (error) {
                                   NSLog(@"error: %@", error);
                               } else {
                                   NSArray *weathers = respData[@"weathers"];
                                   NSLog(@"%@", weathers);
                               }
                           }];
}

@end
