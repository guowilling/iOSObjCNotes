//
//  FriendCell.m
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"friendCell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setFriendModel:(FriendModel *)friendModel {
    _friendModel = friendModel;
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    self.textLabel.text = _friendModel.name;
    self.detailTextLabel.text = _friendModel.intro;
    if (friendModel.vip) {
        [self.textLabel setTextColor:[UIColor redColor]];
    } else {
        [self.textLabel setTextColor:[UIColor blackColor]];
    }
}

@end
