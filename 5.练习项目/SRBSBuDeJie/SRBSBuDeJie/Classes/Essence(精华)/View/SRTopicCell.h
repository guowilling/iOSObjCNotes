//
//  SRTopicCell.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRTopic;

@interface SRTopicCell : UITableViewCell

@property (nonatomic, strong) SRTopic *topic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

// 顶\踩\分享\评论按钮
@interface SRToolBarButton : UIButton

- (void)setTitleCount:(NSInteger)count placeholder:(NSString *)placeholder;

@end
