//
//  SRMeViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRMeViewController.h"
#import "SRMeCell.h"

@interface SRMeViewController ()

@end

@implementation SRMeViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRMeCell *cell = [SRMeCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
        cell.textLabel.text = @"登陆/注册";
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

@end
