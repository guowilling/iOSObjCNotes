//
//  SRFriendsRecommendController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRFriendsRecommendController.h"
#import "SRRecommendCategory.h"
#import "SRRecommendUserDelegate.h"
#import "SRRecommendUser.h"
#import "SRRecommendCategoryCell.h"

@interface SRFriendsRecommendController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSArray *categerys;
@property (nonatomic, strong) SRRecommendCategory *recommendCategory;
@property (nonatomic, strong) SRRecommendUserDelegate *recommendUserDelegate;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRFriendsRecommendController

#pragma mark - Lazy load

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (SRRecommendUserDelegate *)recommendUserDelegate {
    
    if (_recommendUserDelegate == nil) {
        _recommendUserDelegate = [[SRRecommendUserDelegate alloc] init];
    }
    return _recommendUserDelegate;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTableView];
    
    [self loadCategorysData];
}

- (void)setupTableView {
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.categoryTableView.showsHorizontalScrollIndicator = NO;
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    self.categoryTableView.backgroundColor = SRRGBColor(244, 244, 244);
//    self.categoryTableView.backgroundColor = SRRandomColor;
    
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.backgroundColor = SRRGBColor(244, 244, 244);
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.dataSource = self.recommendUserDelegate;
    self.userTableView.delegate = self.recommendUserDelegate;
    self.userTableView.rowHeight = 60;
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.footer.hidden = YES;
//    self.userTableView.backgroundColor = SRRandomColor;
}

- (void)loadCategorysData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.categerys = [SRRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.userTableView.header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)loadNewUsers {
    
    SRRecommendCategory *recommendCategory = self.categerys[[self.categoryTableView indexPathForSelectedRow].row];
    self.recommendCategory = recommendCategory;
    
    self.recommendUserDelegate.recommendCategory = self.recommendCategory;
    [self.recommendCategory.users removeAllObjects];
    self.recommendCategory.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = self.recommendCategory.ID;
    params[@"page"] = @(self.recommendCategory.currentPage);
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.userTableView.header endRefreshing];
        [self.userTableView.header setHidden:YES];
        [self.recommendCategory.users addObjectsFromArray:[SRRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.recommendCategory.total = [responseObject[@"total"] integerValue];
        [self.userTableView reloadData];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [self.userTableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)loadMoreUsers {
    
    //self.recommendCategory.currentPage++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = self.recommendCategory.ID;
    params[@"page"] = @(++self.recommendCategory.currentPage);
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.recommendCategory.users addObjectsFromArray:[SRRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [self.userTableView reloadData];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"%@", error);
        [self.userTableView.footer endRefreshing];
        [SVProgressHUD showWithStatus:@"网络错误"];
    }];
}

- (void)checkFooterState {
    
    if (self.recommendCategory.users.count == self.recommendCategory.total) {
        [self.userTableView.footer endRefreshing];
        [self.userTableView.footer setHidden:NO];
        [self.userTableView.footer noticeNoMoreData];
    } else {
        [self.userTableView.footer endRefreshing];
        [self.userTableView.footer setHidden:NO];
        [self.userTableView.footer resetNoMoreData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categerys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRRecommendCategoryCell *cell = [SRRecommendCategoryCell cellWithTableView:tableView];
    SRRecommendCategory *recommendCategory = self.categerys[indexPath.row];
    cell.recommendCategory = recommendCategory;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRRecommendCategory *recommendCategory = self.categerys[indexPath.row];
    self.recommendCategory = recommendCategory;
    self.recommendUserDelegate.recommendCategory = self.recommendCategory;
    [self.userTableView reloadData];
    [self checkFooterState];
    
    if (self.recommendCategory.users.count != 0) {
        return;
    }
    [self.userTableView.header setHidden:NO];
    [self.userTableView.footer setHidden:YES];
    [self.userTableView.header beginRefreshing];
}

@end
