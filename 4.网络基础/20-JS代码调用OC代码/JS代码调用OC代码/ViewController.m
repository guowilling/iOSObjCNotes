//
//  ViewController.m
//  JS代码调用OC代码
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *absoluteString = request.URL.absoluteString;
    NSRange aRange = [absoluteString rangeOfString:@"sr://"];
    NSUInteger aLocation = aRange.location;
    if (aLocation != NSNotFound) {
        NSString *methodName = [absoluteString substringFromIndex:aLocation + aRange.length];
        SEL aSelector = NSSelectorFromString(methodName);
        [self performSelector:aSelector withObject:nil];
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
}

- (void)call {
    
    NSLog(@"call");
}

- (void)openCamera {
    
    NSLog(@"openCamera");
}

@end
