//
//  SRBuyViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRBuyViewController.h"

@interface SRBuyViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation SRBuyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:({
        webView.delegate = self;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.purchase_url]]];
        self.webView = webView;
    })];
    [webView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

@end
