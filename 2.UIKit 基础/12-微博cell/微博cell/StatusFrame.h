//
//  StatusFrame.h
//  微博cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Status;

#define kNameFont [UIFont systemFontOfSize:14]
#define kTextFont [UIFont systemFontOfSize:16]

@interface StatusFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect vipF;
@property (nonatomic, assign, readonly) CGRect textF;
@property (nonatomic, assign, readonly) CGRect pictureF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) Status *status;

+ (NSArray *)statusFrames;

@end
