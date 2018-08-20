//
//  SRStatusPicturesView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRStatusPicturesView : UIView

+ (instancetype)statusPicturesView;

+ (CGSize)sizeWithCount:(NSInteger)count;

@property (nonatomic, strong) NSArray *pictures;

@end
