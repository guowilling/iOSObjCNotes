//
//  SRChoicenessViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRChoicenessViewController.h"
#import "SRChoicenessHeader.h"

@interface SRChoicenessViewController ()

@end

@implementation SRChoicenessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeaderView];
    
    [self setupContentInset];
}

- (void)setupHeaderView {
    SRChoicenessHeader *headerView = [SRChoicenessHeader choicenessHeader];
    UIView *containerView = [[UIView alloc] initWithFrame:headerView.frame]; // 直接设置成 tableView 的 tableHeaderView 会有显示 bug.
    containerView.sr_height += 5;
    [containerView addSubview:headerView];
    self.tableView.tableHeaderView = containerView;
}

- (void)setupContentInset {
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = 0;
    self.tableView.contentInset = insets;
}

@end
