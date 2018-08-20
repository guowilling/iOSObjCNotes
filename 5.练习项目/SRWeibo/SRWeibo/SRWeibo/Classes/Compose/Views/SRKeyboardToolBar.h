//
//  SRKeyboardToolBar.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRKeyboardToolBar;

typedef NS_ENUM(NSInteger, SRKeyboardToolBarButtonType) {
    SRKeyboardToolBarButtonTypeCamera,  // 相机
    SRKeyboardToolBarButtonTypeAlbum,   // 相册
    SRKeyboardToolBarButtonTypeMention, // @
    SRKeyboardToolBarButtonTypeTrend,   // #
    SRKeyboardToolBarButtonTypeEmotion  // 表情
};

@protocol SRKeyboardToolBarDelegate <NSObject>
- (void)keyboardToolBar:(SRKeyboardToolBar *)toolBar didClickBtn:(SRKeyboardToolBarButtonType)type;

@end

@interface SRKeyboardToolBar : UIView

+ (instancetype)keyboardToolBar;

- (void)showKeyboardBtn:(BOOL)show;

@property (nonatomic, weak) id<SRKeyboardToolBarDelegate> delegate;

@end
