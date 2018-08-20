//
//  SRDropDownMenu.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRDropDownMenu;

@protocol SRDropDownMenuDelegate <NSObject>

- (void)dropDownMenuDidShow:(SRDropDownMenu *)dropDownMenu;
- (void)dropDownMenuDidDismiss:(SRDropDownMenu *)dropDownMenu;

@end

@interface SRDropDownMenu : UIView

@property (nonatomic, strong) UIViewController *contentVC;

@property (nonatomic, weak) id<SRDropDownMenuDelegate> delegate;

+ (instancetype)dropDownMenu;

- (void)showFrom:(UIView *)fromView;

- (void)dismiss;

@end
