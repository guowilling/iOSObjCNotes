//
//  SRTagRecommendCell.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRTagRecommend;

static NSString * const tagRecommendCellID = @"tagRecommendCell";

@interface SRTagRecommendCell : UITableViewCell

@property (nonatomic, strong) SRTagRecommend *tagRecommend;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
