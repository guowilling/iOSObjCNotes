//
//  SRDetailSegmentView.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRSearchGift;

@interface SRDetailSegmentView : UIView

@property (nonatomic, strong) SRSearchGift *gift;

+ (instancetype)detailSegmentView;

- (void)ltSegementAddTarget:(id)target selector:(SEL)action forcontrolEvents:(UIControlEvents)controlEvents;
- (void)rtSegementAddTarget:(id)target selector:(SEL)action forcontrolEvents:(UIControlEvents)controlEvents;

@end
