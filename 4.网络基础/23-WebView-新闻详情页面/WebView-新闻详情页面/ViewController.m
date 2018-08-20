//
//  ViewController.m
//  WebView-新闻详情页面
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/A7AQOT560001124J/full.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSDictionary *news = respData[@"A7AQOT560001124J"];
                               NSLog(@"news: %@", news);
                               [self showNews:news];
                           }];
}

- (void)showNews:(NSDictionary *)news {
    
    NSString *bodyHTML = news[@"body"];
    
    // 拼接图片
    NSDictionary *img = [news[@"img"] lastObject];
    NSString *imgHTML = [NSString stringWithFormat:@"<img src=\"%@\" width=\"300\" height=\"171\">", img[@"src"]];
    bodyHTML = [bodyHTML stringByReplacingOccurrencesOfString:img[@"ref"] withString:imgHTML];
    
    // 拼接头部
    NSString *title = news[@"title"];
    NSString *time = news[@"ptime"];
    NSString *headerHTML = [NSString stringWithFormat:@"<div class=\"title\">%@</div><div class=\"time\">%@</div>", title, time];
    bodyHTML = [NSString stringWithFormat:@"%@%@", headerHTML, bodyHTML];
    
    // 拼接样式
    NSURL *cssURL = [[NSBundle mainBundle] URLForResource:@"news" withExtension:@"css"];
    bodyHTML = [NSString stringWithFormat:@"%@<link rel=\"stylesheet\" href=\"%@\">", bodyHTML, cssURL];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadHTMLString:bodyHTML baseURL:nil];
    [self.view addSubview:webView];
}

@end
