//
//  SRStatusPictureView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRPicture;

@interface SRStatusPictureView : UIImageView

@property (nonatomic, strong) SRPicture *picture;

+ (instancetype)pictureView;

@end
