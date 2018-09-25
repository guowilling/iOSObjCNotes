//
//  HMKeyboardTool.h
//  作业-注册
//
//  Created by Vincent_Guo on 14-8-27.
//  Copyright (c) 2014年 vgios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWKeyboardTool;

typedef NS_ENUM(NSInteger, KeyboardItemType) {
    KeyboardItemTypePrevious,
    KeyboardItemTypeNext,
    KeyboardItemTypeDone,
};

@protocol GWKeyboardToolDelegate <NSObject>

-(void)keyboardTool:(GWKeyboardTool *)keyboardTool didClickItemType:(KeyboardItemType)itemType;

@end

@interface GWKeyboardTool : UIView

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@property (weak, nonatomic) id<GWKeyboardToolDelegate> delgate;

+ (instancetype)keyboardTool;

@end
