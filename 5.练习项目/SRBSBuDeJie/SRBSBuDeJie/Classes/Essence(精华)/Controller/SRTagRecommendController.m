//
//  SRTagRecommendController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTagRecommendController.h"
#import "SRTagRecommend.h"
#import "SRTagRecommendCell.h"

@interface SRTagRecommendController ()

@property (nonatomic, strong) NSArray *tagRecommends;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRTagRecommendController

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadData];
}

- (void)setupTableView {
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = SRRGBColor(223, 223, 223);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = SRRandomColor;
}

- (void)loadData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.tagRecommends = [SRTagRecommend objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error :%@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tagRecommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRTagRecommendCell *cell = [SRTagRecommendCell cellWithTableView:tableView];
    cell.tagRecommend = self.tagRecommends[indexPath.row];
    return cell;
}

@end
