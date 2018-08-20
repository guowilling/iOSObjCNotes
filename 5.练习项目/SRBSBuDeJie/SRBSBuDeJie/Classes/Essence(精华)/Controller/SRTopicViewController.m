//
//  SRTopicViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTopicViewController.h"
#import "SRTopicCell.h"
#import "SRNewViewController.h"
#import "SRTopicDetailViewController.h"

@interface SRTopicViewController ()

@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, copy  ) NSString *maxtime;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRTopicViewController

- (NSMutableArray *)topics {
    
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = SRScreenBounds;
//    self.view.backgroundColor = SRRandomColor;
    
    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView.backgroundColor = SRRGBColor(223, 223, 223);
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 44, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.estimatedRowHeight = 250;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData:)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData:)];
    [self.tableView.header beginRefreshing];
//    self.tableView.backgroundColor = SRRandomColor;
}

- (void)loadData:(MJRefreshComponent *)refreshComponent {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self a];
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    if ([refreshComponent isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        if (self.maxtime) {
            params[@"maxtime"] = self.maxtime;
        }
        params[@"page"] = @(self.page++);
    } else {
        self.page = 0;
        params[@"page"] = @(self.page);
    }
    
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php"
                  parameters:params
                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                         [refreshComponent endRefreshing];
                         
                         if (self.page == 0) {
                             [self.topics removeAllObjects];
                         }
                         [self.topics addObjectsFromArray:[SRTopic objectArrayWithKeyValuesArray:responseObject[@"list"]]];
                         [self setMaxtime:responseObject[@"info"][@"maxtime"]];
                         
                         [self.tableView reloadData];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         SRLog(@"error: %@", error);
                         [refreshComponent endRefreshing];
                         [SVProgressHUD showErrorWithStatus:@"网络错误"];
                     }];
}

- (NSString *)a {
    
    SRLog(@"%@", self.parentViewController);
    return [self.parentViewController isKindOfClass:[SRNewViewController class]] ? @"newlist" : @"list";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRTopicCell *cell = [SRTopicCell cellWithTableView:tableView];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SRTopicDetailViewController *topicDetailVC = [[SRTopicDetailViewController alloc] init];
    SRTopic *topic = self.topics[indexPath.row];
    topicDetailVC.topic = topic;
    topicDetailVC.ID = topic.ID;
    [self.navigationController pushViewController:topicDetailVC animated:YES];
}

@end
