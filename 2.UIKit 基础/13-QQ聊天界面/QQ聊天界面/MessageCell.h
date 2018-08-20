//
//  MessageCell.h
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageFrameModel;

@interface MessageCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, strong) MessageFrameModel *messageFrame;

@end
