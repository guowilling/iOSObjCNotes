//
//  SREmotionPopView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SREmotion, SREmotionButton;

@interface SREmotionPopView : UIView

+ (instancetype)emotionPopView;

- (void)showFrom:(SREmotionButton *)emotionBtn;

@end
