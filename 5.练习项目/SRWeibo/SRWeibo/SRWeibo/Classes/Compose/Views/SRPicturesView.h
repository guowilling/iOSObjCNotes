//
//  SRPicturesView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRPicturesView : UIView

+ (instancetype)picturesView;

- (void)addPicture:(UIImage *)picture;

@property (nonatomic, strong, readonly) NSMutableArray *pictures;

@end
