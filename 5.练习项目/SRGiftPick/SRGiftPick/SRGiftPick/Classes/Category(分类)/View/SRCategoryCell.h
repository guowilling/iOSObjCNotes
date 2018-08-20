//
//  SRCategoryCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRCategory;

static NSString * const categoryCellID = @"categoryCellID";

@interface SRCategoryCell : UITableViewCell

@property (nonatomic, strong) SRCategory *category;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
