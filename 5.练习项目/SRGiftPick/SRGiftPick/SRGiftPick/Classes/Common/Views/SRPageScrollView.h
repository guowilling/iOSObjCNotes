//
//  SRPageScrollView.h
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/2.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRPageScrollView;

@protocol SRPageScrollViewDelegate <NSObject>

@optional
- (void)pageScrollView:(SRPageScrollView *)pageScrollView didClickImageAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, PageControlPosition) {
    PageControlPositionBottomCenter = 0,
    PageControlPositionBottomRight
};

IB_DESIGNABLE
@interface SRPageScrollView : UIView

@property (weak, nonatomic) id<SRPageScrollViewDelegate> delegate;

@property (strong, nonatomic) NSArray *imageURLStrings;
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) IBInspectable UIColor *currentPageColor;
@property (strong, nonatomic) IBInspectable UIColor *otherPageColor;

@property (assign, nonatomic) PageControlPosition pageControlPostion;

@property (assign, nonatomic) NSTimeInterval pagingInterval;

- (void)startAutoPaging;
- (void)stopAutoPaging;

- (void)startAutoPagingWithDuration:(NSTimeInterval)pagingInterval;

@end
