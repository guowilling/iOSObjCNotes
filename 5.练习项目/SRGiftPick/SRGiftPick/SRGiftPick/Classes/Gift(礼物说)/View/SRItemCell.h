//
//  SRItemCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRItem;

@interface SRItemCell : UITableViewCell

@property (nonatomic, strong) SRItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
