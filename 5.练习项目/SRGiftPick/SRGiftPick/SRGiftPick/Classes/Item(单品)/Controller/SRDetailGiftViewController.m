//
//  SRDetailGiftViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRDetailGiftViewController.h"
#import "SRDetailHeaderView.h"
#import "SRDetailSegmentView.h"
#import "SRSearchGift.h"
#import "SRComment.h"
#import "SRCommentCell.h"
#import "SRBuyViewController.h"

#define SRHeaderContainerH CGRectGetMaxY(self.segmentView.frame)

static const CGFloat SRSegmentH = 44;

@interface SRDetailGiftViewController () <UIWebViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SRSearchGift *searchGift;
@property (nonatomic, strong) UIImage *shareImage;

@property (nonatomic, weak) SRDetailHeaderView  *headerView;
@property (nonatomic, weak) SRDetailSegmentView *segmentView;
@property (nonatomic, weak) UIView *headerContainer;

@property (nonatomic, weak) UIWebView   *webView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton    *commentBtn;

@property (nonatomic, copy  ) NSString *commentsURL;
@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRDetailGiftViewController

#pragma mark - Lazy load

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (NSMutableArray *)comments {
    
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (UIButton *)commentBtn {
    
    if (!_commentBtn) {
        UIButton *commentBtn = [[UIButton alloc] init];
        commentBtn.layer.borderColor = SRThemeColor.CGColor;
        commentBtn.layer.borderWidth = 1;
        commentBtn.layer.cornerRadius = 10;
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [commentBtn setTitleColor:SRThemeColor forState:UIControlStateNormal];
        [commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:commentBtn];
        [commentBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-20);
            make.bottom.equalTo(self.view).offset(-64);
            make.width.equalTo(55);
            make.height.equalTo(25);
        }];
        _commentBtn = commentBtn;
    }
    return _commentBtn;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = SRBackgroundColor;
//    self.view.backgroundColor = SRRandomColor;
    
    [self setupNavBar];
    
    [self sendHTTPRequest];
}

- (void)setupNavBar {
    
    self.title = @"商品详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(shareAction)];
}

- (void)sendHTTPRequest {
    
    NSString *URLString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@?",self.ID];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        
        [self setSearchGift:[SRSearchGift objectWithKeyValues:responseObject[@"data"]]];

        [self setupWebView];
        
        [self setupHeaderContainer];
        
        [self setupTableView];
        
        [self setupBottomBar];
        
        [self setupShareImage];
        
        [self ltSegementAction];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)setupWebView {
    
    [self.view addSubview:({
        UIWebView *webView = [[UIWebView alloc] initWithFrame:SRScreenBounds];
        webView.sr_height -= 44;
        webView.backgroundColor = SRBackgroundColor;
        webView.delegate = self;
        webView.scrollView.delegate = self;
        [webView loadHTMLString:self.searchGift.detail_html baseURL:nil];
//        webView.backgroundColor = SRRandomColor;
        self.webView = webView;
    })];
}

- (void)setupHeaderContainer {
    
    [self.webView.scrollView addSubview:({
        UIView *headerContainer = [[UIView alloc] init];
        [headerContainer addSubview:({
            SRDetailHeaderView *headerView = [SRDetailHeaderView detailTopView];
            headerView.gift = self.searchGift;
//            headerView.backgroundColor = SRRandomColor;
            self.headerView = headerView;
        })];
        
        [headerContainer addSubview:({
            SRDetailSegmentView *segmentView = [SRDetailSegmentView detailSegmentView];
            segmentView.gift = self.searchGift;
            segmentView.frame = CGRectMake(0, self.headerView.sr_height, SRScreenW, SRSegmentH);
            [segmentView ltSegementAddTarget:self selector:@selector(ltSegementAction) forcontrolEvents:UIControlEventTouchUpInside];
            [segmentView rtSegementAddTarget:self selector:@selector(rtSegementAction) forcontrolEvents:UIControlEventTouchUpInside];
//            segmentView.backgroundColor = SRRandomColor;
            self.segmentView = segmentView;
        })];
        
        self.headerContainer = headerContainer;
    })];
    
    self.headerContainer.frame = CGRectMake(0, -SRHeaderContainerH, SRScreenW, SRHeaderContainerH);
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(SRHeaderContainerH + 64, 0, 0, 0);
}

- (void)setupTableView {
    
    [self.view addSubview:({
        UITableView *tableView = [[UITableView alloc] initWithFrame:SRScreenBounds];
        tableView.backgroundColor = SRBackgroundColor;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.contentInset = UIEdgeInsetsMake(SRHeaderContainerH + 64, 0,44, 0);
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 80;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCommentsData)];
//        tableView.backgroundColor = SRRandomColor;
        self.tableView = tableView;
    })];
    [self.tableView.footer beginRefreshing];
}

- (void)setupBottomBar {
    
    UIView *bottomBar = [[UIView alloc] init];
    [self.view addSubview:({
        bottomBar.backgroundColor = [UIColor whiteColor];
        bottomBar.layer.cornerRadius = 1;
        bottomBar.layer.borderWidth = 1;
        bottomBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bottomBar.layer.masksToBounds = YES;
//        bottomBar.backgroundColor = SRRandomColor;
        bottomBar;
    })];
    [bottomBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    NSInteger kHorizontalMargin = 20;
    NSInteger kVerticalMargin = 5;
    UIButton *likeBtn = [[UIButton alloc] init];
    [bottomBar addSubview:({
        likeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [likeBtn setTitleColor:SRThemeColor forState:UIControlStateNormal];
        [likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        likeBtn.layer.cornerRadius = 10;
        likeBtn.layer.borderWidth = 1;
        likeBtn.layer.borderColor = SRThemeColor.CGColor;
        likeBtn.clipsToBounds = YES;
//        likeBtn.backgroundColor = SRRandomColor;
        likeBtn;
    })];
    [likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBar.left).offset(kHorizontalMargin);
        make.top.equalTo(bottomBar).offset(kVerticalMargin);
        make.bottom.equalTo(bottomBar.bottom).offset(-kVerticalMargin);
        make.width.equalTo(self.view).dividedBy(3);
    }];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBar addSubview:({
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [buyBtn setTitle:@"GO天猫购买" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.layer.cornerRadius = 10;
        buyBtn.backgroundColor = SRThemeColor;
        buyBtn.clipsToBounds = YES;
//        buyBtn.backgroundColor = SRRandomColor;
        buyBtn;
    })];
    [buyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBar.top).offset(kVerticalMargin);
        make.bottom.equalTo(bottomBar.bottom).offset(-kVerticalMargin);
        make.right.equalTo(bottomBar.right).offset(-kHorizontalMargin);
        make.width.equalTo(self.view).dividedBy(2);
    }];
}

- (void)setupShareImage {
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.searchGift.cover_image_url]
                                                          options:SDWebImageDownloaderLowPriority
                                                         progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                            self.shareImage = image;
                                                        }];
}

#pragma mark - Network request

- (void)loadCommentsData {
    
    if (!self.commentsURL) {
        self.commentsURL = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@/comments?limit=20&offset=0", self.ID];
    }
    
    [self.sessionManager GET:self.commentsURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.comments  addObjectsFromArray:[SRComment objectArrayWithKeyValuesArray:responseObject[@"data"][@"comments"]]];
        [self.tableView reloadData];
        [self setCommentsURL:responseObject[@"data"][@"paging"][@"next_url"]];
        [self checkFooter];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [self.tableView.footer endRefreshing];
    }];
}

- (void)checkFooter {
    
    if (self.comments.count >= self.searchGift.comments_count) {
        [self.tableView.footer noticeNoMoreData];
    } else {
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRCommentCell *cell = [SRCommentCell cellWithTableView:tableView];
    cell.comment = self.comments[indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > -(SRSegmentH + 64)) {
        [self.view addSubview:self.segmentView];
        self.segmentView.frame = CGRectMake(0, 64, SRScreenW, SRSegmentH);
    } else {
        [self.headerContainer addSubview:self.segmentView];
        self.segmentView.frame = CGRectMake(0, self.headerView.sr_height, SRScreenW, SRSegmentH);
    }
}

#pragma mark - Monitor method

- (void)shareAction {
    
}

- (void)likeBtnAction {
    
    SRLog(@"喜欢");
}

- (void)buyBtnAction {
    
    NSString *taobaoURL = [self.searchGift.purchase_url stringByReplacingOccurrencesOfString:@"http://" withString:@"taobao://"];
    NSURL *URL = [NSURL URLWithString:taobaoURL];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    } else {
        SRBuyViewController *buyVC = [[SRBuyViewController alloc] init];
        buyVC.purchase_url = self.searchGift.purchase_url;
        [self.navigationController pushViewController:buyVC animated:YES];
    }
}

- (void)commentBtnAction {
    
    SRLog(@"评论");
}

- (void)ltSegementAction {
    
    self.webView.hidden = NO;
    self.tableView.hidden = YES;
    [self.webView.scrollView addSubview:self.headerContainer];
    if (self.segmentView.superview != self.headerContainer) {
        [self.webView.scrollView setContentOffset:CGPointMake(0, -(SRSegmentH + 64)) animated:YES];
    } else {
        self.webView.scrollView.contentOffset = self.tableView.contentOffset;
    }
    self.commentBtn.hidden = YES;
}

- (void)rtSegementAction {
    
    self.webView.hidden = YES;
    self.tableView.hidden = NO;
    [self.tableView addSubview:self.headerContainer];
    if (self.segmentView.superview != self.headerContainer) {
        [self.tableView setContentOffset:CGPointMake(0, -(SRSegmentH + 64)) animated:YES];
    } else {
        self.tableView.contentOffset = self.webView.scrollView.contentOffset;
    }
    self.commentBtn.hidden = NO;
}

@end
