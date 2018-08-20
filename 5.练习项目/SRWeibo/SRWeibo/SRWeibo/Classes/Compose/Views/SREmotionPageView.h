//
//  SREmotionPageView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SREmotionMaxColumns 7
#define SREmotionMaxRows    3
#define SREmotionMaxCount ((SREmotionMaxColumns * SREmotionMaxRows) -1)

@interface SREmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;

@end
