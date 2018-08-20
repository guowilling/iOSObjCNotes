//
//  SRGuideDetailToolBar.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRGuideDetail, SRGuideDetailToolBar;

@protocol SRGuideDetailToolBarDelegate <NSObject>

- (void)guideDetailToolBar:(SRGuideDetailToolBar *)guideDetailToolBar didClickShareBtn:(UIButton *)shareBtn;

@end

@interface SRGuideDetailToolBar : UIView

+ (instancetype)guideDetailToolBar;

@property (nonatomic, strong) SRGuideDetail *guideDetail;

@property (nonatomic, weak) id<SRGuideDetailToolBarDelegate> delegate;

@end
