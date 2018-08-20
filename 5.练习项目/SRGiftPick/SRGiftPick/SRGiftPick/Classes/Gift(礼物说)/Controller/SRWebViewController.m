//
//  GPWebViewController.m
//  礼物说
//
//  Created by tripleCC on 15/1/24.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import "SRWebViewController.h"

@interface SRWebViewController () <UIWebViewDelegate>

@end

@implementation SRWebViewController

- (void)loadView {
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    self.view = webView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
    UIWebView *webView = (UIWebView *)self.view;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
    [webView loadRequest:request];
    [SVProgressHUD showWithStatus:@"正在加载"];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
