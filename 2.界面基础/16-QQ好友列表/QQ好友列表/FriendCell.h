//
//  FriendCell.h
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"

@interface FriendCell : UITableViewCell

@property (nonatomic, strong) FriendModel *friendModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
