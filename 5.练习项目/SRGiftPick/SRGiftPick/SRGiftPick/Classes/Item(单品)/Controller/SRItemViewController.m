//
//  SRItemViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRItemViewController.h"
#import "SRSearchGift.h"
#import "AFNetworking.h"
#import "SRSearchGiftCell.h"
#import "SRDetailGiftViewController.h"
#import "SRSearchViewController.h"
#import "SRRefreshGiftHeader.h"

@interface SRItemViewController ()

@property (nonatomic, copy  ) NSString *nextPageURL;
@property (nonatomic, strong) NSMutableArray *searchGifts;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRItemViewController

- (instancetype)init {
    
    return [super initWithCollectionViewLayout:({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (SRScreenW - 3 * SRCollectionItemMargin) * 0.5;
        flowLayout.itemSize = CGSizeMake(itemW, SRCollectionItemH);
        flowLayout.minimumInteritemSpacing = SRCollectionItemMargin;
        flowLayout.minimumLineSpacing = SRCollectionItemMargin;
        flowLayout.sectionInset = SRCellUIEdgeInsets;
        flowLayout;
    })];
}

#pragma mark - Lazy load

- (NSString *)firstPageURL {
    
    if (!_firstPageURL) {
        _firstPageURL = @"http://api.liwushuo.com/v2/items?gender=1&generation=1&limit=20&offset=0";
    }
    return _firstPageURL;
}

- (NSMutableArray *)searchGifts {
    
    if (!_searchGifts) {
        _searchGifts = [NSMutableArray array];
    }
    return _searchGifts;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = SRBackgroundColor;
//    self.collectionView.backgroundColor = SRRandomColor;
    
    [self setupNavBar];
    
    [self setupRefresh];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRSearchGiftCell class]) bundle:nil] forCellWithReuseIdentifier:giftCellID];
}

- (void)setupNavBar {
    
    self.title = @"单品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(findAction)];
}

- (void)findAction {
    
    SRSearchViewController *searchViewVC = [[SRSearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewVC animated:YES];
}

- (void)setupRefresh {
    
    self.collectionView.header = [SRRefreshGiftHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.collectionView.header beginRefreshing];
}

#pragma mark - Network request

- (void)loadNewData {
    
    [self.sessionManager GET:self.firstPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.collectionView.header endRefreshing];
        if (self.searchGifts.count != 0) {
            [self.searchGifts removeAllObjects];
        }
        NSArray *dictArray = responseObject[@"data"][@"items"];
        if ([[dictArray firstObject][@"type"] isEqualToString:@"item"]) {
            for (NSDictionary *dict in dictArray) {
                SRSearchGift *gift = [SRSearchGift objectWithKeyValues:dict[@"data"]];
                [self.searchGifts addObject:gift];
            }
        } else {
            [self.searchGifts addObjectsFromArray:[SRSearchGift objectArrayWithKeyValuesArray:dictArray]];
        }
        [self.collectionView reloadData];
        
        self.nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [self.collectionView.header endRefreshing];
    }];
}

- (void)loadMoreData {
    
    if (!self.nextPageURL) {
        [self.collectionView.footer noticeNoMoreData];
        return;
    }
    
    [self.sessionManager GET:self.nextPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSArray *dictArray = responseObject[@"data"][@"items"];
        if ([[dictArray firstObject][@"type"] isEqualToString:@"item"]) {
            for (NSDictionary *dict in dictArray) {
                SRSearchGift *gift = [SRSearchGift objectWithKeyValues:dict[@"data"]];
                [self.searchGifts addObject:gift];
            }
        } else {
            [self.searchGifts addObjectsFromArray:[SRSearchGift objectArrayWithKeyValuesArray:dictArray]];
        }
        [self.collectionView reloadData];
        
        NSString *nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
        if ([nextPageURL isKindOfClass:[NSNull class]]) { // !!注意: nil是空对象 Null是值为空的对象
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
    
    if (!self.nextPageURL) {
        [self.collectionView.footer noticeNoMoreData];
    } else {
        [self.collectionView.footer endRefreshing];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.searchGifts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRSearchGiftCell *cell = [SRSearchGiftCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.gift = self.searchGifts[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRDetailGiftViewController *detailGiftViewController = [[SRDetailGiftViewController alloc] init];
    detailGiftViewController.ID = [self.searchGifts[indexPath.row] ID];
    [self.navigationController pushViewController:detailGiftViewController animated:YES];
}

@end
