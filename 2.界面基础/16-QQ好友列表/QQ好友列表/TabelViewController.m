//
//  ViewController.m
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TabelViewController.h"
#import "GroupModel.h"
#import "FriendCell.h"
#import "HeaderView.h"

@interface TabelViewController () <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation TabelViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSArray *)groups {
    if (!_groups) {
        _groups = [GroupModel groups];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.groups[section] isOpen]) {
        return [[self.groups[section] friends] count]; // 展开
    }
    return 0; // 合拢
}

// 当一个cell进入视野的时候调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [FriendCell cellWithTableView:tableView];
    cell.friendModel = [self.groups[indexPath.section] friends][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
// 当一个分组进入视野的时候调用
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderView *headerView = [HeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    headerView.groupModel = self.groups[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark - HeaderViewDelegate
- (void)headerViewDidClickHeaderView:(HeaderView *)headerView {
    [self.tableView reloadData];
}

@end
