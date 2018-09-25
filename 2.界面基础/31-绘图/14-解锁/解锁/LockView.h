//
//  LockView.h
//  解锁
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LockView;

@protocol LockViewDelegate <NSObject>

- (void)lockViewDidClick:(LockView *)lockView pwd:(NSString *)pwd;

@end

@interface LockView : UIView

@property (nonatomic, weak) id<LockViewDelegate> delegate;

@end
