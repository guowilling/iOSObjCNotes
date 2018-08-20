//
//  SRRecommendUserCell.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRRecommendUser;

static NSString * const recommendUserCellID = @"recommendUserCell";

@interface SRRecommendUserCell : UITableViewCell

@property (nonatomic, strong) SRRecommendUser *user;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
