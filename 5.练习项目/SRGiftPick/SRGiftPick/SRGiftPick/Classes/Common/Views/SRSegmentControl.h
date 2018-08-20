//
//  SRBrandHomeSegment.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSegmentControl : UIView

+ (instancetype)segmentControl;

@property (nonatomic, copy) NSString *ltTitle;
@property (nonatomic, copy) NSString *rtTitle;

- (void)ltSegementAddTarget:(id)target selector:(SEL)action forControlEvents:(UIControlEvents )controlEvents;
- (void)rtSegementAddTarget:(id)target selector:(SEL)action forControlEvents:(UIControlEvents )controlEvents;

@end
