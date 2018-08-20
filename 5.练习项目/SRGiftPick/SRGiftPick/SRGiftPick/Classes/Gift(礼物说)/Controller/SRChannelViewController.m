//
//  SRChannelViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRChannelViewController.h"
#import "SRItem.h"
#import "SRItemCell.h"
#import "SRGuideDetailViewController.h"
#import "SRRefreshGiftHeader.h"

@interface SRChannelViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, copy  ) NSString *nextPageURL;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation SRChannelViewController

#pragma mark - Lazy Load

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 15.0;
    }
    return _sessionManager;
}

#pragma mark - Lifecycle

- (instancetype)init {
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}

#pragma mark - Setup UI

- (void)setupTableView {
    self.tableView.backgroundColor = SRBackgroundColor;
    self.tableView.rowHeight = 175;
    self.tableView.contentInset = UIEdgeInsetsMake(SRCellUIEdgeInsets.top, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupRefresh {
    self.tableView.header = [SRRefreshGiftHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData {
    if (!self.firstPageURL) {
        [self.tableView.header endRefreshing];
        return;
    }
    [self.sessionManager GET:self.firstPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.tableView.header endRefreshing];
        
        self.items = [SRItem objectArrayWithKeyValuesArray:responseObject[@"data"][self.dataName]];
        [self.tableView reloadData];
        
        NSString *nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
        if ([nextPageURL isKindOfClass:[NSNull class]]) {
            self.nextPageURL = nil;
        } else {
            self.nextPageURL = nextPageURL;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData {
    if (!self.nextPageURL) {
        [self.tableView.footer noticeNoMoreData];
        return;
    }
    [self.sessionManager GET:self.nextPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.items addObjectsFromArray:[SRItem objectArrayWithKeyValuesArray:responseObject[@"data"][self.dataName]]];
        [self.tableView reloadData];
        
        NSString *nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
        if ([nextPageURL isKindOfClass:[NSNull class]]) {
            self.nextPageURL = nil;
        } else {
            self.nextPageURL = nextPageURL;
        }
        
        [self checkFooter];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [self checkFooter];
    }];
}

- (void)checkFooter {
    if (self.nextPageURL) {
        [self.tableView.footer endRefreshing];
    } else {
        [self.tableView.footer noticeNoMoreData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRItemCell *cell = [SRItemCell cellWithTableView:tableView];
    cell.item = self.items[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRGuideDetailViewController *guideDetailVC = [[SRGuideDetailViewController alloc] init];
    SRItem *item = self.items[indexPath.row];
    guideDetailVC.ID = item.ID;
    [self.navigationController pushViewController:guideDetailVC animated:YES];
}

@end
