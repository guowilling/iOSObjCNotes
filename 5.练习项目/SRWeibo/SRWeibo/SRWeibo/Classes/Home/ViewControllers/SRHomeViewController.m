//
//  SRHomeViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRHomeViewController.h"
#import "SRHomeViewModel.h"
#import "SRNavBarTitleButton.h"
#import "SRDropDownMenu.h"
#import "SRMenuViewController.h"
#import "SRLoadMoreFooter.h"
#import "SRStatusCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface SRHomeViewController () <SRDropDownMenuDelegate>

@property (nonatomic, strong) SRHomeViewModel *homeVM;

@end

@implementation SRHomeViewController

#pragma mark -  Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = SRColorBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    self.homeVM = [[SRHomeViewModel alloc] init];
    
    [self setupNavBar];
    
    [self updateUserNickname];
    
    [self setupPullDownRefresh];
    
    [self setupPullUpRefresh];
    
    [self updateUnreadCount];
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self
                                                                     action:@selector(friendSearch)
                                                                   norImage:@"navigationbar_friendsearch"
                                                                  highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self
                                                                      action:@selector(scan)
                                                                    norImage:@"navigationbar_pop"
                                                                   highImage:@"navigationbar_pop_highlighted"];
    
    self.navigationItem.titleView = ({
        //SRNavBarTitleButton *titleButton = [[SRNavBarTitleButton alloc] init];
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.frame = CGRectMake(0, 0, 120, 25);
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 95, 0, 0);
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [titleButton setTitle:self.homeVM.currentUserNickname ?: @"首页" forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        titleButton;
    });
}

- (void)updateUserNickname {
    [self.homeVM updateUserAccountSuccess:^(NSString *newNickname) {
        UIButton *titleBtnView = (UIButton *)self.navigationItem.titleView;
        [titleBtnView setTitle:newNickname forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        SRLog(@"updateUserAccountWithSuccess error: %@", error);
    }];
}

#pragma mark - Refresh

- (void)setupPullDownRefresh {
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewestStatus)];
    [self.homeVM loadCachedStatusSuccess:^(NSInteger statusCount) {
        if (statusCount != 0) {
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)loadNewestStatus {
    [self.homeVM loadNewestStatusSuccess:^(NSInteger statusCount) {
        [self.tableView headerEndRefreshing];
        if (statusCount != 0) {
            [self.tableView reloadData];
            self.tabBarItem.badgeValue = [@([UIApplication sharedApplication].applicationIconBadgeNumber - statusCount) description];
            [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber - statusCount;
        }
        [self showNewStatusCount:statusCount];
    } failure:^(NSError *error) {
        SRLog(@"loadNewestStatusSuccess error: %@", error);
        [self.tableView headerEndRefreshing];
    }];
}

- (void)setupPullUpRefresh {
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
//    return;
//    SRLoadMoreFooter *footer = [SRLoadMoreFooter loadMoreFooter];
//    self.tableView.tableFooterView = footer;
//    footer.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /**
     * scrollView == self.tableView == self.view
     * scrollView 的属性:
     * contentInset : 边框尺寸, 内边距.
     * contentSize  : 具体内容, header、cell、footer. 不包括 contentInset.
     * contentOffset: scrollView 的内容超出 scrollView 顶部的距离, 不包括 contentInset.
     */
//    return;
//    if (self.homeVM.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
//        return;
//    }
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat lastOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
//    NSLog(@"offsetY: %f", offsetY);
//    NSLog(@"lastOffsetY: %f", offsetY);
//    NSLog(@"contentSize.height: %f", scrollView.contentSize.height);
//    NSLog(@"scrollView.height: %f", scrollView.height);
//    if (offsetY >= lastOffsetY) {
//        self.tableView.tableFooterView.hidden = NO;
//        [self loadMoreStatus];
//    }
}

- (void)loadMoreStatus {
    [self.homeVM loadMoreStatusSuccess:^{
        //self.tableView.tableFooterView.hidden = YES;
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        SRLog(@"loadMoreStatusSuccess error: %@", error);
        //self.tableView.tableFooterView.hidden = YES;
        [self.tableView footerEndRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeVM.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRStatusCell *cell = [SRStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.homeVM.statusFrames[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.homeVM cellHeightOfRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRLog(@"didSelectRowAtIndexPath indexPath: %@", indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Monitor method

- (void)titleButtonAction:(UIButton *)titleButton {
    SRDropDownMenu *menu = [SRDropDownMenu dropDownMenu];
    [menu showFrom:({
        menu.delegate = self;
        SRMenuViewController *menuVC = [[SRMenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
        menuVC.view.width  = 220;
        menuVC.view.height = 300;
        menu.contentVC = menuVC;
        titleButton;
    })];
}

- (void)friendSearch {
    SRLog(@"FriendSearch");
}

- (void)scan {
    SRLog(@"Scan");
}

#pragma mark - Assist Methods

- (void)showNewStatusCount:(NSInteger)count {
    [self.navigationController.view insertSubview:({
        UILabel *label = [[UILabel alloc] init];
        if (count == 0) {
            label.text = @"没有最新微博请稍后再试";
        } else {
            label.text = [NSString stringWithFormat:@"%zd条最新微博", count];
        }
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        label.width = SRScreenW;
        label.height = 30;
        label.y = 64 - label.height;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        [UIView animateWithDuration:1.0 animations:^{
            label.transform = CGAffineTransformMakeTranslation(0, label.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                label.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        label;
    }) belowSubview:self.navigationController.navigationBar];
}

- (void)updateUnreadCount {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(updateUnreadCount) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
    
    [self.homeVM updateUnreadCountSuccess:^(NSInteger unreadCount) {
        if (unreadCount != 0) {
            self.tabBarItem.badgeValue = @(unreadCount).description;
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
        } else {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    } failure:^(NSError *error) {
        SRLog(@"updateUnreadCountWithSuccess error: %@", error);
    }];
}

#pragma mark - SRDropDownMenuDelegate

- (void)dropDownMenuDidShow:(SRDropDownMenu *)dropDownMenu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

- (void)dropDownMenuDidDismiss:(SRDropDownMenu *)dropDownMenu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

@end
