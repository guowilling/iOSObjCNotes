//
//  SRDetailTopView.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRSearchGift, SRPageScrollView;

@interface SRDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet SRPageScrollView *pageScrollView;

@property (nonatomic, strong) SRSearchGift *gift;

+ (instancetype)detailTopView;

@end
