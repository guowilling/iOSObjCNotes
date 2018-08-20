
#import "OAuthViewController.h"
#import "UserAccountTool.h"

@interface OAuthViewController () <NSURLConnectionDelegate, UIWebViewDelegate> {
    
    UIWebView *_webView;
}

@end

@implementation OAuthViewController

- (void)loadView {
    
    [super loadView];
    
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:OAuth_URL]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [SVProgressHUDManager dismiss];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSInteger fromIndex = range.length + range.location;
        NSString *code = [urlString substringFromIndex:fromIndex];
        [UserAccountTool getAccessTokenWithcode:code success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } filure:nil];
        return NO;
    } else {
        return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

    [SVProgressHUDManager showWithStatus:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUDManager dismiss];
}

@end
