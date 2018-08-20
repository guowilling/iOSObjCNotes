//
//  SRGuideDetailViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRGuideDetailViewController.h"
#import "SRGuideDetail.h"
#import "SRGuideDetailToolBar.h"
#import "SRDetailGiftViewController.h"

#define SRHeaderLableFont [UIFont systemFontOfSize:22]

static CGFloat const SRHeaderimageViewH        = 220;
static CGFloat const SRHeaderLableLeftMargin   = 15;
static CGFloat const SRHeaderLableRightMargin  = 15;
static CGFloat const SRHeaderLableBottomMargin = 15;

@interface SRGuideDetailViewController () <UIWebViewDelegate, UIScrollViewDelegate, SRGuideDetailToolBarDelegate>

@property (nonatomic, weak) UIImageView *headerImageView;
@property (nonatomic, weak) UILabel *headerLable;

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, weak) SRGuideDetailToolBar *toolBar;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) SRGuideDetail *guideDetail;

@property (nonatomic, strong) UIImage *shareImage;

@end

@implementation SRGuideDetailViewController

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = SRBackgroundColor;
    
    [self setupNavBar];
    
    [self setupHeaderImageView];
    
    [self setupWebView];
    
    [self setupHeaderLable];
    
    [self setupToolBar];
    
    [self loadData];
}

#pragma mark - Setup UI

- (void)setupNavBar {
    self.title = @"攻略详情";
}

- (void)setupHeaderImageView {
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.frame = CGRectMake(0, 64, SRScreenW, SRHeaderimageViewH);
    [headerImageView.layer addSublayer:({
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
        gradientLayer.opacity  = 0.5;
        gradientLayer.frame = headerImageView.bounds;
        gradientLayer;
    })];
    [self.view addSubview:headerImageView];
    self.headerImageView = headerImageView;
//    self.headerImageView.backgroundColor = SRRandomColor;
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = SRScreenBounds;
    webView.sr_height -= 44;
    webView.backgroundColor = [UIColor clearColor];
    webView.delegate = self;
    webView.scrollView.delegate = self;
    webView.scrollView.contentInset = UIEdgeInsetsMake(SRHeaderimageViewH + 64, 0, 0, 0);
    webView.scrollView.contentOffset = CGPointMake(0, -(SRHeaderimageViewH + 64));
//    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    self.webView = webView;
//    self.webView.backgroundColor = SRRandomColor;
}

- (void)setupHeaderLable {
    UILabel *lable = [[UILabel alloc] init];
    lable.font = SRHeaderLableFont;
    lable.textColor = [UIColor whiteColor];
    lable.numberOfLines = 0;
    [self.webView.scrollView addSubview:lable];
    self.headerLable = lable;
//    self.headerLable.backgroundColor = SRRandomColor;
}

- (void)setupToolBar {
    SRGuideDetailToolBar *toolBar = [SRGuideDetailToolBar guideDetailToolBar];
    toolBar.sr_y = self.view.sr_height - toolBar.sr_height;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
//    self.toolBar.backgroundColor = SRRandomColor;
}

#pragma mark - Network Request

- (void)loadData {
    NSString *URLString = [NSString stringWithFormat:@"https://api.liwushuo.com/v1/posts/%ld", self.ID];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        self.guideDetail = [SRGuideDetail objectWithKeyValues:responseObject[@"data"]];
        
        [self.webView loadHTMLString:self.guideDetail.content_html baseURL:nil];
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.guideDetail.cover_image_url]
                                placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
        
        [self adjustHeaderLabelFrameWithText:self.guideDetail.title];
        
        self.toolBar.guideDetail = self.guideDetail;
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.guideDetail.cover_image_url]
                                                              options:SDWebImageDownloaderLowPriority
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                self.shareImage = image;
                                                            }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"downloadImageWithURL error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)adjustHeaderLabelFrameWithText:(NSString *)text {
    self.headerLable.text = text;
    CGSize headerLableSize = [text sizeWithFont:SRHeaderLableFont maxWidth:SRScreenW - 2 * SRHeaderLableRightMargin];
    self.headerLable.frame = CGRectMake(SRHeaderLableLeftMargin, -(headerLableSize.height + SRHeaderLableBottomMargin),
                                        SRScreenW - 2 * SRHeaderLableRightMargin, headerLableSize.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat downScale = 2.0;
    CGFloat upRate = 0.5;
    if (ABS(offsetY) < scrollView.contentInset.top) {
        self.headerImageView.transform = CGAffineTransformMakeTranslation(0, -(offsetY + scrollView.contentInset.top) * upRate);
    } else if (ABS(offsetY + scrollView.contentInset.top) < SRHeaderimageViewH / 2) {
        CGFloat scale = -(offsetY + scrollView.contentInset.top) / SRHeaderimageViewH * downScale + 1;
        self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);
    } else {
        self.headerImageView.transform = CGAffineTransformMakeTranslation(0, ABS(offsetY) - scrollView.contentInset.top - SRHeaderimageViewH / downScale);
        self.headerImageView.transform = CGAffineTransformScale(self.headerImageView.transform, downScale, downScale);
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *detailGiftID = [[request.URL.absoluteString componentsSeparatedByString:@"/"] lastObject];
        SRDetailGiftViewController *detailGiftViewController = [[SRDetailGiftViewController alloc] init];
        detailGiftViewController.ID = detailGiftID;
        [self.navigationController pushViewController:detailGiftViewController animated:YES];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth,oldheight;"
     "var maxwidth = document.body.clientWidth-16;"
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

#pragma mark - SRGuideDetailToolBarDelegate

- (void)guideDetailToolBar:(SRGuideDetailToolBar *)guideDetailToolBar didClickShareBtn:(UIButton *)shareBtn {
    
}

@end
