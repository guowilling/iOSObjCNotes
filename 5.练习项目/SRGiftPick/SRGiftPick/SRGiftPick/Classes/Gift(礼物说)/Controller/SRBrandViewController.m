//
//  SRBrandViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRBrandViewController.h"
#import "SRBrand.h"
#import "SRBrandCell.h"
#import "SRBrandHomeViewController.h"

@interface SRBrandViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *brands;
@property (nonatomic, copy  ) NSString *nextPageURL;

@end

@implementation SRBrandViewController

#pragma mark - Lazy load

- (NSMutableArray *)brands {
    
    if (_brands == nil) {
        _brands = [NSMutableArray array];
    }
    return _brands;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupTableView];
    
    [self setupRefresh];
}

#pragma mark- Setup UI

- (void)setupNavBar {
    
    self.title = @"品牌专区";
}

- (void)setupTableView {
    
    self.tableView.backgroundColor = SRBackgroundColor;
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(SRCellUIEdgeInsets.top, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SRBrandCell.class) bundle:nil] forCellReuseIdentifier:brandCellID];
//    self.tableView.backgroundColor = SRRandomColor;
}

- (void)setupRefresh {
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData {
    
    NSString *firstPageURL = @"https://api.liwushuo.com/v2/brands/editor?limit=20&offset=0";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:firstPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.header endRefreshing];
        self.brands = [SRBrand objectArrayWithKeyValuesArray:responseObject[@"data"][@"brands"]];
        NSString *nextPageURL = responseObject[@"data"][@"paging"][@"next_url"];
        [self.tableView reloadData];
        
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
    
    if (!self.nextPageURL || self.nextPageURL.length == 0) {
        [self.tableView.footer noticeNoMoreData];
        return;
    }
    
    [self.sessionManager GET:self.nextPageURL parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [self.brands addObjectsFromArray:[SRBrand objectArrayWithKeyValuesArray:responseObject[@"data"][@"brands"]]];
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
        [self.tableView.footer endRefreshing];
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
    
    return self.brands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:brandCellID];
    cell.brand = self.brands[indexPath.row];
    cell.bigImageViewLeft = indexPath.row % 2;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRBrandHomeViewController *brandHomeVC = [[SRBrandHomeViewController alloc] init];
    SRBrand *brand = self.brands[indexPath.row];
    brandHomeVC.ID = brand.ID;
    [self.navigationController pushViewController:brandHomeVC animated:YES];
}

@end
