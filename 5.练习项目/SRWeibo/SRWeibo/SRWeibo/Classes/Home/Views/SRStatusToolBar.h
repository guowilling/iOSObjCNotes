//
//  SRStatusToolBar.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRStatus;

@interface SRStatusToolBar : UIView

+ (instancetype)statusToolBar;

@property (nonatomic, strong) SRStatus *status;

@end
