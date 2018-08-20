//
//  SROAuthViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SROAuthViewController.h"
#import "AFNetworking.h"
#import "SRAccount.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "UIWindow+Extension.h"

@interface SROAuthViewController () <UIWebViewDelegate>

@end

@implementation SROAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSURL *URLString = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3309402497&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URLString];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"加载中.."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    SRLog(@"didFailLoadWithError error: %@", error);
//    [MBProgressHUD hideHUD];
//    [MBProgressHUD showError:@"网络异常"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *absoluteString = request.URL.absoluteString;
    SRLog(@"shouldStartLoadWithRequest absoluteString: %@", absoluteString);
    NSRange range = [absoluteString rangeOfString:@"code="];
    if (range.length != 0) {
        NSString *code = [absoluteString substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    SRLog(@"accessTokenWithCode code: %@", code);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = SRClientID;
    params[@"client_secret"] = SRClientSecret;
    params[@"grant_type"] = SRGrantType;
    params[@"redirect_uri"] = SRRedirectURI;
    params[@"code"] = code;
    [manager POST:@"https://api.weibo.com/oauth2/access_token"
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              SRAccount *account = [SRAccount accountWithDict:responseObject];
              [SRAccountManager saveAccount:account];
              [[UIApplication sharedApplication].keyWindow switchRootViewController];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              SRLog(@"error: %@", error);
          }];
}

@end
