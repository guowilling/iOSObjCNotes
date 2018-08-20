//
//  SRCommentViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTopicDetailViewController.h"
#import "SRComment.h"
#import "SRTopicCell.h"
#import "SRCommentCell.h"
#import "SRCommentHeaderFooter.h"

@interface SRTopicDetailViewController ()

@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSArray *hotCommentArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRTopicDetailViewController

#pragma mark - Lazy load

- (NSMutableArray *)commentArray {
    
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (NSArray *)hotCommentArray {
    
    if (_hotCommentArray == nil) {
        _hotCommentArray = [NSArray array];
    }
    return _hotCommentArray;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    self.tableView.backgroundColor = SRRandomColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header beginRefreshing];
    });
}

- (void)loadNewData {
    
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消所有旧请求
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.ID;
    param[@"hot"] = @"1";
    self.page = 1;
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php"
                  parameters:param
                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                         [self.tableView.header endRefreshing];
                         
                         if (![responseObject isKindOfClass:[NSDictionary class]]) {
                             return;
                         }
                         
                         self.commentArray = [SRComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
                         self.hotCommentArray = [SRComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
                         self.page++;
                         
                         [self.tableView reloadData];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         [self.tableView.header endRefreshing];
                     }];
}

- (void)loadMoreData {
    
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.ID;
    param[@"hot"] = @"1";
    SRComment *comment = [self.commentArray lastObject];
    param[@"lastcid"] = comment.ID;
    param[@"page"] = @(self.page);
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php"
                  parameters:param
                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                         [self.tableView.footer endRefreshing];
                         
                         if (![responseObject isKindOfClass:[NSDictionary class]]) {
                             return;
                         }
                         
                         [self.commentArray addObjectsFromArray:[SRComment objectArrayWithKeyValuesArray:responseObject[@"data"]]];
                         [self.tableView reloadData];
                         self.page++;
                         
                         if (self.commentArray.count == [responseObject[@"total"] integerValue]) {
                             [self.tableView.footer noticeNoMoreData];
                         }
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         [self.tableView.footer endRefreshing];
                     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.hotCommentArray.count > 0) {
        return 3;
    } else if (self.commentArray.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.hotCommentArray.count > 0) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return self.hotCommentArray.count;
        } else {
            return self.commentArray.count;
        }
    } else if (self.commentArray.count > 0) {
        if (section == 0) {
            return 1;
        } else {
            return self.commentArray.count;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.hotCommentArray.count > 0) {
        if (indexPath.section == 0) {
            SRTopicCell *cell = [SRTopicCell cellWithTableView:tableView];
            cell.topic = self.topic;
            return cell;
        } else if (indexPath.section == 1) {
            SRCommentCell *cell = [SRCommentCell cellWithTableView:tableView];
            SRComment *comment = self.hotCommentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        } else {
            SRCommentCell *cell = [SRCommentCell cellWithTableView:tableView];
            SRComment *comment = self.commentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        }
    } else if (self.commentArray.count > 0) {
        if (indexPath.section == 0) {
            SRTopicCell *cell = [SRTopicCell cellWithTableView:tableView];
            cell.topic = self.topic;
            return cell;
        } else {
            SRCommentCell *cell = [SRCommentCell cellWithTableView:tableView];
            SRComment *comment = self.commentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        }
    } else {
        SRTopicCell *cell = [SRTopicCell cellWithTableView:tableView];
        cell.topic = self.topic;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    } else {
        return 18;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.hotCommentArray.count > 0) {
        if (section == 0) {
            return nil;
        } else if (section == 1) {
            SRCommentHeaderFooter *headerFooter = [SRCommentHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"热门评论";
            return headerFooter;
        } else {
            SRCommentHeaderFooter *headerFooter = [SRCommentHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"最新评论";
            return headerFooter;
        }
    } else if (self.commentArray.count > 0) {
        if (section == 0) {
            return nil;
        } else {
            SRCommentHeaderFooter *headerFooter = [SRCommentHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"最新评论";
            return headerFooter;
        }
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRCommentCell *cell = (SRCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[ding, replay, report];
    CGRect rect = CGRectMake(0, cell.sr_height * 0.5, cell.sr_width, cell.sr_height * 0.5);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
}

- (void)ding:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SRLog(@"%@",indexPath);
}

- (void)replay:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SRLog(@"%@",indexPath);
}

- (void)report:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SRLog(@"%@",indexPath);
}

@end
