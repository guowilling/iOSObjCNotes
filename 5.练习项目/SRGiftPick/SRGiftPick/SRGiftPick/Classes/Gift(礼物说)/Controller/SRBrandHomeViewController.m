//
//  SRBrandHomeViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRBrandHomeViewController.h"
#import "SRBrandHome.h"
#import "SRBrandHomeHeader.h"
#import "SRSegmentControl.h"
#import "SRSearchGift.h"
#import "SRSearchGiftCell.h"
#import "SRDetailGiftViewController.h"

static const CGFloat SRHeaderViewH  = 200;
static const CGFloat SRSegmentViewH = 44;

@interface SRBrandHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SRBrandHome *brandHome;
@property (nonatomic, strong) NSMutableArray *gifts;

@property (nonatomic, weak) SRBrandHomeHeader *headerView;
@property (nonatomic, weak) SRSegmentControl  *segementControl;
@property (nonatomic, weak) UIView *headerContainer;

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy) NSString *firstPageURL;
@property (nonatomic, copy) NSString *nextPageURL;

@end

#define SRMakeOffsetIdentify(view) \
{ \
CGFloat offsetY = -(64 + SRSegmentViewH); \
[view setContentOffset:CGPointMake(0, offsetY) animated:YES]; \
}

@implementation SRBrandHomeViewController

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager =[AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = SRBackgroundColor;
    
    [self setupNavBar];
    
    [self setupCollectionView];
    
    [self setupWebView];
    
    [self setupTopContainerView];
    
    [self getBrandHomeBaseData];
    
    [self getBrandHomeGiftsData];
    
    [self ltSegementAction];
}

- (void)setupNavBar {
    
    self.title = @"品牌主页";
}

- (void)setupCollectionView {
    
    [self.view addSubview:({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:SRScreenBounds collectionViewLayout:({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (SRScreenW - 3 * SRCollectionItemMargin) * 0.5;
            flowLayout.itemSize = CGSizeMake(itemW, SRCollectionItemH);
            flowLayout.minimumInteritemSpacing = SRCollectionItemMargin;
            flowLayout.minimumLineSpacing = SRCollectionItemMargin;
            flowLayout.sectionInset = SRCollectionSectionInsets;
            flowLayout;
        })];
        collectionView.backgroundColor = SRBackgroundColor;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.contentInset = UIEdgeInsetsMake(64 + SRHeaderViewH + SRSegmentViewH , 0, 0, 0);
        collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRSearchGiftCell class]) bundle:nil] forCellWithReuseIdentifier:giftCellID];
//        collectionView.backgroundColor = SRRandomColor;
        self.collectionView = collectionView;
    })];
}

- (void)setupWebView {
    
    [self.view addSubview:({
        UIWebView *webView = [[UIWebView alloc] initWithFrame:SRScreenBounds];
        webView.backgroundColor = SRBackgroundColor;
        webView.scrollView.delegate = self;
        webView.scrollView.contentInset = UIEdgeInsetsMake(64 + SRHeaderViewH + SRSegmentViewH , 0, 0, 0);
//        webView.backgroundColor = SRRandomColor;
        self.webView = webView;
    })];
}

- (void)setupTopContainerView {
    
    [self.collectionView addSubview:({
        UIView *headerContainer = [[UIView alloc] init];
        CGFloat headerContainerViewH = SRHeaderViewH + SRSegmentViewH;
        headerContainer.frame = CGRectMake(0, -headerContainerViewH, SRScreenW, headerContainerViewH);
//        headerContainer.backgroundColor = SRRandomColor;
        self.headerContainer = headerContainer;
    })];
    
    [self.headerContainer addSubview:({
        SRBrandHomeHeader *headerView = [SRBrandHomeHeader brandHomeHeader];
        headerView.frame = CGRectMake(0, 0, SRScreenW, SRHeaderViewH);
//        headerView.backgroundColor = SRRandomColor;
        self.headerView = headerView;
    })];
    
    [self.headerContainer addSubview:({
        SRSegmentControl *segementControl = [SRSegmentControl segmentControl];
        segementControl.frame = CGRectMake(0, SRHeaderViewH, SRScreenW, SRSegmentViewH);
        [segementControl ltSegementAddTarget:self selector:@selector(ltSegementAction) forControlEvents:UIControlEventTouchUpInside];
        [segementControl rtSegementAddTarget:self selector:@selector(rtSegementAction) forControlEvents:UIControlEventTouchUpInside];
//        segementControl.backgroundColor = SRRandomColor;
        self.segementControl = segementControl;
    })];
}

#pragma mark - Monitor method

- (void)ltSegementAction {
    
    self.collectionView.hidden = NO;
    self.webView.hidden = YES;
    [self.collectionView addSubview:self.headerContainer];
    if (self.segementControl.superview != self.headerContainer) {
        SRMakeOffsetIdentify(self.collectionView);
    } else {
        self.collectionView.contentOffset = self.webView.scrollView.contentOffset;
    }
}

- (void)rtSegementAction {
    
    self.collectionView.hidden = YES;
    self.webView.hidden = NO;
    [self.webView.scrollView addSubview:self.headerContainer];
    if (self.segementControl.superview != self.headerContainer) {
        SRMakeOffsetIdentify(self.webView.scrollView);
    } else {
        self.webView.scrollView.contentOffset = self.collectionView.contentOffset;
    }
}

#pragma mark - Network request

- (void)getBrandHomeBaseData {
    
    NSString *URLString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/brands/%ld", self.ID];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        self.brandHome = [SRBrandHome objectWithKeyValues:responseObject[@"data"]];
        self.headerView.brandHome = self.brandHome;
        [self.webView loadHTMLString:self.brandHome.intro_html baseURL:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)getBrandHomeGiftsData {
    
    self.firstPageURL = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/brands/%ld/items?limit=20&offset=0", self.ID];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:self.firstPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        self.gifts = [SRSearchGift objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        [self.collectionView reloadData];
        self.nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)loadMoreData {
    
    if (!self.nextPageURL || self.nextPageURL.length == 0) {
        [self.collectionView.footer noticeNoMoreData];
        return;
    }
    
    [self.sessionManager GET:self.nextPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.gifts addObjectsFromArray:[SRSearchGift objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]]];
        [self.collectionView reloadData];
        NSString *nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
        if ([nextPageURL isKindOfClass:[NSNull class]] || [nextPageURL isEqualToString:self.nextPageURL]) {
            self.nextPageURL = nil;
        } else {
            self.nextPageURL = nextPageURL;
        }
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)checkFooterState {
    
    if (self.nextPageURL) {
        [self.collectionView.footer endRefreshing];
    } else {
        [self.collectionView.footer noticeNoMoreData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.gifts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRSearchGiftCell *cell = [SRSearchGiftCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.gift = self.gifts[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRDetailGiftViewController *detailGiftVC = [[SRDetailGiftViewController alloc] init];
    SRSearchGift *gift = self.gifts[indexPath.item];
    detailGiftVC.ID = gift.ID;
    [self.navigationController pushViewController:detailGiftVC animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > -(64 + SRSegmentViewH)) {
        [self.view addSubview:self.segementControl];
        self.segementControl.frame = CGRectMake(0, 64, SRScreenW, SRSegmentViewH);
    } else {
        [self.headerContainer addSubview:self.segementControl];
        self.segementControl.frame = CGRectMake(0, SRHeaderViewH, SRScreenW, SRSegmentViewH);
    }
}

@end
