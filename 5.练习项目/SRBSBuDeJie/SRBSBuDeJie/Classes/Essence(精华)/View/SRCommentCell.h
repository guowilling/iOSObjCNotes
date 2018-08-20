//
//  SRCommentCell.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRComment;

static NSString * const commentCell = @"commentCell";

@interface SRCommentCell : UITableViewCell

@property (nonatomic, strong) SRComment *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
