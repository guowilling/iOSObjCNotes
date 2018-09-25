//
//  AddViewController.h
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@required
- (void)addViewControllerDidClickAddBtn:(AddViewController *)addViewController contact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end
