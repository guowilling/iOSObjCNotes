//
//  SREmotionTool.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionManager.h"
#import "SREmotion.h"
#import "MJExtension.h"

#define SRRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] \
                             stringByAppendingPathComponent:@"recentEmotions.data"]

@implementation SREmotionManager

static NSMutableArray *_recentEmotions;

+ (void)initialize {
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:SRRecentEmotionsPath];
    if (!_recentEmotions) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (NSMutableArray *)recentEmotions {
    return _recentEmotions;
}

+ (void)addToRectenEmotions:(SREmotion *)emotion {
    for (SREmotion *emo in _recentEmotions) {
        if ([emo isEqual:emotion]) {
            return;
        }
    }
    
    [_recentEmotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:SRRecentEmotionsPath];
}

static NSArray *_defaultEmotions, *_emojiEmotions, *_lxhEmotions;

+ (NSArray *)defaultEmotions {
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _defaultEmotions = [SREmotion objectArrayWithKeyValuesArray:dictArray];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions {
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _emojiEmotions = [SREmotion objectArrayWithKeyValuesArray:dictArray];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions {
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _lxhEmotions = [SREmotion objectArrayWithKeyValuesArray:dictArray];
    }
    return _lxhEmotions;
}

+ (SREmotion *)emotionWithChs:(NSString *)chs {
    NSArray *defaultEmotions = [self defaultEmotions];
    for (SREmotion *emotion in defaultEmotions) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    NSArray *lxhEmotions = [self lxhEmotions];
    for (SREmotion *emotion in lxhEmotions) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    return nil;
}

@end
