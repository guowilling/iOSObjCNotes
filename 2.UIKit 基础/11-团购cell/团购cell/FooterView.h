//
//  FooterView.h
//  团购cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FooterView;

@protocol FooterViewDelegate <NSObject>

@optional
- (void)tgFooterViewDidDownloadButtonClick:(FooterView *)footerView;

@end

@interface FooterView : UIView

+ (instancetype)footerView;

- (instancetype)initWithDelegate:(id)delegate;

- (void)endRefresh;

@property (nonatomic, weak) id <FooterViewDelegate> delegate;

@end
