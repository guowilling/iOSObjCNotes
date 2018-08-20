//
//  SRCommentCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRComment;

@interface SRCommentCell : UITableViewCell

@property (nonatomic, strong) SRComment *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
