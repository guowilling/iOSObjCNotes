//
//  TgCell.h
//  团购cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TgModel;

@interface TgCell : UITableViewCell

@property (nonatomic, strong) TgModel *tgModel;

+ (TgCell *)tgCellWithTableView:(UITableView *)tableView;

@end
