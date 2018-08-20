//
//  PaletteView.h
//  画画板
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaletteView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *color;

- (void)clear;
- (void)back;

@end
