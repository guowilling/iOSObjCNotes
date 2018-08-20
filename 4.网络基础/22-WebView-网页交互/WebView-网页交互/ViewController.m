//
//  ViewController.m
//  WebView-网页交互
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = self.view.bounds;
        webView.scalesPageToFit = YES;
        webView.delegate = self;
        webView.scrollView.hidden = YES;
        [self.view addSubview:webView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]];
        [webView loadRequest:request];
    }
    
    {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicatorView.center =CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
        [self.view addSubview:activityIndicatorView];
        self.indicatorView = activityIndicatorView;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
     [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.indicatorView stopAnimating];
    
    NSMutableString *js1 = [NSMutableString string];
    {
        // 删除顶部导航条
        [js1 appendString:@"var header = document.getElementsByTagName('header')[0];"];
        [js1 appendString:@"header.parentNode.removeChild(header);"];
    }
    {
        // 删除底部链接
        [js1 appendString:@"var footer = document.getElementsByTagName('footer')[0];"];
        [js1 appendString:@"footer.parentNode.removeChild(footer);"];
        [webView stringByEvaluatingJavaScriptFromString:js1];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 删除浮动广告
        NSMutableString *js2 = [NSMutableString string];
        [js2 appendString:@"var list = document.body.childNodes;"];
        [js2 appendString:@"var len = list.length;"];
        [js2 appendString:@"var banner = list[len - 1];"];
        [js2 appendString:@"banner.parentNode.removeChild(banner);"];
        [webView stringByEvaluatingJavaScriptFromString:js2];
        
        [webView.scrollView setHidden:NO];
    });
}

@end
