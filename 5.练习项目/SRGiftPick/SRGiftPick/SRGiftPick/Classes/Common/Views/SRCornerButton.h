//
//  SRButton.h
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/2.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface SRCornerButton : UIButton

/** 圆角半径 */
@property (assign, nonatomic) CGFloat cornerRadius;

/** 圆角边框颜色 */
@property (strong, nonatomic) UIColor *cornerColor;

/** 圆角背景颜色 */
@property (strong, nonatomic) UIColor *cornerBackgroundColor;

@end
