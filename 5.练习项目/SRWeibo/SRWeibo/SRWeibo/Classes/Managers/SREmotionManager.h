//
//  SREmotionTool.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SREmotion;

@interface SREmotionManager : NSObject

+ (NSMutableArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;

+ (void)addToRectenEmotions:(SREmotion *)emotion;

+ (SREmotion *)emotionWithChs:(NSString *)chs;

@end
