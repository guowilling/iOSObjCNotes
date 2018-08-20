//
//  HeaderView.h
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

@class HeaderView;

@protocol HeaderViewDelegate <NSObject>

@required
- (void)headerViewDidClickHeaderView:(HeaderView *)headerView;

@end

@interface HeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) GroupModel *groupModel;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

@end
