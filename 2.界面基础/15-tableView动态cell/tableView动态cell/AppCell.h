//
//  AppCell.h
//  tableView动态cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"

@class AppCell;

@protocol AppModelDelegate <NSObject>

@required
- (void)appCellDidClickDownloadBtn:(AppCell *)appCell;

@end

@interface AppCell : UITableViewCell

@property (nonatomic, strong) AppModel *appModel;

@property (nonatomic, weak) id<AppModelDelegate> delegate;

@end
