//
//  contactCell.h
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) Contact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
