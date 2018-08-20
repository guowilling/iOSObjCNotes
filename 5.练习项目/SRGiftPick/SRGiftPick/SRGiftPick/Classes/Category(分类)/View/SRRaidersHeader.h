//
//  GPRaiderHeaderView.h
//  礼物说
//
//  Created by heew on 15/1/23.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRCollection, SRRaidersHeader, SRRaiderHeaderImageView;

@protocol SRRaidersHeaderDelegate <NSObject>

@optional
- (void)raiderHeader:(SRRaidersHeader *)raiderHeader didClickImageView:(SRRaiderHeaderImageView *)imageView;

@end

@interface SRRaidersHeader : UIView

@property (nonatomic, strong) NSArray *collections;

@property (nonatomic, weak) id<SRRaidersHeaderDelegate> delegate;

+ (instancetype)raiderHeaderView;

@end

@interface SRRaiderHeaderImageView : UIImageView

@property (nonatomic, strong) SRCollection *collection;

@end
