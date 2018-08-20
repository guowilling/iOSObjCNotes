//
//  SRCommentViewController.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRTopic;

@interface SRTopicDetailViewController : UITableViewController

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) SRTopic *topic;

@end
