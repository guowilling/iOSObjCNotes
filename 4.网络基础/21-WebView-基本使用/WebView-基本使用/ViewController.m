//
//  ViewController.m
//  WebView-基本使用
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"login" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    webView.delegate = self;
    self.webView = webView;
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.webView goBack];
}

- (IBAction)forward:(UIBarButtonItem *)sender {
    
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // URL格式: 协议头://主机名/路径
    // request.URL.path: 主机名(域名)后面的路径
    // request.URL.absoluteString: 完整的URL路径
    
    NSString *path = request.URL.path;
    NSLog(@"path: %@", path);
    
    NSString *absoluteString = request.URL.absoluteString;
    NSLog(@"absoluteString: %@", absoluteString);
    
    NSRange aRange = [absoluteString rangeOfString:@"baidu"];
    NSUInteger location = aRange.location;
    if (location != NSNotFound) { // aRange.length > 0;
        //...
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
    
    self.back.enabled = [webView canGoBack];
    self.forward.enabled = [webView canGoForward];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"didFailLoadWithError");
}

@end
