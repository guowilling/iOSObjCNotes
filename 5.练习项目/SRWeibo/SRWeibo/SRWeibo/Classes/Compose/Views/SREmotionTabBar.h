//
//  SREmotionTabBar.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SREmotionTabBar, SREmotionTabBarButton;

typedef NS_ENUM(NSInteger, SREmotionTabBarButtonType) {
    SREmotionTabBarButtonRencent, // 最近
    SREmotionTabBarButtonDefault, // 默认
    SREmotionTabBarButtonEmoji,   // emoji
    SREmotionTabBarButtonLxh      // 浪小花
};

@protocol SREmotionTabBarDelegate <NSObject>

- (void)emotionTabBar:(SREmotionTabBar *)emotionTabBar didClickBtn:(SREmotionTabBarButton *)btn;

@end

@interface SREmotionTabBar : UIView

@property (nonatomic, weak) id<SREmotionTabBarDelegate> delegate;

@end
