//
//  SRRecommendUserDelegate.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRRecommendCategory;

@interface SRRecommendUserDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SRRecommendCategory *recommendCategory;

@end
