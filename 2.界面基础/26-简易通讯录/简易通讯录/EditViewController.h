//
//  EditViewController.h
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, EditViewController;

@protocol EditViewControllerDelegate <NSObject>

- (void)editViewControllerDidClickSaveBtn:(EditViewController *)editViewController contact:(Contact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end
