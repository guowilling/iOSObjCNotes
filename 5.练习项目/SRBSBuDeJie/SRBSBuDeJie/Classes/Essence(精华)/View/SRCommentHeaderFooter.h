//
//  SRComentHeaderFooter.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const commentHeaderFooter = @"commentHeaderFooter";

@interface SRCommentHeaderFooter : UITableViewHeaderFooterView

+ (instancetype)HeaderFooterViewWithTableView:(UITableView *)tableview;

@property (nonatomic, strong) NSString *title;

@end

