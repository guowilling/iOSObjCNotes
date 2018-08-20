//
//  SRRecommendCategoryCell.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRRecommendCategory;

static NSString * const recommendCategoryCellID = @"recommendCategoryCell";

@interface SRRecommendCategoryCell : UITableViewCell

@property (nonatomic, strong) SRRecommendCategory *recommendCategory;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
